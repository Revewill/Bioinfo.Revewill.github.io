# R Basics
---
### T1
> View structure of `iris`
* Use function `str` to check its structure

    ```R
    > str(iris)
    'data.frame':	150 obs. of  5 variables:
    $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
    $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
    $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
    $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
    $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
    ```
* The result indicates that `iris` is a $150\times5$ dataframe
* Its columns are: **Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species**
---
### T2
> Mean and SD of Sepal.Length grouped by species
* Use package `dplyr`

    ```R
    library(dplyr)

    iris_summary <- iris %>%
    group_by(Species) %>%
    summarise(
        Mean_Sepal.Length = mean(Sepal.Length),
        SD_Sepal.Length = sd(Sepal.Length)
    )

    write.csv(iris_summary, "iris_summary.csv", row.names = FALSE)
    ```
---
### T3
> One way ANOVA analysis for Sepal.Width grouped by species
* Run with function `aov`

    ```R
    iris_ANOVA <- aov(Sepal.Width ~ Species, data = iris)
    summary(iris_ANOVA)
    sink("anova_results.txt")
    print(iris_ANOVA)
    sink()
    ```