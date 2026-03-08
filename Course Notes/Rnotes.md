# Notes on `R` learning
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
    * 向量 (vectors) are **strings** of data **of a same type** placed in order
        * **Creating** vectors: *e.g.*, `a` is a *num* vector, `b` is a *chr* vector, `c` is a *logi* vector
            ```R
            a <- c(-1,0,1,2,3,4,5)
            b <- c("one", "two", "three", "four", "five")
            d <- c(TRUE, FALSE, TRUE, FALSE, TRUE)

            # Creating a consecutive sequence of numbers
            a <- c(1:10)

            # Creating sequences with seq function
            # seq(from, to, step)
            a <- seq(1,10,2)    # a <- c(1,3,5,7,9)

            # Creating sequences with rep function
            # rep(number, times_of_repeats)
            a <- rep(3,4)   # a <- c(3,3,3,3)
            ```
        * **Accessing** elements within a vector:
            ```R
            a <- c(-1,0,1,2,3,4,5)

            # Accessing the third element in a
            a[3]    # Returns: 1

            # Accessing the first, third and fourth elements in a
            a[c(1,3,4)]    # Returns: -1 1 2

            # Accessing the second to sixth elements in a
            a[2:6]   # Returns: 0 1 2 3 4
            ```
        * **Modifying** elements within a vector:
            ```R
            a <- c(-1,0,1,2,3,4,5)

            # Modifying the first element in a
            a[1] <- -2
            a   # Returns: -2 0 1 2 3 4 5

            # Modifying the second and seventh elements in a
            a[c(2,7)] <- c(5,0)
            a   # Returns: -2 5 1 2 3 4 0

            # Modifying the third to sixth elements in a
            a[3:6] <- c(4:7)
            a   # Returns: -2 5 4 5 6 7 0
            ```
        * **Deleting** elements within a vector:
            ```R
            a <- c(-1,0,1,2,3,4,5)

            # Deleting the first element in a
            a[-1]   # Returns: 0 1 2 3 4 5

            # Modifying the second and seventh elements in a
            a[c(2,7)] <- c(5,0)
            a   # Returns: -2 5 1 2 3 4 0

            # Modifying the third to sixth elements in a
            a[3:6] <- c(4:7)
            a   # Returns: -2 5 4 5 6 7 0
            ```