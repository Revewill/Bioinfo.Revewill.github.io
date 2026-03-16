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
      - [4.2.1 `apply` function](#421-apply-function)
        - [4.2.1.1 Basic grammar](#4211-basic-grammar)
        - [4.2.2.2 Example](#4222-example)
      - [4.2.2 `tapply` function](#422-tapply-function)
        - [4.2.2.1 Basic Grammar](#4221-basic-grammar)
      - [4.2.2.2 Example](#4222-example-1)
      - [4.2.3 `by` function](#423-by-function)
      - [4.2.4 `lapply` function](#424-lapply-function)
        - [4.2.4.1 Basic Grammar](#4241-basic-grammar)
        - [4.2.4.2 Practical Usage](#4242-practical-usage)
        - [4.2.4.3 `sapply` function](#4243-sapply-function)
      - [4.2.5 `mapply` function](#425-mapply-function)
- [Apx. Cheatsheet](#apx-cheatsheet)
          - [1.  `apply` : 1 2](#1--apply--1-2)
          - [2.  `array` : 1 2](#2--array--1-2)
          - [3.  `as.character` : 1](#3--ascharacter--1)
          - [4.  `as.data.frame` : 1](#4--asdataframe--1)
          - [5.  `as.factor` : 1](#5--asfactor--1)
          - [6.  `as.integer` : 1](#6--asinteger--1)
          - [7.  `as.numeric` : 1 2](#7--asnumeric--1-2)
          - [8.  `assign` : 1](#8--assign--1)
          - [9.  `BiocManager::install` : 1](#9--biocmanagerinstall--1)
          - [10.  `by` : 1](#10--by--1)
          - [11.  `c` : 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27](#11--c--1-2-3-4-5-6-7-8-9-10-11-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27)
          - [12.  `cat` : 1 2](#12--cat--1-2)
          - [13.  `cbind` : 1 2](#13--cbind--1-2)
          - [14.  `class` : 1](#14--class--1)
          - [15.  `colMeans` : 1](#15--colmeans--1)
          - [16.  `colnames` : 1](#16--colnames--1)
          - [17.  `colSums` : 1](#17--colsums--1)
          - [18.  `data.frame` : 1 2 3 4 5 6](#18--dataframe--1-2-3-4-5-6)
          - [19.  `diag` : 1](#19--diag--1)
          - [20.  `dim` : 1](#20--dim--1)
          - [21.  `eigen` : 1](#21--eigen--1)
          - [22.  `factor` : 1 2 3](#22--factor--1-2-3)
          - [23.  `getwd` : 1](#23--getwd--1)
          - [24.  `ginv` : 1](#24--ginv--1)
          - [25.  `gl` : 1](#25--gl--1)
          - [26.  `gsub` : 1](#26--gsub--1)
          - [27.  `install` : 1](#27--install--1)
          - [28.  `install.packages` : 1 2](#28--installpackages--1-2)
          - [29.  `is.integer` : 1](#29--isinteger--1)
          - [30.  `is.numeric` : 1](#30--isnumeric--1)
          - [31.  `kronecker` : 1](#31--kronecker--1)
          - [32.  `lapply` : 1 2 3](#32--lapply--1-2-3)
          - [33.  `length` : 1 2](#33--length--1-2)
          - [34.  `library` : 1 2](#34--library--1-2)
          - [35.  `list` : 1 2 3 4 5 6 7](#35--list--1-2-3-4-5-6-7)
          - [36.  `mapply` : 1 2](#36--mapply--1-2)
          - [37.  `matrix` : 1 2 3 4 5 6 7 8 9 10](#37--matrix--1-2-3-4-5-6-7-8-9-10)
          - [38.  `max` : 1](#38--max--1)
          - [39.  `mean` : 1 2 3 4 5](#39--mean--1-2-3-4-5)
          - [40.  `median` : 1](#40--median--1)
          - [41.  `min` : 1](#41--min--1)
          - [42.  `multiplication` : 1](#42--multiplication--1)
          - [43.  `names` : 1](#43--names--1)
          - [44.  `nchar` : 1](#44--nchar--1)
          - [45.  `ncol` : 1 2](#45--ncol--1-2)
          - [46.  `nrow` : 1 2](#46--nrow--1-2)
          - [47.  `order` : 1 2](#47--order--1-2)
          - [48.  `paste` : 1 2 3 4 5 6](#48--paste--1-2-3-4-5-6)
          - [49.  `print` : 1 2 3 4 5 6 7](#49--print--1-2-3-4-5-6-7)
          - [50.  `prod` : 1](#50--prod--1)
          - [51.  `rbind` : 1 2](#51--rbind--1-2)
          - [52.  `read.csv` : 1](#52--readcsv--1)
          - [53.  `read.table` : 1](#53--readtable--1)
          - [54.  `read.xlsx` : 1](#54--readxlsx--1)
          - [55.  `rep` : 1 2 3 4 5](#55--rep--1-2-3-4-5)
          - [56.  `rev` : 1](#56--rev--1)
          - [57.  `rm` : 1](#57--rm--1)
          - [58.  `rnorm` : 1 2](#58--rnorm--1-2)
          - [59.  `round` : 1](#59--round--1)
          - [60.  `rowMeans` : 1](#60--rowmeans--1)
          - [61.  `rownames` : 1](#61--rownames--1)
          - [62.  `rowSums` : 1](#62--rowsums--1)
          - [63.  `runif` : 1 2](#63--runif--1-2)
          - [64.  `sample` : 1 2](#64--sample--1-2)
          - [65.  `sapply` : 1](#65--sapply--1)
          - [66.  `seq` : 1 2](#66--seq--1-2)
          - [67.  `setwd` : 1](#67--setwd--1)
          - [68.  `solve` : 1](#68--solve--1)
          - [69.  `sort` : 1 2](#69--sort--1-2)
          - [70.  `statement` : 1](#70--statement--1)
          - [71.  `str` : 1](#71--str--1)
          - [72.  `strsplit` : 1 2](#72--strsplit--1-2)
          - [73.  `structure` : 1](#73--structure--1)
          - [74.  `subset` : 1](#74--subset--1)
          - [75.  `substring` : 1](#75--substring--1)
          - [76.  `sum` : 1](#76--sum--1)
          - [77.  `summary` : 1](#77--summary--1)
          - [78.  `svd` : 1](#78--svd--1)
          - [79.  `tapply` : 1 2 3](#79--tapply--1-2-3)
          - [80.  `tolower` : 1](#80--tolower--1)
          - [81.  `toupper` : 1](#81--toupper--1)
          - [82.  `unlist` : 1 2](#82--unlist--1-2)
          - [83.  `var` : 1](#83--var--1)
          - [84.  `vector` : 1](#84--vector--1)
          - [85.  `which.max` : 1](#85--whichmax--1)
          - [86.  `which.min` : 1](#86--whichmin--1)
          - [87.  `write.csv` : 1](#87--writecsv--1)
          - [88.  `write.table` : 1](#88--writetable--1)
          - [89.  `write.xlsx` : 1](#89--writexlsx--1)
---
## 1. Package installation and basic commands
> Enter `RStudio` and create a new `R` file. Edit it and click `run` to check results in `console`.

### 1.1  **Install packages**
> Go [back](#1-package-installation-and-basic-commands), go [down](#12-basic-commands), or go to [top](#notes-on-r-learning).

<a name="code1"></a>
```R
install.packages("package")
# or with BiocManager
BiocManager::install("package", ask = F, update = F)
```
> <small>**Functions in this block:** [`install.packages`](#apx-install.packages), [`install`](#apx-install), [`BiocManager::install`](#apx-BiocManager-install)</small>
* **`R` Packages** are sets of **functions**
* `BiocManager` is a platform for bioinformatic package installation
* For Packages to take effect, use

    <a name="code2"></a>
    ```R
    library("package")
    ```
    > <small>**Functions in this block:** [`library`](#apx-library)</small>
### 1.2 **Basic Commands**
> Go [back](#1-package-installation-and-basic-commands), go [down](#2-data-type-and-data-structure-in-r), or go to [top](#notes-on-r-learning).
* Get/Set working dir

    <a name="code3"></a>
    ```R
    getwd()
    setwd("working_dir")
    ```
    > <small>**Functions in this block:** [`getwd`](#apx-getwd), [`setwd`](#apx-setwd)</small>
* Set variables

    <a name="code4"></a>
    ```R
    a <- 0
    # or
    a = 0
    ```
  > `<-` could be typed with `Alt`+`-`
* Remove files or variants

    <a name="code5"></a>
    ```R
    rm("files_or_variants")
    ```
    > <small>**Functions in this block:** [`rm`](#apx-rm)</small>
---
## 2. Data Type and Data Structure in `R`
### 2.1 **Data Type**
> Go [back](#2-data-type-and-data-structure-in-r), go [down](#22-data-structure), or go to [top](#notes-on-r-learning).
* Three main types: **numeric** (*num*), **logical** (*logi*) and **character** (*chr*)
  * *e.g.*, these `3` variables represent `3` different data type

    <a name="code6"></a>
    ```R
    a <- 1.4
    b <- TRUE
    d <- "abc"
    e <- as.integer(2.99)
    ```
    > <small>**Functions in this block:** [`as.integer`](#apx-as.integer)</small>

    > **`c` is a function**, therefore not commonly used as variables.
  * `class` and `is` function tells the data type

    <a name="code7"></a>
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
    > <small>**Functions in this block:** [`class`](#apx-class), [`is.numeric`](#apx-is.numeric), [`is.integer`](#apx-is.integer)</small>
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
      <a name="code8"></a>
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
      > <small>**Functions in this block:** [`factor`](#apx-factor), [`c`](#apx-c), [`order`](#apx-order), [`structure`](#apx-structure), [`as.factor`](#apx-as.factor)</small>
    * Creating factors with `gl`
      <a name="code9"></a>
      ```R
      gl(num_of_levels, num_of_repeats, labels)

      gl(4, 2, labels = c("A","T","G","C"))
      # Returns
      A A T T G G C C
      Levels: A T G C
      ```
      > <small>**Functions in this block:** [`gl`](#apx-gl), [`c`](#apx-c)</small>
  * Practical use of factors
    <a name="code10"></a>
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
    > <small>**Functions in this block:** [`c`](#apx-c), [`sort`](#apx-sort), [`factor`](#apx-factor)</small>
### 2.2 **Data Structure**
> Go [back](#2-data-type-and-data-structure-in-r), go [down](#221-vectors), or go to [top](#notes-on-r-learning).

> Are storage forms of data, including [Vectors](#221-vectors), [Matrices](#222-matrices), [Arrays](#223-arrays), [Data frame](#224-data-frames), [List](#225-lists).
#### 2.2.1 **Vectors**
* **Vectors** are **strings** of data **of a same type** placed in order
##### 2.2.1.1 Basics in Vector
> Go [back](#221-vectors), go [down](#2212-advance-in-vector), or go to [top](#notes-on-r-learning).
###### 2.2.1.1.1 **Creating** vectors
* *e.g.*, `a` is a *num* vector, `b` is a *chr* vector, `c` is a *logi* vector

    <a name="code11"></a>
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
    > <small>**Functions in this block:** [`c`](#apx-c), [`seq`](#apx-seq), [`rep`](#apx-rep)</small>
###### 2.2.1.1.2 **Accessing** elements within a vector

<a name="code12"></a>
```R
a <- c(-1,0,1,2,3,4,5)

# Accessing the third element in a
a[3]    # Returns: 1

# Accessing the first, third and fourth elements in a
a[c(1,3,4)]    # Returns: -1 1 2

# Accessing the second to sixth elements in a
a[2:6]   # Returns: 0 1 2 3 4
```
> <small>**Functions in this block:** [`c`](#apx-c)</small>
###### 2.2.1.1.3 **Modifying** elements within a vector

<a name="code13"></a>
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
> <small>**Functions in this block:** [`c`](#apx-c)</small>
###### 2.2.1.1.4 **Deleting** elements within a vector

<a name="code14"></a>
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
> <small>**Functions in this block:** [`c`](#apx-c)</small>
##### 2.2.1.2 Advance in Vector
> Go [back](#221-vectors), go [down](#2213-logi-vectors), or go to [top](#notes-on-r-learning).
###### 2.2.1.2.1 🚩 `paste` function

<a name="code15"></a>
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
> <small>**Functions in this block:** [`paste`](#apx-paste)</small>
###### 2.2.1.2.2 **Calculation** of vectors

<a name="code16"></a>
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
> <small>**Functions in this block:** [`c`](#apx-c), [`min`](#apx-min), [`max`](#apx-max), [`which.min`](#apx-which.min), [`which.max`](#apx-which.max), [`sum`](#apx-sum), [`median`](#apx-median), [`prod`](#apx-prod), [`var`](#apx-var), [`mean`](#apx-mean), [`sort`](#apx-sort), [`rev`](#apx-rev), [`order`](#apx-order)</small>
###### 2.2.1.2.3 Extension on data type: `NA` and `NULL`
* Functions

    | `NA` | `NULL` |
    | :---: | :---: |
    | represents lack of data | represents non-existing data |
    | a position without data | no position and no data |
* *e.g.*,

    <a name="code17"></a>
    ```R
    a <- c(NA, NULL, NA)
    a   # Returns NA NA
    length(c(NA, NULL, NA))   # Returns 2
    ```
    > <small>**Functions in this block:** [`c`](#apx-c), [`length`](#apx-length)</small>
##### 2.2.1.3 *Logi* Vectors
> Go [back](#221-vectors), go [down](#2214--chr-vectors), or go to [top](#notes-on-r-learning).

<a name="code18"></a>
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
> <small>**Functions in this block:** [`c`](#apx-c)</small>
##### 2.2.1.4 🚩 *Chr* Vectors
> Go [back](#221-vectors), go [down](#222-matrices), or go to [top](#notes-on-r-learning).

<a name="code19"></a>
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
> <small>**Functions in this block:** [`toupper`](#apx-toupper), [`tolower`](#apx-tolower), [`nchar`](#apx-nchar), [`substring`](#apx-substring), [`as.numeric`](#apx-as.numeric), [`c`](#apx-c), [`as.character`](#apx-as.character), [`strsplit`](#apx-strsplit), [`gsub`](#apx-gsub)</small>

> ※ `[[:pattern:]]` is a regular expression corresponding to **one match** of `pattern`. `alpha` means *letters* (ignoring upper/lower cases), `alnum` means *numbers*, `+` means the pattern before `+` *can occur single or multiple time(s)*.
#### 2.2.2 **Matrices**
* **Matrices** are **`2D` strings** of data **of a same type**
##### 2.2.2.1 Basics in Matrices
> Go [back](#222-matrices), go [down](#2222-advance-in-matrices), or go to [top](#notes-on-r-learning).

###### 2.2.2.1.1 **Creating** matrices
* Create matrix with `matrix` function

    <a name="code20"></a>
    ```R
    matrix(data = data, nrow = m, ncol = n, byrow = TRUE, dimnames = list)
    ```
    > <small>**Functions in this block:** [`matrix`](#apx-matrix)</small>
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
    
    <a name="code21"></a>
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
    > <small>**Functions in this block:** [`matrix`](#apx-matrix)</small>
* Creating matrix with vectors

    <a name="code22"></a>
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
    > <small>**Functions in this block:** [`c`](#apx-c), [`matrix`](#apx-matrix), [`list`](#apx-list), [`rownames`](#apx-rownames), [`colnames`](#apx-colnames)</small>
* ※ Creating things with random numbers

  <a name="code23"></a>
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
  > <small>**Functions in this block:** [`matrix`](#apx-matrix), [`rnorm`](#apx-rnorm), [`sample`](#apx-sample)</small>
###### 2.2.2.1.2 **Accessing** and **modifying** elements within a matrix

<a name="code24"></a>
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
> <small>**Functions in this block:** [`matrix`](#apx-matrix), [`c`](#apx-c), [`as.numeric`](#apx-as.numeric), [`paste`](#apx-paste), [`dim`](#apx-dim), [`nrow`](#apx-nrow), [`ncol`](#apx-ncol)</small>
###### 2.2.2.1.3 **Calculation** of matrices

<a name="code25"></a>
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
> <small>**Functions in this block:** [`matrix`](#apx-matrix), [`multiplication`](#apx-multiplication)</small>
##### 2.2.2.2 Advance in Matrices
> Go [back](#222-matrices), go [down](#223-arrays), or go to [top](#notes-on-r-learning).

###### 2.2.2.2.1 🚩 **Operation** on rows and cols

<a name="code26"></a>
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
> <small>**Functions in this block:** [`matrix`](#apx-matrix), [`rowSums`](#apx-rowSums), [`colSums`](#apx-colSums), [`mean`](#apx-mean), [`rowMeans`](#apx-rowMeans), [`colMeans`](#apx-colMeans), [`cbind`](#apx-cbind), [`rbind`](#apx-rbind)</small>
###### 2.2.2.2.2 **Advance calculation** of matrices

<a name="code27"></a>
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
> <small>**Functions in this block:** [`solve`](#apx-solve), [`round`](#apx-round), [`ginv`](#apx-ginv), [`svd`](#apx-svd), [`diag`](#apx-diag), [`eigen`](#apx-eigen), [`c`](#apx-c)</small>

> `round` 取整. *e.g.*, `round(0.98)` returns `1`.
#### 2.2.3 **Arrays**
* **Arrays** are **multi-dim strings** of data **of a same type**
  * A matrix could be interpreted as a `2D` array, whereas a vector is `1D`
##### 2.2.3.1 Basics in Array
> Go [back](#223-arrays), go [down](#224-data-frames), or go to [top](#notes-on-r-learning).
###### 2.2.3.1.1 **Creating** arrays

<a name="code28"></a>
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
> <small>**Functions in this block:** [`array`](#apx-array), [`c`](#apx-c), [`list`](#apx-list)</small>
###### 2.2.3.1.2 **Accessing** elements within an array

<a name="code29"></a>
```R
print(Ω[3,1,2])  # Or Ω[3,1,2]
print(Ω[3,1,])  # Returns vector
print(Ω[3,,]) # Returns matrix

# Creating matrices from arrays
M(Ω) <- Ω[2,,]
```
> <small>**Functions in this block:** [`print`](#apx-print)</small>
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

  <a name="code30"></a>
  ```R
  # Creating data frames
  data.frame(tag1 = vector1, tag2 = vector2, row.names = rname)
  ```
  > <small>**Functions in this block:** [`data.frame`](#apx-data.frame)</small>
  * `tag` is the colname
  * `row.names` defines rownames, default is `NULL`
* *e.g.*,

  <a name="code31"></a>
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
  > <small>**Functions in this block:** [`c`](#apx-c), [`data.frame`](#apx-data.frame)</small>
###### 2.2.4.1.2 **Accessing** and **modifying** elements within a data frame

<a name="code32"></a>
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
> <small>**Functions in this block:** [`str`](#apx-str), [`summary`](#apx-summary), [`rep`](#apx-rep)</small>
###### 2.2.4.1.2 **Operation** on rows and cols

<a name="code33"></a>
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
> <small>**Functions in this block:** [`data.frame`](#apx-data.frame), [`c`](#apx-c), [`cbind`](#apx-cbind), [`rbind`](#apx-rbind)</small>
#### 2.2.5 **Lists**
* **Lists** are containers of **different** types/structures of data
  * May include *data*, *vectors*, *matrices*, *arrays*, *data frames*, and even other *lists*.
##### 2.2.5.1 Basics in List
> Go [back](#225-lists), go [down](#2252-advance-in-list), or go to [top](#notes-on-r-learning).
###### 2.2.5.1.1 **Creating** lists

<a name="code34"></a>
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
> <small>**Functions in this block:** [`list`](#apx-list), [`c`](#apx-c), [`matrix`](#apx-matrix), [`names`](#apx-names)</small>
###### 2.2.5.1.2 **Accessing** and **modifying** elements within a list

<a name="code35"></a>
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

<a name="code36"></a>
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
> <small>**Functions in this block:** [`list`](#apx-list), [`c`](#apx-c), [`unlist`](#apx-unlist)</small>
##### 2.2.5.2 Advance in List
> Go [back](#225-lists), go [down](#3-data-management), or go to [top](#notes-on-r-learning).

<a name="code37"></a>
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
> <small>**Functions in this block:** [`list`](#apx-list), [`c`](#apx-c), [`data.frame`](#apx-data.frame)</small>
---
## 3. Data Management
* **Importing** and **exporting** common files
### 3.1 `csv` and `xlsx` files
> Go [back](#3-data-management), go [down](#32-txt-files), or go to [top](#notes-on-r-learning).

> `csv` files use comma as separators to store forms. If a string contains comma, `csv` wraps it with `""`. For example, in `sample.csv`:

<a name="code38"></a>
```R
num,chr,logi
1,a,TRUE
2,b,FALSE
3,c,TRUE
4,d,FALSE
```
#### 3.1.1 **Reading** and **saving** `csv` files

<a name="code39"></a>
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
> <small>**Functions in this block:** [`read.csv`](#apx-read.csv), [`subset`](#apx-subset), [`write.csv`](#apx-write.csv)</small>
#### 3.1.2 **Operation** on `xlsx` files
* ※ Operation on `xlsx` files requires installing package `"xlsx"`:
  
  <a name="code40"></a>
  ```R
  install.packages("xlsx")
  library("xlsx")
  ```
  > <small>**Functions in this block:** [`install.packages`](#apx-install.packages), [`library`](#apx-library)</small>
* Operation:

  <a name="code41"></a>
  ```R
  # Read
  XLSX_Data <- read.xlsx("sample.xlsx", sheetIndex = 1)
  # Argument sheetIndex defines which sheet inside the file to read

  # Write
  write.xlsx(XLSX_Data, "samples.xlsx", sheetName = "new_sample", append = TRUE)
  # append = TRUE means that the created new sheet is in the original file after the last sheet in that file (追加)
  # append = FALSE means override (覆盖)
  ```
  > <small>**Functions in this block:** [`read.xlsx`](#apx-read.xlsx), [`write.xlsx`](#apx-write.xlsx)</small>
### 3.2 `txt` files
> Go [back](#3-data-management), go [down](#4-advanced-data-management), or go to [top](#notes-on-r-learning).

<a name="code42"></a>
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
> <small>**Functions in this block:** [`read.table`](#apx-read.table), [`write.table`](#apx-write.table)</small>
## 4. Advanced Data Management
### 4.1 **Loop** Sentences
> Go [back](#4-advanced-data-management), go [down](#42-apply-functions), or go to [top](#notes-on-r-learning).
#### 4.1.1 `for` loop
* Basics in `for` loop

  <a name="code43"></a>
  ```R
  for (i in 1:3) {
    print(i)
  } # Returns 1 2 3

  v <- rep("a",3)
  for (i in v) {
    print(i)
  } # Returns "a" "a" "a"
  ```
  > <small>**Functions in this block:** [`print`](#apx-print), [`rep`](#apx-rep)</small>

  > *i.e.*, as long as `i in vector`, `for` loop is effective, and its cycle time is the length of that `vector`
  * Calculating *vector* sum
    <a name="code44"></a>
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
    > <small>**Functions in this block:** [`runif`](#apx-runif), [`length`](#apx-length), [`print`](#apx-print)</small>
  * Calculating *matrix* sum
    <a name="code45"></a>
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
    > <small>**Functions in this block:** [`matrix`](#apx-matrix), [`runif`](#apx-runif), [`nrow`](#apx-nrow), [`ncol`](#apx-ncol), [`print`](#apx-print)</small>
* Advance in `for` loop
  * ※ `cat` v. `print`
  
    <a name="code46"></a>
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
    > <small>**Functions in this block:** [`print`](#apx-print), [`cat`](#apx-cat)</small>
  * Create a table
  
    <a name="code47"></a>
    ```R
    for (i in 1:9) {
      for (j in 1:i) {
        m = j * i
        cat(i,"*",j,"=",m,"\t")
      }
      cat("\n")
    }
    ```
    > <small>**Functions in this block:** [`cat`](#apx-cat)</small>
#### 4.1.2 `while` loop
* Basics in `while` loop

  <a name="code48"></a>
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
  > <small>**Functions in this block:** [`statement`](#apx-statement), [`print`](#apx-print)</small>
* `while` can do sth. `for` can't

  <a name="code49"></a>
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
  > <small>**Functions in this block:** [`seq`](#apx-seq), [`print`](#apx-print), [`paste`](#apx-paste)</small>
### 4.2 `apply` Functions
> Go [back](#4-advanced-data-management), go [down](), or go to [top](#notes-on-r-learning).

> `apply` functions are a family of functions to replace `for` loop for maximum computation speed
* `apply` functions function on *arrays* or *lists*
  * ※ *matrices*/*vectors* are specific *arrays*; *data frames* are specific *lists*
  * Family members in `apply`
  
    | Target | Apply to **every element** | Apply to a **subset** |
    | :---: | :---: | :---: |
    | *Array* | [`apply`](#421-apply-function) | [`tapply`](#422-tapply-function) |
    | *List* | [`lapply`](#424-lapply-function) (including simpler [`sapply`](#4243-sapply-function)) | [`by`](#423-by-function) |
#### 4.2.1 `apply` function
##### 4.2.1.1 Basic grammar
> Go [back](#421-apply-function), go [down](#4222-example), or go to [top](#notes-on-r-learning).

<a name="code50"></a>
```R
apply(array, margin, FUN)
```
> <small>**Functions in this block:** [`apply`](#apx-apply)</small>
* `margin` defines which dimension to operate
  > *e.g.*, for a *matrix*, `margin` = `1` means operating on its rows, = `2` means operating on its cols
* `FUN` is the operation to apply on the defined `margin`
##### 4.2.2.2 Example
> Go [back](#421-apply-function), go [down](#422-tapply-function), or go to [top](#notes-on-r-learning).

<a name="code51"></a>
```R
# 2D array
M <- array(1:10, c(2,5))
M
# Returns
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10

apply(M, 1, sum)  # Sum in each row
# Returns
[1] 25 30
apply(M, 2, sum)  # Sum in each col
# Returns
[1]  3  7 11 15 19

# 3D array
Ω <- array(1:24, c(2,3,4))
apply(Ω, 1, sum)
# Returns
[1] 144 156 # length=2 vector
apply(Ω, 2, sum)
# Returns
[1]  84 100 116 # length=3 vector

apply(Ω, c(1,2), sum)
# Returns 2*3 matrix
     [,1] [,2] [,3]
[1,]   40   48   56
[2,]   44   52   60
```
> <small>**Functions in this block:** [`array`](#apx-array), [`c`](#apx-c), [`apply`](#apx-apply)</small>
#### 4.2.2 `tapply` function
##### 4.2.2.1 Basic Grammar
> Go [back](#422-tapply-function), go [down](#4222-example), or go to [top](#notes-on-r-learning).

<a name="code52"></a>
```R
tapply(array, indices, FUN = NULL)
```
> <small>**Functions in this block:** [`tapply`](#apx-tapply)</small>
* `indices` is a group variant that selects the target from the array, similar to `margin`
* `FUN` describes the operation
#### 4.2.2.2 Example
> Go [back](#422-tapply-function), go [down](#423-by-function), or go to [top](#notes-on-r-learning).

<a name="code53"></a>
```R
# 1D vector
v <- c(1:5)
group <- c("a", "a", "a", "b", "b")
tapply(v, group)
# Returns
[1] 1 1 1 2 2 # Appoint a as 1, b as 2

tapply(v, group, sum)
# Returns
a b 
6 9
# 6 = 1 + 2 + 3; 9 = 4 + 5

# 2D matrix
M <- matrix(1:10, 2)
group <- matrix(c(rep(1,5), rep(2,5)), 2, byrow = TRUE)
group
# Returns
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    1    1    1    1
[2,]    2    2    2    2    2

tapply(M, group, mean)
# Returns
1 2
5 6
# 5 = mean(1,3,5,7,9); 6 = mean(2,4,6,8,10)
```
> <small>**Functions in this block:** [`c`](#apx-c), [`tapply`](#apx-tapply), [`matrix`](#apx-matrix), [`rep`](#apx-rep), [`mean`](#apx-mean)</small>
#### 4.2.3 `by` function

<a name="code54"></a>
```R
DF <- data.frame('a' = c(1:5), 'b' = c(6:10))
DF
# Returns
  a  b
1 1  6
2 2  7
3 3  8
4 4  9
5 5 10

group <- c(1,1,1,2,2)
by(DF, group, colMeans)
# Returns
group: 1
a b
2 7
---
group: 2
  a   b
4.5 9.5
# for all elements grouped as 1, show their means as columns
# 2 = mean(1,2,3); 7 = mean(6,7,8); 4.5 = mean(4,5); 9.5 = mean(9,10)
```
> <small>**Functions in this block:** [`data.frame`](#apx-data.frame), [`c`](#apx-c), [`by`](#apx-by), [`mean`](#apx-mean)</small>
#### 4.2.4 `lapply` function
##### 4.2.4.1 Basic Grammar
> Go [back](#424-lapply-function), go [down](#4242-practical-usage), or go to [top](#notes-on-r-learning).
<a name="code55"></a>
```R
List <- list('a' = c(1:5), 'b' = c(6:10))
lapply(List, mean)  # Operate on every element in List
# Returns the following LIST
$a
[1] 3

$b
[1] 8
# 3 = mean(1:5), 8 = mean(6:10)
as.data.frame(lapply(List, mean)) # Returns a data frame
```
> <small>**Functions in this block:** [`list`](#apx-list), [`c`](#apx-c), [`lapply`](#apx-lapply), [`mean`](#apx-mean), [`as.data.frame`](#apx-as.data.frame)</small>
##### 4.2.4.2 Practical Usage
> Go [back](#424-lapply-function), go [down](#4243-sapply-function), or go to [top](#notes-on-r-learning).
* Processing strings

  <a name="code56"></a>
  ```R
  Chrs <- c(paste("chr", 1:22, sep = "_"), "chr_X", "chr_Y")
  Chrs
  # Returns
  [1] "chr_1"  "chr_2"  "chr_3"  "chr_4"  "chr_5"  "chr_6"  "chr_7"  "chr_8" 
  [9] "chr_9"  "chr_10" "chr_11" "chr_12" "chr_13" "chr_14" "chr_15" "chr_16"
  [17] "chr_17" "chr_18" "chr_19" "chr_20" "chr_21" "chr_22" "chr_X"  "chr_Y"

  # Use lapply to extract the data after "chr_"
  # 1. Split each string to 2 parts
  Chrs_split <- strsplit(Chrs, "_")
  # This is a list of vectors like "chr" "1"
  # 2. lapply the list above
  Chrs_split_col2 <- lapply(Chrs_split, function(x) x[2])
  # Returns a list composed of "1", "2", etc.
  # 3. Transform list to vector
  unlist(Chrs_split_col2)
  ```
  > <small>**Functions in this block:** [`c`](#apx-c), [`paste`](#apx-paste), [`strsplit`](#apx-strsplit), [`lapply`](#apx-lapply), [`unlist`](#apx-unlist)</small>

  > ※ `function` function: define a function as described. *e.g.*,

  <a name="code57"></a>
  ```R
  function(x) x[2]
  # x is now a function

  lapply(Chrs_split, function(x) x[2])
  # When read the first element in the list ("chr" "1"), x = c("chr", "1")
  # As defined, the function should extract the second element in x, namely "1"
  ```
  > <small>**Functions in this block:** [`lapply`](#apx-lapply)</small>
* Practical problem
  <a name="code58"></a>
  ```R
  # Create data frame
  gene_num <- kronecker(1:3, rep(1,4))
  # Returns 1 1 1 1 2 2 2 2 3 3 3 3
  genes <- paste("gene", gene_num, sep = "_")
  statistics <- rnorm(12)
  annotation <- factor(
    sample(0:1, 12, replace = TRUE),
    levels = c(0,1),
    labels = c("intron", "extron")
  )
  DF <- data.frame('gene' = genes, 'annotation' = annotation, 'statistics' = statistics)
  DF
  # Returns
       gene annotation statistics
  1  gene_1     extron -1.5428729
  2  gene_1     intron  0.2065718
  3  gene_1     intron -0.5648594
  4  gene_1     extron -1.6124580
  5  gene_2     intron  1.9675348
  6  gene_2     extron  2.0591199
  7  gene_2     intron -0.4296537
  8  gene_2     extron -1.2477404
  9  gene_3     intron -0.6384987
  10 gene_3     intron  0.8182184
  11 gene_3     intron -1.3381384
  12 gene_3     extron -1.6277678

  # Use tapply to group each gene
  tapply(DF$statistics, DF$gene, sum)
  # Returns
     gene_1    gene_2    gene_3 
  -3.513619  2.349261 -2.786187

  # Use tapply to group each gene and then group each annotation
  tapply(DF$statistics, DF[,c('gene', 'annotation')], sum)
  # Returns
             intron     extron
  gene_1 -0.3582876 -3.1553309
  gene_2  1.5378811  0.8113795
  gene_3 -1.1584188 -1.6277678
  ```
  > <small>**Functions in this block:** [`kronecker`](#apx-kronecker), [`rep`](#apx-rep), [`paste`](#apx-paste), [`rnorm`](#apx-rnorm), [`factor`](#apx-factor), [`sample`](#apx-sample), [`c`](#apx-c), [`data.frame`](#apx-data.frame), [`tapply`](#apx-tapply)</small>
##### 4.2.4.3 `sapply` function
> Go [back](#424-lapply-function), go [down](#425-mapply-function), or go to [top](#notes-on-r-learning).

> Contains argument `simplify`; if `simplify` = `TRUE`, it returns a vector/matrix (doesn't require `unlist`); otherwise, `sapply` is identical with `lapply`

<a name="code59"></a>
```R
Chrs_split_col2 <- sapply(Chrs_split, function(x) x[2], simplify = TRUE)
# Chrs_split_col2 is now a vector itself
```
> <small>**Functions in this block:** [`sapply`](#apx-sapply)</small>
#### 4.2.5 `mapply` function
> Could import **multiple** data
> Key difference: `mapply(FUN, data1, data2)` (`FUN` is the 1<sup>st</sup> argument) 
* Usage in *lists*

  <a name="code60"></a>
  ```R
  # Create three lists
  for (i in 1:3) {
    assign(
      paste("List", i, sep = ""),
      list('a' = 3*i - 2, 'b' = 3*i - 1, 'c' = 3*i)
    )
  }

  # mapply function
  mapply(sum, List1, List2, List3)
  # Returns a vector (default SIMPLIFY = TRUE)
  a  b  c 
  12 15 18
  # 12 = 1 + 4 + 7, etc.
  mapply(sum, List1, List2, List3, SIMPLIFY = FALSE)
  # Returns a list
  $a
  [1] 12

  $b
  [1] 15

  $c
  [1] 18
  ```
  > <small>**Functions in this block:** [`assign`](#apx-assign), [`paste`](#apx-paste), [`list`](#apx-list), [`mapply`](#apx-mapply), [`vector`](#apx-vector)</small>
* Usage in *vectors*

  <a name="code61"></a>
  ```R
  mapply(function(x,y) x^y, c(1:5), c(1:5))
  # Returns a vector
  [1]    1    4   27  256 3125

  mapply(function(x,y) c(x+y, x^y), c(1:5), c(1:5))
  # Returns a matrix
       [,1] [,2] [,3] [,4] [,5]
  [1,]    2    4    6    8   10
  [2,]    1    4   27  256 3125
  ```
  > <small>**Functions in this block:** [`mapply`](#apx-mapply), [`c`](#apx-c)</small>
---

# Apx. Cheatsheet

###### 1. <a name="apx-apply"></a> `apply` : [1](#code50) [2](#code51)
<small>
</small>

###### 2. <a name="apx-array"></a> `array` : [1](#code28) [2](#code51)
<small>
</small>

###### 3. <a name="apx-as.character"></a> `as.character` : [1](#code19)
<small>
</small>

###### 4. <a name="apx-as.data.frame"></a> `as.data.frame` : [1](#code55)
<small>
</small>

###### 5. <a name="apx-as.factor"></a> `as.factor` : [1](#code8)
<small>
</small>

###### 6. <a name="apx-as.integer"></a> `as.integer` : [1](#code6)
<small>
</small>

###### 7. <a name="apx-as.numeric"></a> `as.numeric` : [1](#code19) [2](#code24)
<small>
</small>

###### 8. <a name="apx-assign"></a> `assign` : [1](#code60)
<small>
</small>

###### 9. <a name="apx-BiocManager-install"></a> `BiocManager::install` : [1](#code1)
<small>
</small>

###### 10. <a name="apx-by"></a> `by` : [1](#code54)
<small>
</small>

###### 11. <a name="apx-c"></a> `c` : [1](#code8) [2](#code9) [3](#code10) [4](#code11) [5](#code12) [6](#code13) [7](#code14) [8](#code16) [9](#code17) [10](#code18) [11](#code19) [12](#code22) [13](#code24) [14](#code27) [15](#code28) [16](#code31) [17](#code33) [18](#code34) [19](#code36) [20](#code37) [21](#code51) [22](#code53) [23](#code54) [24](#code55) [25](#code56) [26](#code58) [27](#code61)
<small>
</small>

###### 12. <a name="apx-cat"></a> `cat` : [1](#code46) [2](#code47)
<small>
</small>

###### 13. <a name="apx-cbind"></a> `cbind` : [1](#code26) [2](#code33)
<small>
</small>

###### 14. <a name="apx-class"></a> `class` : [1](#code7)
<small>
</small>

###### 15. <a name="apx-colMeans"></a> `colMeans` : [1](#code26)
<small>
</small>

###### 16. <a name="apx-colnames"></a> `colnames` : [1](#code22)
<small>
</small>

###### 17. <a name="apx-colSums"></a> `colSums` : [1](#code26)
<small>
</small>

###### 18. <a name="apx-data.frame"></a> `data.frame` : [1](#code30) [2](#code31) [3](#code33) [4](#code37) [5](#code54) [6](#code58)
<small>
</small>

###### 19. <a name="apx-diag"></a> `diag` : [1](#code27)
<small>
</small>

###### 20. <a name="apx-dim"></a> `dim` : [1](#code24)
<small>
</small>

###### 21. <a name="apx-eigen"></a> `eigen` : [1](#code27)
<small>
</small>

###### 22. <a name="apx-factor"></a> `factor` : [1](#code8) [2](#code10) [3](#code58)
<small>
</small>

###### 23. <a name="apx-getwd"></a> `getwd` : [1](#code3)
<small>
</small>

###### 24. <a name="apx-ginv"></a> `ginv` : [1](#code27)
<small>
</small>

###### 25. <a name="apx-gl"></a> `gl` : [1](#code9)
<small>
</small>

###### 26. <a name="apx-gsub"></a> `gsub` : [1](#code19)
<small>
</small>

###### 27. <a name="apx-install"></a> `install` : [1](#code1)
<small>
</small>

###### 28. <a name="apx-install.packages"></a> `install.packages` : [1](#code1) [2](#code40)
<small>
</small>

###### 29. <a name="apx-is.integer"></a> `is.integer` : [1](#code7)
<small>
</small>

###### 30. <a name="apx-is.numeric"></a> `is.numeric` : [1](#code7)
<small>
</small>

###### 31. <a name="apx-kronecker"></a> `kronecker` : [1](#code58)
<small>
</small>

###### 32. <a name="apx-lapply"></a> `lapply` : [1](#code55) [2](#code56) [3](#code57)
<small>
</small>

###### 33. <a name="apx-length"></a> `length` : [1](#code17) [2](#code44)
<small>
</small>

###### 34. <a name="apx-library"></a> `library` : [1](#code2) [2](#code40)
<small>
</small>

###### 35. <a name="apx-list"></a> `list` : [1](#code22) [2](#code28) [3](#code34) [4](#code36) [5](#code37) [6](#code55) [7](#code60)
<small>
</small>

###### 36. <a name="apx-mapply"></a> `mapply` : [1](#code60) [2](#code61)
<small>
</small>

###### 37. <a name="apx-matrix"></a> `matrix` : [1](#code20) [2](#code21) [3](#code22) [4](#code23) [5](#code24) [6](#code25) [7](#code26) [8](#code34) [9](#code45) [10](#code53)
<small>
</small>

###### 38. <a name="apx-max"></a> `max` : [1](#code16)
<small>
</small>

###### 39. <a name="apx-mean"></a> `mean` : [1](#code16) [2](#code26) [3](#code53) [4](#code54) [5](#code55)
<small>
</small>

###### 40. <a name="apx-median"></a> `median` : [1](#code16)
<small>
</small>

###### 41. <a name="apx-min"></a> `min` : [1](#code16)
<small>
</small>

###### 42. <a name="apx-multiplication"></a> `multiplication` : [1](#code25)
<small>
</small>

###### 43. <a name="apx-names"></a> `names` : [1](#code34)
<small>
</small>

###### 44. <a name="apx-nchar"></a> `nchar` : [1](#code19)
<small>
</small>

###### 45. <a name="apx-ncol"></a> `ncol` : [1](#code24) [2](#code45)
<small>
</small>

###### 46. <a name="apx-nrow"></a> `nrow` : [1](#code24) [2](#code45)
<small>
</small>

###### 47. <a name="apx-order"></a> `order` : [1](#code8) [2](#code16)
<small>
</small>

###### 48. <a name="apx-paste"></a> `paste` : [1](#code15) [2](#code24) [3](#code49) [4](#code56) [5](#code58) [6](#code60)
<small>
</small>

###### 49. <a name="apx-print"></a> `print` : [1](#code29) [2](#code43) [3](#code44) [4](#code45) [5](#code46) [6](#code48) [7](#code49)
<small>
</small>

###### 50. <a name="apx-prod"></a> `prod` : [1](#code16)
<small>
</small>

###### 51. <a name="apx-rbind"></a> `rbind` : [1](#code26) [2](#code33)
<small>
</small>

###### 52. <a name="apx-read.csv"></a> `read.csv` : [1](#code39)
<small>
</small>

###### 53. <a name="apx-read.table"></a> `read.table` : [1](#code42)
<small>
</small>

###### 54. <a name="apx-read.xlsx"></a> `read.xlsx` : [1](#code41)
<small>
</small>

###### 55. <a name="apx-rep"></a> `rep` : [1](#code11) [2](#code32) [3](#code43) [4](#code53) [5](#code58)
<small>
</small>

###### 56. <a name="apx-rev"></a> `rev` : [1](#code16)
<small>
</small>

###### 57. <a name="apx-rm"></a> `rm` : [1](#code5)
<small>
</small>

###### 58. <a name="apx-rnorm"></a> `rnorm` : [1](#code23) [2](#code58)
<small>
</small>

###### 59. <a name="apx-round"></a> `round` : [1](#code27)
<small>
</small>

###### 60. <a name="apx-rowMeans"></a> `rowMeans` : [1](#code26)
<small>
</small>

###### 61. <a name="apx-rownames"></a> `rownames` : [1](#code22)
<small>
</small>

###### 62. <a name="apx-rowSums"></a> `rowSums` : [1](#code26)
<small>
</small>

###### 63. <a name="apx-runif"></a> `runif` : [1](#code44) [2](#code45)
<small>
</small>

###### 64. <a name="apx-sample"></a> `sample` : [1](#code23) [2](#code58)
<small>
</small>

###### 65. <a name="apx-sapply"></a> `sapply` : [1](#code59)
<small>
</small>

###### 66. <a name="apx-seq"></a> `seq` : [1](#code11) [2](#code49)
<small>
</small>

###### 67. <a name="apx-setwd"></a> `setwd` : [1](#code3)
<small>
</small>

###### 68. <a name="apx-solve"></a> `solve` : [1](#code27)
<small>
</small>

###### 69. <a name="apx-sort"></a> `sort` : [1](#code10) [2](#code16)
<small>
</small>

###### 70. <a name="apx-statement"></a> `statement` : [1](#code48)
<small>
</small>

###### 71. <a name="apx-str"></a> `str` : [1](#code32)
<small>
</small>

###### 72. <a name="apx-strsplit"></a> `strsplit` : [1](#code19) [2](#code56)
<small>
</small>

###### 73. <a name="apx-structure"></a> `structure` : [1](#code8)
<small>
</small>

###### 74. <a name="apx-subset"></a> `subset` : [1](#code39)
<small>
</small>

###### 75. <a name="apx-substring"></a> `substring` : [1](#code19)
<small>
</small>

###### 76. <a name="apx-sum"></a> `sum` : [1](#code16)
<small>
</small>

###### 77. <a name="apx-summary"></a> `summary` : [1](#code32)
<small>
</small>

###### 78. <a name="apx-svd"></a> `svd` : [1](#code27)
<small>
</small>

###### 79. <a name="apx-tapply"></a> `tapply` : [1](#code52) [2](#code53) [3](#code58)
<small>
</small>

###### 80. <a name="apx-tolower"></a> `tolower` : [1](#code19)
<small>
</small>

###### 81. <a name="apx-toupper"></a> `toupper` : [1](#code19)
<small>
</small>

###### 82. <a name="apx-unlist"></a> `unlist` : [1](#code36) [2](#code56)
<small>
</small>

###### 83. <a name="apx-var"></a> `var` : [1](#code16)
<small>
</small>

###### 84. <a name="apx-vector"></a> `vector` : [1](#code60)
<small>
</small>

###### 85. <a name="apx-which.max"></a> `which.max` : [1](#code16)
<small>
</small>

###### 86. <a name="apx-which.min"></a> `which.min` : [1](#code16)
<small>
</small>

###### 87. <a name="apx-write.csv"></a> `write.csv` : [1](#code39)
<small>
</small>

###### 88. <a name="apx-write.table"></a> `write.table` : [1](#code42)
<small>
</small>

###### 89. <a name="apx-write.xlsx"></a> `write.xlsx` : [1](#code41)
<small>
</small>
