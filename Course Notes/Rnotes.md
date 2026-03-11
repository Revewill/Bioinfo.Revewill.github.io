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
          - [2.2.1.2.2 **Calculation** of vectors](#22122-calculation-of-vectors)
          - [2.2.1.2.3 Extension on data type: `NA` and `NULL`](#22123-extension-on-data-type-na-and-null)
        - [2.2.1.3 *Logi* Vectors](#2213-logi-vectors)
        - [2.2.1.4 🚩 *Chr* Vectors](#2214--chr-vectors)
      - [2.2.2 **Matrices**](#222-matrices)
        - [2.2.2.1 Basics in Matrices](#2221-basics-in-matrices)
          - [2.2.2.1.1 **Creating** matrices](#22211-creating-matrices)
          - [2.2.2.1.2 **Accessing** and **modifying** elements within a matrix](#22212-accessing-and-modifying-elements-within-a-matrix)
          - [2.2.2.1.3 **Calculation** of matrices](#22213-calculation-of-matrices)
        - [2.2.2.2 Advance in Matrices](#2222-advance-in-matrices)
          - [2.2.2.2.1 🚩 **Operation** on rows and cols](#22221--operation-on-rows-and-cols)
          - [2.2.2.2.2 **Advance calculation** of matrices](#22222-advance-calculation-of-matrices)
      - [2.2.3 **Arrays**](#223-arrays)
        - [2.2.3.1 Basics in Array](#2231-basics-in-array)
          - [2.2.3.1.1 **Creating** arrays](#22311-creating-arrays)
          - [2.2.3.1.2 **Accessing** elements within an array](#22312-accessing-elements-within-an-array)
      - [2.2.4 **Data frames**](#224-data-frames)
        - [2.2.4.1 Basics in Data frame](#2241-basics-in-data-frame)
          - [2.2.4.1.1 **Creating** data frames](#22411-creating-data-frames)
          - [2.2.4.1.2 **Accessing** and **modifying** elements within a data frame](#22412-accessing-and-modifying-elements-within-a-data-frame)
          - [2.2.4.1.2 **Operation** on rows and cols](#22412-operation-on-rows-and-cols)
      - [2.2.5 **Lists**](#225-lists)
        - [2.2.5.1 Basics in List](#2251-basics-in-list)
          - [2.2.5.1.1 **Creating** lists](#22511-creating-lists)
          - [2.2.5.1.2 **Accessing** and **modifying** elements within a list](#22512-accessing-and-modifying-elements-within-a-list)
          - [2.2.5.1.3 **Operation** on lists](#22513-operation-on-lists)
        - [2.2.5.2 Advance in List](#2252-advance-in-list)
  - [3. Data Management](#3-data-management)
    - [3.1 `csv` and `xlsx` files](#31-csv-and-xlsx-files)
      - [3.1.1 **Reading** and **saving** `csv` files](#311-reading-and-saving-csv-files)
      - [3.1.2 **Operation** on `xlsx` files](#312-operation-on-xlsx-files)
    - [3.2 `txt` files](#32-txt-files)
  - [4. Advanced Data Management](#4-advanced-data-management)
    - [4.1 **Loop** Sentences](#41-loop-sentences)
      - [4.1.1 `for` loop](#411-for-loop)
      - [4.1.2 `while` loop](#412-while-loop)
    - [4.2 `apply` Functions](#42-apply-functions)

---
## 1. Package installation and basic commands
> Enter `RStudio` and create a new `R` file. Edit it and click `run` to check results in `console`.

### 1.1  **Install packages**
> Go [back](#1-package-installation-and-basic-commands), go [down](#12-basic-commands), or go to [top](#notes-on-r-learning).

```R
install.packages("package")
# or with BiocManager
BiocManager::install("package", ask = F, update = F)
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
    is.integer(e)   # Returns TRUE
    ```
* One special type: **factor**
  * **Factors** are *chr* vectors
    * The only difference: a vector is a set of data, a factor is data itself
      * `c("A","T","G","C")` is a vector in which elements are not interconnected
      * `factor("A","T","G","C")` is a factor in which these letters are interconnected as a whole
    * `levels` sorts out all unique letters in a factor and assign them numeric values
      * *e.g.*, `"A","T","G","C"` -> `1,2,3,4`
      * Factor is stored in the corresponding numeric format
    * `labels` are labels you attach to levels
    * `ordered` is a *logi* value that determines whether levels are sorted in order
  * Creating factors
    * Creating factors with `factor`
      ```R
      factor(chr_vector, levels, labels, ordered = TRUE)
      
      v <- c("A","G","T","C","A")
      factor(v)
      # Returns
      A G T C A
      Levels: A C G T
      # No levels argument: default order (num -> chr)

      # levels
      factor(v, levels = c("A","T","G","C")) 
      # Returns
      A G T C A
      Levels: A T G C

      # labels
      factor(
        v, levels = c("A","T","G","C"),
        labels = c("Adenine", "Thymine", "Guanine", "Cytosine")
      )
      # Returns
      Adenine Guanine Thymine Cytosine Adenine
      Levels: Adenine Thymine Guanine Cytosine

      # Transform between data type/structure (as function)
      as.factor(v)
      ```
    * Creating factors with `gl`
      ```R
      gl(num_of_levels, num_of_repeats, labels)

      gl(4, 2, labels = c("A","T","G","C"))
      # Returns
      A A T T G G C C
      Levels: A T G C
      ```
  * Practical use of factors
    ```R
    # Used in sorting
    size <- c("XS","S","L","XL","M")

    # Normal sorting: alphabetic order
    sort(size)  # Returns "L" "M" "S" "XL" "XS"
    
    # Factor sorting: appointed order
    F_size <- factor(size, labels = c("XS","S","M","L","XL"))
    sort(F_size)
    # Returns
    XS S M L XL
    Levels: XS S M L XL
    ```
### 2.2 **Data Structure**
> Go [back](#2-data-type-and-data-structure-in-r), go [down](#221-vectors), or go to [top](#notes-on-r-learning).

> Are storage forms of data, including [Vectors](#221-vectors), [Matrices](#222-matrices), [Arrays](#223-arrays), [Data frame](#224-data-frames), [List](#225-lists).
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
###### 2.2.1.2.2 **Calculation** of vectors

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
> ※ `[[:pattern:]]` is a regular expression corresponding to **one match** of `pattern`. `alpha` means *letters* (ignoring upper/lower cases), `alnum` means *numbers*, `+` means the pattern before `+` *can occur single or multiple time(s)*.
> See [regular expression]() for more.
#### 2.2.2 **Matrices**
* **Matrices** are **`2D` strings** of data **of a same type**
##### 2.2.2.1 Basics in Matrices
> Go [back](#222-matrices), go [down](#2222-advance-in-matrices), or go to [top](#notes-on-r-learning).

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
    1 2 3 4  5
    6 7 8 9 10

    matrix(data = 1:10, nrow = 2, ncol = 5)
    # Returns
    1 3 5 7  9
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
    R1   1  2
    R2   3  4

    # Define dimnames after creating matrix
    A <- matrix(data = 1:4, nrow = 2, ncol = 2)
    rownames(A) = c("Row1", "Row2")
    colnames(A) = c("Col1", "Col2")
    A
    # Returns
          Col1 Col2
    Row1     1    3
    Row2     2    4
    ```
* ※ Creating things with random numbers

  ```R
  matrix(rnorm(15),5,3)
  # Returns a 5*3 matrix with 15 random numbers

  # rnorm
  rnorm(n, mean = 0, sd = 1)
  # Randomly generate n numbers that obey normal distribution
  # Default mean = 0, standard deviation = 1

  # sample
  sample(1:10, 4, replace = T)
  # Randomly pick 4 repeatable numbers from 1 to 10
  # Or replace = F
  ```
###### 2.2.2.1.2 **Accessing** and **modifying** elements within a matrix

```R
A <- matrix(1:10, nrow = 2)
A
# Returns
1 3 5 7  9
2 4 6 8 10

# Access the second row
A[2,] # Returns 2 4 6 8 10
# Access the second column
A[,2] # Returns 3 4
# Access the (2,2) element
A[2,2]  # Returns 4

# Modifying rows and columns
A[2,] <- c(as.numeric(paste(1, A[2,1:4], sep = '')), 20)
A[2,]
# Returns
12 14 16 18 20
# Modifying elements
A[1,1] <- 0
A[1,1]  # Returns 0

# Acquiring information on matrix
dim(A)  # Returns 2 5 (2 rows, 5 cols)
nrow(A) # Returns 2
ncol(A) # Returns 5
```
###### 2.2.2.1.3 **Calculation** of matrices

```R
# Transposition
t(A)
# Returns
1  2
3  4
5  6
7  8
9 10

# Linear calculations
X <- matrix(1:4, nrow = 2)
Y <- matrix(5:8, nrow = 2)
X + Y # Addition
X - Y # Subtraction
X * Y # Must be same dimension as well
# Not Matrix Multiplication in Linear Algebra!
# But each element in X multiplied by corresponding element in Y
# Returns
1*5 3*7
2*6 4*8
# Namely
 5 21
12 32
X / Y # Similar to multiplication above

# Matrix multiplication (as in Linear Algebra)
X %*% Y # Multiplication
# Returns
23 31
34 46
```
##### 2.2.2.2 Advance in Matrices
> Go [back](#222-matrices), go [down](#), or go to [top](#notes-on-r-learning).

###### 2.2.2.2.1 🚩 **Operation** on rows and cols

```R
X <- matrix(1:4, nrow = 2)
Y <- matrix(5:8, nrow = 2)

# Sums and means
rowSums(X)  # Returns 25 30 (a 2D vector)
colSums(X)  # Returns 3 7 11 15 19 (a 5D vector)
mean(X) # Returns 5.5
rowMeans(X)
colMeans(X)

# 🚩 Binding of rows and cols
cbind(X,Y)  # Must with same nrow
# Returns (X,Y)
1 3 5 7
2 4 6 8
rbind(X,Y)  # Must with same ncol
# Returns (X,Y)^T
1 3
2 4
5 7
6 8
```
###### 2.2.2.2.2 **Advance calculation** of matrices

```R
# Inverse matrix 求逆
solve(X)
# Verify
round(solve(X) %*% X) # Returns I2

# SVD and pseudo-inverse 奇异值分解和求广义逆/伪逆
ginv(X) # Returns pseudo-inverse matrix
S <- svd(X)
# Stores vectors u, d and v (X = uD(v^T), where D = diag(d)) as a list
S$u %*% diag(S$d) %*% t(S$v) # Returns X (S$ extracts variants within S)

# Eigenvalue/eigenvector 特征值/特征向量
eigen(X)  # Returns eigenvalue and corresponding eigenvector

# diag
diag(X) # Returns the diagonal elements of X (a vector)
diag(n) # Returns In
diag(c(1,2))
# Returns
1 0
0 2
diag(2,4) # Returns 2*I4
diag(2,4,5) # Returns a 4*5 matrix with its first 4*4 submatrix being 2*I4
```
> `round` 取整. *e.g.*, `round(0.98)` returns `1`.
#### 2.2.3 **Arrays**
* **Arrays** are **multi-dim strings** of data **of a same type**
  * A matrix could be interpreted as a `2D` array, whereas a vector is `1D`
##### 2.2.3.1 Basics in Array
> Go [back](#223-arrays), go [down](#224-data-frames), or go to [top](#notes-on-r-learning).
###### 2.2.3.1.1 **Creating** arrays

```R
# Creating array
array(data = NA, dim = c(2,3,4), dimnames = NULL)
# Returns a 2*3*4 array filled with NA and without dimnames

dimname_A <- c("A1","A2","A3")
dimname_B <- c("B1","B2","B3")
dimname_C <- c("C1","C2","C3")
Ω <- array(1:27, c(3,3,3), dimnames = list(dimname_A, dimname_B, dimname_C))
# if data doesn't fill the array size, then it will cycle
```
###### 2.2.3.1.2 **Accessing** elements within an array

```R
print(Ω[3,1,2])  # Or Ω[3,1,2]
print(Ω[3,1,])  # Returns vector
print(Ω[3,,]) # Returns matrix

# Creating matrices from arrays
M(Ω) <- Ω[2,,]
```
#### 2.2.4 **Data frames**
* **Data frames** are data **forms** aligned in columns
  * A column has a **unique colname**
  * Columns are equal in **length**
  * Data within the same column must be **of the same type**
  * The type of data from **different** columns **can differ**
##### 2.2.4.1 Basics in Data frame
> Go [back](#224-data-frames), go [down](#225-lists), or go to [top](#notes-on-r-learning).
###### 2.2.4.1.1 **Creating** data frames

* Basic function

  ```R
  # Creating data frames
  data.frame(tag1 = vector1, tag2 = vector2, row.names = rname)
  ```
  * `tag` is the colname
  * `row.names` defines rownames, default is `NULL`
* *e.g.*,

  ```R
  u <- c(1,2)
  v <- c(TRUE, FALSE)
  data.frame(u,v)
  # Returns
    u     v
  1 1  TRUE
  2 2 FALSE

  DF <- data.frame(
    'num' = c(1,2,3),
    'chr' = c("a","b","c"),
    'logi' = c(TRUE, FALSE, TRUE)
  )
  DF
  # Returns
    num chr  logi
  1   1   a  TRUE
  2   2   b FALSE
  3   3   c  TRUE
  ```
###### 2.2.4.1.2 **Accessing** and **modifying** elements within a data frame

```R
# Acquiring overview and statistics on data frame
str(DF) # Returns data structure
summary(DF) # Returns statistic values of each column

# Accessing cols and rows
DF[,2]  # Returns the second col
DF$chr  # Returns the col with tag 'chr'
DF[1:2,]  # Returns the first and second rows
DF[1:2,1:2] # Returns
  num chr
1   1   a
2   2   b

# Adding cols
DF$'note' <- rep(NA,3)
DF
# Returns
  num chr  logi note
1   1   a  TRUE   NA
2   2   b FALSE   NA
3   3   c  TRUE   NA
```
###### 2.2.4.1.2 **Operation** on rows and cols

```R
# rbind and cbind
DF
# Returns
  num chr  logi note
1   1   a  TRUE   NA
2   2   b FALSE   NA
3   3   c  TRUE   NA

DF1 <- data.frame('value' = c(3.14, 1.59, 2.65))
cbind(DF, DF1)
# Returns
  num chr  logi note value
1   1   a  TRUE   NA  3.14
2   2   b FALSE   NA  1.59
3   3   c  TRUE   NA  2.65

DF2 <- data.frame('num' = 4, 'chr' = "d", 'logi' = FALSE, 'note' = NA)
rbind(DF, DF2)
# Returns
  num chr  logi note
1   1   a  TRUE   NA
2   2   b FALSE   NA
3   3   c  TRUE   NA
4   4   d FALSE   NA
```
#### 2.2.5 **Lists**
* **Lists** are containers of **different** types/structures of data
  * May include *data*, *vectors*, *matrices*, *arrays*, *data frames*, and even other *lists*.
##### 2.2.5.1 Basics in List
> Go [back](#225-lists), go [down](#2252-advance-in-list), or go to [top](#notes-on-r-learning).
###### 2.2.5.1.1 **Creating** lists

```R
# Creating a list
List <- list(
  "revewill",
  "H",
  c(1,2,3),
  1.23,
  matrix(c(TRUE, FALSE, TRUE, TRUE), 2),
  list(
    c("a","b","c"),
    NA
  )
)
List
# Returns
[[1]] # [[1]] means the first item in the list
[1] "revewill"

[[2]]
[1] "H"

[[3]]
[1] 1 2 3

[[4]]
[1] 1.23

[[5]]
      [,1] [,2]
[1,]  TRUE TRUE
[2,] FALSE TRUE

[[6]]
[[6]][[1]]
[1] "a" "b" "c"

[[6]][[2]]
[1] NA

# Creating names for each element
names(List) <- c(
  "User",
  "Username",
  "Vector",
  "Number",
  "Matrix",
  "List"
)
List
# Returns
$User
[1] "revewill"

$Username
[1] "H"

$Vector
[1] 1 2 3

$Number
[1] 1.23

$Matrix
      [,1] [,2]
[1,]  TRUE TRUE
[2,] FALSE TRUE

$List
$List[[1]]
[1] "a" "b" "c"

$List[[2]]
[1] NA

# Or create names when creating the list
List <- list(
  'User' = "revewill",
  'Username' = "H",
  'Vector' = c(1,2,3),
  'Number' = 1.23,
  'Matrix' = matrix(c(TRUE, FALSE, TRUE, TRUE), 2),
  'list' = list(
    c("a","b","c"), 
    NA
  )
)
```
###### 2.2.5.1.2 **Accessing** and **modifying** elements within a list

```R
# Accessing the second item
List[2] # Returns [1] "H"
List$Username # Returns [1] "H"

# Modifying elements
List[2] <- "Huang"
List$Username <- "Huang"

# Deleting elements
List[-2]
# Or
List$Username <- NULL
```
###### 2.2.5.1.3 **Operation** on lists

```R
L1 <- list(1:3)
L2 <- list(4:6)

# Merge lists
c(L1,L2)  # A new list with items in both lists

# Transform to vectors
L1 + L2 # Error!
V1 <- unlist(L1)
V2 <- unlist(L2)
V1 + V2 # Returns 5 7 9
```
##### 2.2.5.2 Advance in List
> Go [back](#225-lists), go [down](), or go to [top](#notes-on-r-learning).

```R
List <- list(
  c(1,2,3),
  1
)

# Differences on [] and [[]]
List[1]
# Returns
[[1]]
[1] 1 2 3
# This itself is a list that only has one element: a vector

List[[1]]
# Returns
[1] 1 2 3
# This itself is the vector that is included in List

# Similar principles apply to data frames
DF <- data.frame(
  'num' = c(1,2)
  'chr' = c("a","b")
  'logi' = c(TRUE, FALSE)
)

DF[1]
# Returns
  num
1   1
2   2
# This itself is still a data frame

DF[[1]]
# Returns
[1] 1 2
# This is a vector, the source data of DF

DF[,1]
# Returns
[1] 1 2
# Extracting a column is extracting the corresponding vector
```
---
## 3. Data Management
* **Importing** and **exporting** common files
### 3.1 `csv` and `xlsx` files
> Go [back](#3-data-management), go [down](#32-txt-files), or go to [top](#notes-on-r-learning).

> `csv` files use comma as separators to store forms. If a string contains comma, `csv` wraps it with `""`. For example, in `sample.csv`:

```R
num,chr,logi
1,a,TRUE
2,b,FALSE
3,c,TRUE
4,d,FALSE
```
#### 3.1.1 **Reading** and **saving** `csv` files

```R
# Read
CSV_Data <- read.csv("sample.csv", encoding = "UTF-8")
CSV_Data
# Returns the following data frame
  num chr  logi
1   1   a  TRUE
2   2   b FALSE
3   3   c  TRUE
4   4   d FALSE

# Create subset
Subset <- subset(CSV_Data, chr == "b" | num == 3)
Subset
# Returns
  num chr  logi
2   2   b FALSE
3   3   c  TRUE

# Write Subset into a new .csv file
write.csv(Subset, "sample_subset.csv", row.names = FALSE)
read.csv("write.csv", enconding = "UTF-8")
```
#### 3.1.2 **Operation** on `xlsx` files
* ※ Operation on `xlsx` files requires installing package `"xlsx"`:
  
  ```R
  install.packages("xlsx")
  library("xlsx")
  ```
* Operation:

  ```R
  # Read
  XLSX_Data <- read.xlsx("sample.xlsx", sheetIndex = 1)
  # Argument sheetIndex defines which sheet inside the file to read

  # Write
  write.xlsx(XLSX_Data, "samples.xlsx", sheetName = "new_sample", append = TRUE)
  # append = TRUE means that the created new sheet is in the original file after the last sheet in that file (追加)
  # append = FALSE means override (覆盖)
  ```
### 3.2 `txt` files
> Go [back](#3-data-management), go [down](#4-advanced-data-management), or go to [top](#notes-on-r-learning).

```R
#Read
TXT_Data <- read.table("sample.txt", header = TRUE, sep = "\t", row.names = 1, stringAsFactors = FALSE)
# header = TRUE means taking the first row as table header, = FALSE means otherwise
# sep = "\t" means the separator in .txt files is "\t"
# row.names = 1 means taking the first column as rownames
# stringAsFactors = FALSE means not transforming chr variables as factors, is default

# read.table function could also apply to csv files
read.table("sample.csv", sep = ",")

# Write
write.table(TXT_Data, "new_sample.txt", sep = "\t")
```
## 4. Advanced Data Management
### 4.1 **Loop** Sentences
> Go [back](#4-advanced-data-management), go [down](#42-apply-functions), or go to [top](#notes-on-r-learning).
#### 4.1.1 `for` loop
* Basics in `for` loop

  ```R
  for (i in 1:3) {
    print(i)
  } # Returns 1 2 3

  v <- rep("a",3)
  for (i in v) {
    print(i)
  } # Returns "a" "a" "a"
  ```
  > *i.e.*, as long as `i in vector`, `for` loop is effective, and its cycle time is the length of that `vector`
  * Calculating *vector* sum
    ```R
    # Create a random vector with runif
    v <- runif(10, min = 0, max = 1)
    # Created a vector with 10 random numbers between 0 and 1
    
    # Calculate
    sum <- 0
    for (i in 1:length(v)) {
      sum <- sum + v[i] # sum = sum + the i^th element in v
    }
    print(sum)
    ```
  * Calculating *matrix* sum
    ```R
    # Create a random 4*5 matrix
    M <- matrix(
      runif(20, min = 0, max = 1),
      4
    )
    
    # Calculate
    sum <- 0
    for (i in 1:nrow(M)) {
      for (j in 1:ncol(M)) {
        sum <- sum + M[i,j]
      }
    }
    print(sum)
    ```
* Advance in `for` loop
  * ※ `cat` v. `print`
  
    ```R
    for (i in 1:2) {
      print("a","b")
    }
    # Returns
    a
    a

    for (i in 1:2) {
      cat("a","b")
    }
    # Returns
    a ba b
    ```
  * Create a table
  
    ```R
    for (i in 1:9) {
      for (j in 1:i) {
        m = j * i
        cat(i,"*",j,"=",m,"\t")
      }
      cat("\n")
    }
    ```
#### 4.1.2 `while` loop
* Basics in `while` loop

  ```R
  while (condition) {
    statement(s)
  }
  # condition returns either TRUE or FALSE
  # e.g.
  i <- 1
  while (i < 4) {
    print(i)
    i = i + 1 # This is vital!
  }
  print(i)  # Returns 3
  # Each time the statement is done, condition will be checked for TRUE or FALSE
  # The loop discontinue at logi value FALSE
  ```
* `while` can do sth. `for` can't

  ```R
  a <- seq(1,1000000,287)
  i <- 1000000

  while (a[i] > 931256) {
    i = i - 1
  }

  print(
    paste(
      "The first element to exceed 931256 is ",
      a[i+1],
      ".",
      sep = ""
    )
  )
  # Returns The first element to exceed 931256 is 931316.
  ```
### 4.2 `apply` Functions
> Go [back](#4-advanced-data-management), go [down](), or go to [top](#notes-on-r-learning).
