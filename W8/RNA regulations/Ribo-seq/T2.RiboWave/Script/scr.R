library(ggplot2)

# Extract raw TE data
te.tab <- read.table("SRR1039770.TE",
    header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Filter
te.tab <- te.tab[
    !is.na(te.tab$TE) & !is.infinite(te.tab$TE),
]

# Plot with ggplot2
ggplot(te.tab, aes(x = log2(TE + 0.01))) +
  geom_density(fill = "steelblue", alpha = 0.6, color = "darkblue", linewidth = 1) +
  geom_vline(xintercept = log2(1), color = "red", linetype = "dashed", linewidth = 1) +
  xlim(-9, 30) +
  labs(title = "Density distribution of TE",
       x = "log2(TE + 0.01)",
       y = "Density") +
  theme_minimal()

ggsave("TE_density.png", width = 8, height = 6, dpi = 300)