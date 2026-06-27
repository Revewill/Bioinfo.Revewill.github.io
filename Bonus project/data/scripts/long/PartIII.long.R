suppressPackageStartupMessages({
    library(data.table)
    library(caret)
    library(openxlsx)
    library(xgboost)
    library(pROC)
    library(pheatmap)
    library(gprofiler2)
    library(ggplot2)
})

# 1. Read matrix
expr_scaled <- fread(
    "/root/exSEEK/result/P2/long.scaled.txt",
    data.table = FALSE
)
rownames(expr_scaled) <- expr_scaled[,1]
expr_scaled <- expr_scaled[,-1]

logcpm_matrix <- fread(
    "/root/exSEEK/result/P2/long.logcpm.matrix.txt",
    data.table = FALSE
)
rownames(logcpm_matrix) <- logcpm_matrix[,1]
logcpm_matrix <- logcpm_matrix[,-1]

meta <- fread(
    "/root/exSEEK/result/P2/long.metadata.txt",
    data.table = FALSE
)
meta$class <- ifelse(meta$label == "NC", "Healthy", "Cancer")
meta$class <- factor(meta$class, levels = c("Healthy", "Cancer"))

# 2. Divide between train/test sets
set.seed(42)
train_index <- createDataPartition(
    y = meta$class,
    p = 0.7,
    list = FALSE
)

X_train <- expr_scaled[train_index, ]
X_test <- expr_scaled[-train_index, ]

y_train <- meta$class[train_index]
y_test <- meta$class[-train_index]

meta_train <- meta[train_index, ]
meta_test <- meta[-train_index, ]

# 3. Feature selection via filter
p_values <- numeric(ncol(X_train))
names(p_values) <- colnames(X_train)

for (i in 1:ncol(X_train)) {
    cancer_expr <- X_train[y_train == "Cancer", i]
    healthy_expr <- X_train[y_train == "Healthy", i]
    test_result <- t.test(cancer_expr, healthy_expr, alternative = "two.sided")
    p_values[i] <- test_result$p.value
}

p_values_sorted <- sort(p_values)
sig_genes <- names(p_values[p_values < 0.05])

top_n_list <- list(
    top_50 = names(p_values_sorted[1:50]),
    top_100 = names(p_values_sorted[1:100]),
    top_200 = names(p_values_sorted[1:200]),
    top_500 = names(p_values_sorted[1:500]),
    top_1000 = names(p_values_sorted[1:1000])
)
pvalue_df <- data.frame(
    gene = names(p_values_sorted),
    p_value = p_values_sorted,
    rank = 1:length(p_values_sorted)
)
write.table(
    pvalue_df,
    "/root/exSEEK/result/P3/long/filter.pvalues.all.txt",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)

feature_counts <- c(1:10, 20, 30, 50, 100, 200)
feature_lists <- list()

for (n in feature_counts) {
    feature_lists[[paste0("top", n)]] <- data.frame(
        rank = 1:n,
        gene = names(p_values_sorted[1:n]),
        p_value = p_values_sorted[1:n]
    )
}
write.xlsx(feature_lists, "/root/exSEEK/result/P3/long/feature.lists.xlsx")

# 4. AUC v feature count
y_train_num <- ifelse(y_train == "Cancer", 1, 0)
y_test_num <- ifelse(y_test == "Cancer", 1, 0)

params <- list(
    objective = "binary:logistic",
    eval_metric = "auc",
    max_depth = 6,
    eta = 0.1,
    subsample = 0.8,
    colsample_bytree = 0.8,
    min_child_weight = 1,
    scale_pos_weight = sum(y_train_num == 0) / sum(y_train_num == 1)
)

feature_counts <- c(1:10, 20, 30, 50, 100, 200, 500, 1000)
auc_curve <- numeric(length(feature_counts))

for (i in seq_along(feature_counts)) {
    n <- feature_counts[i]
    genes <- names(p_values_sorted[1:n])
    
    X_train_sub <- as.matrix(X_train[, genes])
    X_test_sub <- as.matrix(X_test[, genes])
    
    dtrain_sub <- xgb.DMatrix(data = X_train_sub, label = y_train_num)
    dtest_sub <- xgb.DMatrix(data = X_test_sub, label = y_test_num)
    
    set.seed(42)
    cv_sub <- xgb.cv(
        params = params,
        data = dtrain_sub,
        nrounds = 200,
        nfold = 5,
        early_stopping_rounds = 20,
        verbose = 0,
        prediction = FALSE
    )
    
    best_idx <- which.max(cv_sub$evaluation_log$test_auc_mean)
    auc_curve[i] <- max(cv_sub$evaluation_log$test_auc_mean)
}

pdf("/root/exSEEK/result/P3/long/AUC.v.features.pdf", width = 8, height = 6)
log_features <- log2(feature_counts)

plot(log_features, auc_curve, type = "b", pch = 19, col = "blue",
     xlab = "Number of Features (log2 scale)", ylab = "AUC",
     main = "AUC vs Number of Features",
     ylim = c(0.7, 1.0), xaxt = "n")

axis(1, at = log_features, labels = feature_counts)
grid()

best_idx <- which.max(auc_curve)
points(log_features[best_idx], auc_curve[best_idx], col = "red", pch = 19, cex = 1.5)
text(log_features[best_idx], auc_curve[best_idx] - 0.02, 
     labels = paste0("Best: ", feature_counts[best_idx]), col = "red", cex = 0.9)

dev.off()

# 5. Model training: XGBoost
top200_genes <- names(p_values_sorted[1:200])

X_train_top <- X_train[, top200_genes]
X_test_top <- X_test[, top200_genes]

X_train_matrix <- as.matrix(X_train_top)
X_test_matrix <- as.matrix(X_test_top)

dtrain <- xgb.DMatrix(data = X_train_matrix, label = y_train_num)
dtest <- xgb.DMatrix(data = X_test_matrix, label = y_test_num)

set.seed(42)
cv_result <- xgb.cv(
    params = params,
    data = dtrain,
    nrounds = 200,
    nfold = 5,
    early_stopping_rounds = 20,
    verbose = 1,
    prediction = FALSE
)

eval_log <- cv_result$evaluation_log
best_auc <- max(eval_log$test_auc_mean)
best_nrounds <- which.max(eval_log$test_auc_mean)

set.seed(42)
xgb_model <- xgb.train(
    params = params,
    data = dtrain,
    nrounds = best_nrounds,
    verbose = 1
)

pred_prob <- predict(xgb_model, dtest)
pred_class <- ifelse(pred_prob > 0.5, "Cancer", "Healthy")
pred_class <- factor(pred_class, levels = c("Healthy", "Cancer"))

cm_xgb <- confusionMatrix(pred_class, y_test)

roc_xgb <- roc(y_test, pred_prob)
auc_xgb <- auc(roc_xgb)

pdf("/root/exSEEK/result/P3/long/ROC.curve.pdf", width = 6, height = 6)
plot(roc_xgb, main = paste("ROC Curve (AUC =", round(auc_xgb, 3), ")"),
     col = "#E67E22", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "gray")
legend("bottomright", legend = paste("AUC =", round(auc_xgb, 3)), 
       col = "#E67E22", lwd = 2, bty = "n")
dev.off()

# 6. Heatmap of top features
expr_heat <- logcpm_matrix[top200_genes, rownames(X_test)]
expr_heat <- t(expr_heat)

annotation_df <- data.frame(
    Class = y_test
)
rownames(annotation_df) <- rownames(expr_heat)

healthy_idx <- which(y_test == "Healthy")
cancer_idx <- which(y_test == "Cancer")
sample_order <- c(healthy_idx, cancer_idx)

expr_heat <- expr_heat[sample_order, ]
annotation_df <- annotation_df[sample_order, , drop = FALSE]

ann_colors <- list(
    Class = c(Healthy = "#2E9FDF", Cancer = "#E67E22")
)

pdf("/root/exSEEK/result/P3/long/heatmap.top200.pdf", width = 10, height = 8)
pheatmap(
    expr_heat,
    scale = "column",
    clustering_distance_rows = "euclidean",
    clustering_distance_cols = "euclidean",
    clustering_method = "complete",
    annotation_row = annotation_df,
    annotation_colors = ann_colors,
    show_rownames = FALSE,
    show_colnames = FALSE,
    main = "Top 200 Genes - Healthy vs Cancer (Grouped by Class)",
    fontsize = 10,
    cluster_rows = FALSE,
    cluster_cols = TRUE
)
dev.off()

# 7. Function analysis
top200_genes_clean <- sub("\\..*", "", top200_genes)

gost_results <- gost(
    query = top200_genes_clean,
    organism = "hsapiens",
    sources = c("GO", "KEGG", "REAC"),
    user_threshold = 0.05,
    correction_method = "g_SCS",
    evcodes = TRUE
)
results_df <- gost_results$result

results_df_clean <- results_df
results_df_clean$evidence_codes <- sapply(results_df_clean$evidence_codes, paste, collapse = ";")
results_df_clean$parents <- sapply(results_df_clean$parents, paste, collapse = ";")

write.table(
    results_df_clean,
    "/root/exSEEK/result/P3/long/gost.results.txt",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)

top20 <- results_df[order(results_df$p_value), ][1:20, ]
top20$term_name <- factor(top20$term_name, levels = rev(top20$term_name))

pdf("/root/exSEEK/result/P3/long/gost.top20.bubble.pdf", width = 10, height = 7)
ggplot(top20, aes(x = -log10(p_value), y = term_name)) +
    geom_point(aes(size = intersection_size, color = source)) +
    scale_color_manual(values = c(
        "GO:BP" = "#8E44AD",
        "GO:CC" = "#27AE60",
        "REAC" = "#2E9FDF"
    )) +
    theme_minimal() +
    labs(
        title = "Top 20 Enriched GO Terms",
        x = "-log10(p-value)",
        y = "",
        size = "Gene Count",
        color = "Source"
    ) +
    theme(legend.position = "right")
dev.off()
