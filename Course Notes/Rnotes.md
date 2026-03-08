# Notes on R learning
## 1. Package installation and basic commands
> Enter `RStudio` and create a new `R` file. Edit it and click `run` to check results in `console`.
* **Install packages** via
    ```R
    install.packages("package")
    ```
    or with `BiocManager`
    ```R
    BiocManager::install("package", ask = F, update = F`)
    ```
    * **`R` Packages** are sets of **functions**
    * `BiocManager` is a platform for bioinformatic package installation
    * For Packages to take effect, use
        ```R
        library("package")
        ```
* **Basic Commands**
    * Get working dir
        ```R
        getwd()
        ```
    * Set working dir
        ```R
        setwd("working_dir")
        ```
    * Set variables
        ```R
        a <- 0
        ```
        or
        ```R
        a = 0
        ```
        > `<-` could be typed with `Alt`+`-`
    * Remove
        ```R
        rm(xxx)
        ```

## 2. Data Type and Data Structure in `R`
* **Data Type**
    * Three main types: **numeric**, **logical** and **character**
    * *e.g.*, these `3` variables represent `3` different data type: (**`c` is a function**, therefore not commonly used as variables)
        ```R
        a <- 1
        b <- TRUE
        d <- "abc"
        ```
    * `class` function tells the data type
        ```R
        class(a)
        class(b)
        class(d)
        ```
* **Data Structure**
    > Are storage forms of data, including 向量, 矩阵, 数组, 数据框, 列表.
    *