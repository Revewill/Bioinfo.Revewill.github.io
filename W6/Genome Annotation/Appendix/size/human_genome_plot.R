library(ggplot2)

# Create dataframe
main_data <- data.frame(
  component = c("Chromosomes\n(1–22, X, Y)", "Other"),
  length_bp = c(3088269830, 177115660),
  stringsAsFactors = FALSE
)

# Percentage and labels
main_data$percentage <- main_data$length_bp / sum(main_data$length_bp) * 100
main_data$label <- paste0(main_data$component, "\n", 
                          round(main_data$length_bp/1e9, 2), " Gb\n(", 
                          round(main_data$percentage, 1), "%)")

# Create figure with ggplot2
plot <- ggplot(main_data, aes(x = "", y = length_bp, fill = component)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y", start = 0) +
  scale_fill_manual(values = c("#4A90E2", "#E8A735")) +
  geom_text(aes(label = label), 
            position = position_stack(vjust = 0.5),
            size = 4.5, fontface = "bold") +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14)) +
  ggtitle("Human genome GRCh38.p14 main length")
ggsave("human_genome_plot.png", plot = plot, width = 8, height = 6, dpi = 300)