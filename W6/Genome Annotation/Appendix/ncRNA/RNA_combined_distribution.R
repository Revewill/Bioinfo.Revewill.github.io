library(ggplot2)
library(dplyr)
library(grid)
library(gridExtra)
library(cowplot)

# Data for major RNA types
major_rna <- data.frame(
  Type = c("lncRNA", "Pseudogene", "Small RNA", "Immune Receptor"),
  Count = c(34880, 13374, 4776, 649)
)
major_rna$Percentage <- round(major_rna$Count / sum(major_rna$Count) * 100, 1)

# Data for small RNA subtypes
small_rna <- data.frame(
  Subtype = c("snRNA", "miRNA", "snoRNA", "scaRNA", "sRNA"),
  Count = c(1901, 1879, 942, 49, 5)
)
small_rna$Percentage <- round(small_rna$Count / sum(small_rna$Count) * 100, 1)

# Arrange by percentage descending (largest first)
major_rna <- major_rna %>% arrange(desc(Percentage))
small_rna <- small_rna %>% arrange(desc(Percentage))

# Convert Type and Subtype to factors to maintain order
major_rna$Type <- factor(major_rna$Type, levels = major_rna$Type)
small_rna$Subtype <- factor(small_rna$Subtype, levels = small_rna$Subtype)

# Define colors (order matches the factor levels)
major_colors <- c(
  "lncRNA" = "#4CAF50",
  "Pseudogene" = "#FF9800", 
  "Small RNA" = "#2196F3",
  "Immune Receptor" = "#9C27B0"
)

small_colors <- c(
  "snRNA" = "#E91E63",
  "miRNA" = "#00BCD4",
  "snoRNA" = "#FFC107",
  "scaRNA" = "#8BC34A",
  "sRNA" = "#FF5722"
)

# Plot 1: Major RNA types
p1 <- ggplot(major_rna, aes(x = "", y = Percentage, fill = Type)) +
  geom_bar(stat = "identity", width = 0.4, color = "white", linewidth = 1) +
  geom_text(aes(label = ifelse(Percentage >= 20, sprintf("%.1f%%", Percentage), "")),
            position = position_stack(vjust = 0.5), size = 4.5, fontface = "bold", color = "white") +
  scale_fill_manual(values = major_colors, name = "RNA Type") +
  labs(title = "Major RNA Types Distribution",
       subtitle = paste("Total:", format(sum(major_rna$Count), big.mark = ","), "transcripts"),
       x = NULL, y = "Percentage (%)") +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 11),
    legend.text = element_text(size = 10),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14, margin = margin(b = 5)),
    plot.subtitle = element_text(hjust = 0.5, size = 11, color = "gray50", margin = margin(b = 15)),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_text(size = 11, face = "bold", margin = margin(t = 8)),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 15, r = 20, b = 15, l = 20)
  ) +
  coord_flip() +
  ylim(0, 100)

# Plot 2: Small RNA subtypes
p2 <- ggplot(small_rna, aes(x = "", y = Percentage, fill = Subtype)) +
  geom_bar(stat = "identity", width = 0.4, color = "white", linewidth = 1) +
  geom_text(aes(label = ifelse(Percentage >= 14, sprintf("%.1f%%", Percentage), "")),
            position = position_stack(vjust = 0.5), size = 4.5, fontface = "bold", color = "white") +
  scale_fill_manual(values = small_colors, name = "RNA Type") +
  labs(title = "Small RNA Subtypes Distribution",
       subtitle = paste("Total:", format(sum(small_rna$Count), big.mark = ","), "transcripts"),
       x = NULL, y = "Percentage (%)") +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 11),
    legend.text = element_text(size = 10),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14, margin = margin(b = 5)),
    plot.subtitle = element_text(hjust = 0.5, size = 11, color = "gray50", margin = margin(b = 15)),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_text(size = 11, face = "bold", margin = margin(t = 8)),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 15, r = 20, b = 15, l = 20)
  ) +
  coord_flip() +
  ylim(0, 100)

# Arrange plots vertically with spacing
combined <- grid.arrange(
  p1, p2,
  nrow = 2,
  heights = c(1, 1)
)

# Save to working directory
ggsave("RNA_combined_distribution.png", combined, width = 8, height = 8, dpi = 300)

cat("\n========================================\n")
cat("Visualization complete!\n")
cat("========================================\n\n")
cat("Files saved to working directory:\n")
cat("  - RNA_combined_distribution.png\n\n")