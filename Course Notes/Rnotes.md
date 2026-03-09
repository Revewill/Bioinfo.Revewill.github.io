# Notes on `R` learning
- [Notes on `R` learning](#notes-on-r-learning)
  - [1. Package installation and basic commands](#1-package-installation-and-basic-commands)
    - [1.1  **Install packages**](#11--install-packages)
    - [1.2 **Basic Commands**](#12-basic-commands)
  - [2. Data Type and Data Structure in `R`](#2-data-type-and-data-structure-in-r)
    - [2.1 **Data Type**](#21-data-type)
    - [2.2 **Data Structure**](#22-data-structure)
      - [2.2.1 **Vectors**](#221-vectors)
        - [2.2.1.1 Basics in Vector](#2211-basics-in-vector)
          - [2.2.1.1.1 **Creating** vectors](#22111-creating-vectors)
          - [2.2.1.1.2 **Accessing** elements within a vector](#22112-accessing-elements-within-a-vector)
          - [2.2.1.1.3 **Modifying** elements within a vector](#22113-modifying-elements-within-a-vector)
          - [2.2.1.1.4 **Deleting** elements within a vector](#22114-deleting-elements-within-a-vector)
        - [2.2.1.2 Advance in Vector](#2212-advance-in-vector)
          - [2.2.1.2.1 🚩 `paste` function](#22121--paste-function)
          - [2.2.1.2.2 Calculation of vectors](#22122-calculation-of-vectors)
          - [2.2.1.2.3 Extension on data type: `NA` and `NULL`](#22123-extension-on-data-type-na-and-null)
        - [2.2.1.3 *Logi* Vectors](#2213-logi-vectors)
        - [2.2.1.4 🚩 *Chr* Vectors](#2214--chr-vectors)
      - [2.2.2 **Matrices**](#222-matrices)
        - [2.2.2.1 Basics in Matrices](#2221-basics-in-matrices)
          - [2.2.2.1.1 **Creating** matrices](#22211-creating-matrices)

---
## 1. [Package installation](#11--install-packages) and [basic commands](#12-basic-commands)
> Enter `RStudio` and create a new `R` file. Edit it and click `run` to check results in `console`.

### 1.1  **Install packages**
> Go [back](#1-package-installation-and-basic-commands), go [down](#12-basic-commands), or go to [top](#notes-on-r-learning).

```R
install.packages("package")
# or with BiocManager
BiocManager::install("package", ask = F, update = F`)
```
* **`R` Packages** are sets of **functions**
* `BiocManager` is a platform for bioinformatic package installation
* For Packages to take effect, use

    ```R
    library("package")
    ```
### 1.2 **Basic Commands**
> Go [back](#1-package-installation-and-basic-commands), go [down](#2-data-type-and-data-structure-in-r), or go to [top](#notes-on-r-learning).
* Get/Set working dir

    ```R
    getwd()
    setwd("working_dir")
    ```
* Set variables

    ```R
    a <- 0
    # or
    a = 0
    ```
  > `<-` could be typed with `Alt`+`-`
* Remove

    ```R
    rm("sth")
    ```
---
## 2. Data Type and Data Structure in `R`
### 2.1 **Data Type**
> Go [back](#2-data-type-and-data-structure-in-r), go [down](#22-data-structure), or go to [top](#notes-on-r-learning).
* Three main types: **numeric** (*num*), **logical** (*logi*) and **character** (*chr*)
  * *e.g.*, these `3` variables represent `3` different data type

    ```R
    a <- 1.4
    b <- TRUE
    d <- "abc"
    e <- as.integer(2.99)
    ```
    > **`c` is a function**, therefore not commonly used as variables.
  * `class` and `is` function tells the data type

    ```R
    class(a)    # Returns numeric
    class(b)    # Returns logical
    class(d)    # Returns character
    class(e)    # Returns integer
    e   # Returns 2

    is.numeric(a)   # Returns TRUE
    is.integer(a)   # Returns FALSE
    is.integer(a)   # Returns TRUE
    ```
### 2.2 **Data Structure**
> Go [back](#2-data-type-and-data-structure-in-r), go [down](#221-vectors), or go to [top](#notes-on-r-learning).

> Are storage forms of data, including [Vectors](#221-vectors), [Matrices](#222-matrices), 数组, 数据框, List.
#### 2.2.1 **Vectors**
* **Vectors** are **strings** of data **of a same type** placed in order
##### 2.2.1.1 Basics in Vector
> Go [back](#221-vectors), go [down](#2212-advance-in-vector), or go to [top](#notes-on-r-learning).
###### 2.2.1.1.1 **Creating** vectors
* *e.g.*, `a` is a *num* vector, `b` is a *chr* vector, `c` is a *logi* vector

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
###### 2.2.1.1.2 **Accessing** elements within a vector

```R
a <- c(-1,0,1,2,3,4,5)

# Accessing the third element in a
a[3]    # Returns: 1

# Accessing the first, third and fourth elements in a
a[c(1,3,4)]    # Returns: -1 1 2

# Accessing the second to sixth elements in a
a[2:6]   # Returns: 0 1 2 3 4
```
###### 2.2.1.1.3 **Modifying** elements within a vector

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
###### 2.2.1.1.4 **Deleting** elements within a vector

```R
a <- c(-1,0,1,2,3,4,5)

# Deleting the first element in a
a[-1]   # Returns: 0 1 2 3 4 5
a <- a[-1] # Commiting deletion to a itself
a   # Returns: 0 1 2 3 4 5

# Deleting the first and sixth elements in a
a[-c(1,6)]  # Returns: 1 2 3 4
a <- a[-c(1,6)]

# Deleting the second to fourth elements in a
a[-(2:4)]   # Returns: 1
```
##### 2.2.1.2 Advance in Vector
> Go [back](#221-vectors), go [down](#2213-logi-vectors), or go to [top](#notes-on-r-learning).
###### 2.2.1.2.1 🚩 `paste` function

```R
# Basic format
paste("A","B","C",1:3,sep = 'sep')
# Returns "AsepBsepCsep1" "AsepBsepCsep2" "AsepBsepCsep3"
# Pastes the elements together separated by an appointed separator

a <- paste("chr","omosome",1:3,sep = '')
# Returns "chromosome1" "chromosome2" "chromosome3"

a <- paste("chr","X",1:3,sep = "_")
# Returns "chr_X_1" "chr_X_2" "chr_X_3"

# Collapse argument
a <- paste("chr","X",1:3,sep = "_",collapse = ";")
# Returns "chr_X_1;chr_X_2;chr_X_3"
# This argument joins all characters together
```
###### 2.2.1.2.2 Calculation of vectors

```R
a <- c(1:10)

# min and max function
min(a)  # Returns 1
max(a)  # Returns 10

# which function
which.min(a)    # Returns 1 (the location of min)
which.max(a)    # Returns 10 (the location of max)

# statistic functions
sum(a)  # Returns 55
sum(1:100)  # Returns 5050
median(a)   # Returns 中位数
prod(a) # Returns 10! 求积
var(a)  # Returns 方差
mean(a) # Returns 平均数
                
# sorting functions
sort(a) # Sorts the elements in a (升序)
rev(a)  # Sorts the elements in a (倒序)
order(a)    # Sorts the elements in a (升序) and returns the location of the elements
a(order(a)) # Equals to sort(a)
```
###### 2.2.1.2.3 Extension on data type: `NA` and `NULL`
* Functions

    | `NA` | `NULL` |
    | :---: | :---: |
    | represents lack of data | represents non-existing data |
    | a position without data | no position and no data |
* *e.g.*,

    ```R
    a <- c(NA, NULL, NA)
    a   # Returns NA NA
    length(c(NA, NULL, NA))   # Returns 2
    ```
##### 2.2.1.3 *Logi* Vectors
> Go [back](#221-vectors), go [down](#2214--chr-vectors), or go to [top](#notes-on-r-learning).

```R
# Comparing values
c(1,2,3) > 2    # Returns FALSE FALSE TRUE
a <- c(1,2,3)
b <- a > 2  # b is FALSE FALSE TRUE
a[b]    # Returns 3
# When the length of vector a equals to the length of logi vector b, a[b] returns all elements in a that correspond to TRUE in b

# Likewise:
a <- c(5,1,7,3,9)
a[a >= 2 & a <= 7]  # Returns 5 7 3
# Because a >= 2 & a <= 7 returns TRUE FALSE TRUE TRUE FALSE

# AND (&) OR (|) NOT (!)
a[a >= 7 | a <= 2]  # Returns 1 7 9
a[!a >= 7]  # Returns 5 1 3
```
##### 2.2.1.4 🚩 *Chr* Vectors
> Go [back](#221-vectors), go [down](#222-matrices), or go to [top](#notes-on-r-learning).

```R
# UPPER and lower case
toupper("RevewillH")  # Returns REVEWILLH
tolower("RevewillH")    # Returns revewillh

# Character counts
nchar("RevewillH", type="bytes")    # Length of bytes
nchar("RevewillH", type="char") # Length of characters

# Capture characters
substring("RevewillH", 1, 4)    # Returns Reve
substring("RevewillH", 5)   # Returns willH (Default: a single number = from it to the end)

# Switch between num and chr
as.numeric(c("1","23"))    # Returns 1 23
as.character(c(12.34, 56.78))   # Returns "12.34" "56.78"

# 🚩 Operation on chr strings
# Split
strsplit("chr_string", "separator")
strsplit("1;2;3", ";")  # Returns 1 2 3
# Switch
gsub("old_chr", "new_chr", "chr_string")
gsub("_", "omosome_", "chr_1")    # Returns chromosome_1
# In gsub, old_chr supports Regular Expression
gsub("[[:alpha:]]+", "$", "revewill H") # Returns "$ $"
gsub("[[:alnum:]]+", "$", "1 23 456") # Returns "$ $ $"
```
> `[[:pattern:]]` is a regular expression corresponding to **one match** of `pattern`. `alpha` means *letters* (ignoring upper/lower cases), `alnum` means *numbers*, `+` means the pattern before `+` *can occur single or multiple time(s)*.
            
> See [regular expression] for more.
#### 2.2.2 **Matrices**
* **Matrices** are **`2D` strings** of data **of a same type**
##### 2.2.2.1 Basics in Matrices
> Go [back](#222-matrices), go [down], or go to [top](#notes-on-r-learning).

###### 2.2.2.1.1 **Creating** matrices
* Create matrix with `matrix` function

    ```R
    matrix(data = data, nrow = m, ncol = n, byrow = TRUE, dimnames = list)
    ```
    * `data` is the source data, must be **$m*n$** sized
    * `nrow` is the number of rows
    * `ncol` is the number of columns
    * `byrow` dictates whether `data` is filled into the matrix by row or column order
      * `byrow = TRUE`: data is filled by row
      * `byrow = FALSE` or no `byrow` argument: data is filled by column
    * `dimnames` is the name of each row or column (if you are working a form)
      * Normally inputed in a list form
      * `dimnames = NULL` or no `dimnames` argument means no dimnames
    > *e.g.*,
    
    ```R
    matrix(data = 1:10, nrow = 2, ncol = 5, byrow = TRUE, dimnames = NULL)
    # Returns
    1 2 3 4 5
    6 7 8 9 10

    matrix(data = 1:10, nrow = 2, ncol = 5)
    # Returns
    1 3 5 7 9
    2 4 6 8 10
    ```
* Creating matrix with vectors

    ```R
    # Assign data
    cells <- c(1:4)

    # Assign dimnames
    rnames <- c("R1", "R2")
    nnames <- c("C1", "C2")

    # Create matrix
    A <- matrix(cells, nrow = 2, ncol = 2, byrow = TRUE, dimnames = list(rnames, nnames))
    A
    # Returns
        C1 C2
    R1  1  2
    R2  3  4

    # Define dimnames after creating matrix
    A <- matrix(data = 1:4, nrow = 2, ncol = 2)
    rownames(A) = c("Row1", "Row2")
    colnames(A) = c("Col1", "Col2")
    A
    # Returns
          Col1 Col2
    Row1  1    3
    Row2  2    4
    ```

