# R Vocabulary




# The basics
## The first functions to learn
### Get help on a topic (here for `str`)

```r
?str
```

### Display the structure of an arbitrary R object

```r
str(data.frame(A_col = LETTERS[1:5], 
               B_col = letters[1:5],
               C_col = rnorm(5, mean = 2, sd = 1)))
```

```
## 'data.frame':	5 obs. of  3 variables:
##  $ A_col: Factor w/ 5 levels "A","B","C","D",..: 1 2 3 4 5
##  $ B_col: Factor w/ 5 levels "a","b","c","d",..: 1 2 3 4 5
##  $ C_col: num  2.408 2.117 2.344 0.838 4.145
```

```r
str(data.frame(A_col = LETTERS[1:5], 
               B_col = letters[1:5],
               C_col = rnorm(5, mean = 2, sd = 1),
               stringsAsFactors = FALSE))
```

```
## 'data.frame':	5 obs. of  3 variables:
##  $ A_col: chr  "A" "B" "C" "D" ...
##  $ B_col: chr  "a" "b" "c" "d" ...
##  $ C_col: num  2.21 1.1 1.95 2.29 1.23
```

```r
str(seq_len(5))
```

```
##  int [1:5] 1 2 3 4 5
```

```r
str(matrix(rnorm(10, mean = 5, sd = 2), nrow = 5, ncol = 2))
```

```
##  num [1:5, 1:2] 6.08 6.9 6.09 1.87 1.79 ...
```


## Important operators and assignments
### %in%
`%in%` returns a vector with logical elements indicating whether an element of
vector `x` is also part of a vector `y`.

Example

```r
c("A", "B", "C") %in% "B"
```

```
## [1] FALSE  TRUE FALSE
```


### match()
`match(x, y)` returns a vector of the positions of (first) matches of its first
argument `x` in its second `y`.

Examples

```r
match(c("A", "B", "C", "B"), c("A", "B"))
```

```
## [1]  1  2 NA  2
```

```r
match(c("A", "B", "C", "B"), c("A", "B"), nomatch = 0)
```

```
## [1] 1 2 0 2
```

```r
match(c("A", "B", "C", "B"), c("A", "B"), incomparables = "B")
```

```
## [1]  1 NA NA NA
```

### Assignments 
The operators `<-` and `=` assign into the environment in which it they are 
evaluated. The operator `<-` can be used anywhere whereas the operator `=`
is only allowed at the top level or as one of the subexpressions in a braced 
list of expressions.
The `<<-` operator is used normally only in functions and causes a search
through parent environments for an existing defition oof the variable being
assigned. This operator should be avoided since it writes to the global
environment and makes debugging harder.

### Extract or replace parts of an object
Operators acting on vectors, matrices, arrays and lists to extract or replace
parts.
There are three differetnt operators for data extraction, namely `[`, `[[` and
`$`. The most important distinction between them is that the `[` can select
more than one element whereas the other two select a single element, each.
Moreover, `$` is only valid for recursive (list-like) objects.

Usage:

```r
## Vectors
# Generate a random, named vector.
set.seed(30943)
vec <- rnorm(10, mean = 10, sd = 1)
names(vec) <- letters[seq_len(length(vec))]

# Extract the first element from this vector and preserve name attributes.
vec[1]
```

```
##        a 
## 11.21898
```

```r
# Extract the first element from this vector and drop name attributes.
vec[[1]]
```

```
## [1] 11.21898
```

```r
## Matrices
mat <- matrix(sample(c(0, 1), size = 6, replace = TRUE), nrow = 2, ncol = 3,
              dimnames = list(paste0("Row_", seq_len(2)),
                              paste0("Col_", seq_len(3))))
# Extract the element from the 2nd row and the third column through indices.
mat[2, 3]
```

```
## [1] 1
```

```r
# Extract the element from the 2nd row and the third column through names.
mat["Row_2", "Col_3"]
```

```
## [1] 1
```

```r
# Extract the 2nd column.
mat[, 2]
```

```
## Row_1 Row_2 
##     1     0
```

```r
# Extract the 2nd column, but retain the class "matrix".
mat[, 2, drop = FALSE]
```

```
##       Col_2
## Row_1     1
## Row_2     0
```

```r
# Extract the first and the second column.
mat[, paste0("Col_", c(1, 2))]
```

```
##       Col_1 Col_2
## Row_1     0     1
## Row_2     0     0
```

```r
mat[, c(1, 2)]
```

```
##       Col_1 Col_2
## Row_1     0     1
## Row_2     0     0
```

```r
## Recursive (list-like) objects (lists, data.frames).
lst <- list(First = seq_len(10), Second = LETTERS[1:4], 
            Third = letters[1:2])
lst[["Second"]]
```

```
## [1] "A" "B" "C" "D"
```

```r
lst$Second
```

```
## [1] "A" "B" "C" "D"
```

```r
lst[c(1, 3)]
```

```
## $First
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $Third
## [1] "a" "b"
```


### Return the first or last part of an object
Returns the first or last parts of a vector, matrix, table, data frame or
function.


```r
data(cars)
head(cars)
```

```
##   speed dist
## 1     4    2
## 2     4   10
## 3     7    4
## 4     7   22
## 5     8   16
## 6     9   10
```

```r
head(cars, n = 10)
```

```
##    speed dist
## 1      4    2
## 2      4   10
## 3      7    4
## 4      7   22
## 5      8   16
## 6      9   10
## 7     10   18
## 8     10   26
## 9     10   34
## 10    11   17
```

```r
head(letters[1:10])
```

```
## [1] "a" "b" "c" "d" "e" "f"
```

```r
tail(cars, n = 7)
```

```
##    speed dist
## 44    22   66
## 45    23   54
## 46    24   70
## 47    24   92
## 48    24   93
## 49    24  120
## 50    25   85
```

### subset()
Subsetting vectors, matrices and data frames. This function should only be used
interactively.


```r
data(USArrests)
dim(USArrests)
```

```
## [1] 50  4
```

```r
dim(subset(USArrests, Murder < 10 & UrbanPop >= 50))
```

```
## [1] 30  4
```


### with()
Evaluate the supplied data in a different environment. This is similar to 
`attach` since the elements within the `with` function do not need to be 
preceded with `x$` anymore, but can rather be accessed directly.

Example

```r
dummy <- data.frame(A = c(5, 7, 4), B = c(3, 8, 6), C = letters[1:3])
with(dummy, dummy[A == 5, ])
```

```
##   A B C
## 1 5 3 a
```

```r
with(dummy, dummy[C %in% c("a", "c")])
```

```
##   A C
## 1 5 a
## 2 7 b
## 3 4 c
```


### within()
Allows the construction of a separate environment like `with()` does but 
elements of the supplied data can be accessed and transformed within this 
function, too.

Example

```r
wi_df <- within(dummy, {
  D <- cumsum(A)
  E <- pmin(A, B)
  })
wi_df
```

```
##   A B C E  D
## 1 5 3 a 3  5
## 2 7 8 b 7 12
## 3 4 6 c 4 16
```


### assign()
Assign a value to a name in an environment.

Example

```r
assign("x", value = 5)
x
```

```
## [1] 5
```


### get()
Search by name for an object. `get` is the reverse function of `assign`. It is
particularly useful when indices such as `i` are used in loops and the user 
desires to print the name of the currently evaluated object `i` as the title
of a plot or the name of a file.


Example

```r
set.seed(1234)

smp_df <- data.frame(
  Smp.A = rnorm(n = 1000, mean = 50, sd = 3),
  Smp.B = runif(n = 1000, min = 80, max = 135),
  Smp.C = c(rnorm(n = 500, mean = 30, sd = 2),
            runif(n = 500, min = 32, max = 40)),
  Smp.D = rpois(n = 1000, lambda = 5)
  )

def.par <- par(no.readonly = TRUE) # save default, for resetting...
layout(mat = matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2, byrow = TRUE))

for(i in colnames(smp_df)) {
  
  hist(smp_df[, i], breaks = 50, main = get("i"))
  
}
```

![](HW_Vocabulary_files/figure-html/unnamed-chunk-12-1.png) 



## Comparison
### all.equal, identical
"Near equality" can be tested using `all.equal(x, y)` whereas `identical(x, y)`
tests for exact equality of two objects `x` and `y`.


```r
set.seed(1309)
x <- seq_len(10)
# Add some normally-distributed random noise to the data.
y <- x + rnorm(10, mean = 0, sd = 0.0000001)
all.equal(x, y)
```

```
## [1] TRUE
```

```r
identical(x, y)
```

```
## [1] FALSE
```

### Relational operators (!=, ==, >, >=, <, <=)
Binary operators, which allow the comparison of values in atomic vectors.


```r
x <- seq_len(10)
x[x != 5]
```

```
## [1]  1  2  3  4  6  7  8  9 10
```

```r
x[x == 5]
```

```
## [1] 5
```

```r
x[x > 5]
```

```
## [1]  6  7  8  9 10
```

```r
x[x >= 5]
```

```
## [1]  5  6  7  8  9 10
```

```r
x[x < 5]
```

```
## [1] 1 2 3 4
```

```r
x[x <= 5]
```

```
## [1] 1 2 3 4 5
```

### is.na, complete.cases
### is.finite



## Basic math
## Functions to do with functions


## Logical and sets
### &, |, !, xor

### all, any


### intersect, union, setdiff, setequal
`union` combines all elements of two vectors in a new vector of unique elements.
Example

```r
union(x = c(1, 2, 3, 4), y = c(3, 4, 5))
```

```
## [1] 1 2 3 4 5
```

`setdiff` returns the elements in vector `x`, which are not in `y`
Example

```r
setdiff(x = c(1, 2, 3, 4), y = c(3, 4, 5))
```

```
## [1] 1 2
```

```r
setdiff(x = c(3, 4, 5), y = c(1, 2, 3, 4))
```

```
## [1] 5
```

`setequal` returns a logical vector indicating whether all elements in vector `x` are also elements of vector `y`.
Example

```r
setequal(x = c(3, 1, 2), c(2, 3, 1))
```

```
## [1] TRUE
```

```r
setequal(x = c(1, 2, 3), c(2, 3))
```

```
## [1] FALSE
```


### which()
`which` provides the indices of elements for which a logical condition is `TRUE`.
Example

```r
which(c(3, 4, 6) %in% c(6, 3))
```

```
## [1] 1 3
```

## Vectors and matrices


## Making vectors
### c, rep, rep_len, seq, seq_len, seq_along
The `rep` function replicates elmeents of vectors and lists.
Example

```r
rep(x = 1:4, times = 2)
```

```
## [1] 1 2 3 4 1 2 3 4
```

```r
rep(x = 1:4, each = 2)
```

```
## [1] 1 1 2 2 3 3 4 4
```

```r
rep(x = 1:4, times = c(2, 1, 2, 1))
```

```
## [1] 1 1 2 3 3 4
```

```r
rep(x = 1:4, each = 2, len = 4)
```

```
## [1] 1 1 2 2
```

```r
rep(x = 1:4, each = 2, len = 10)
```

```
##  [1] 1 1 2 2 3 3 4 4 1 1
```

```r
rep(x = 1:2, each = 2, times = 3)
```

```
##  [1] 1 1 2 2 1 1 2 2 1 1 2 2
```

`rep_len` replicates and outputs a given number of elements as specified by `length`.
Example

```r
rep_len(x = c(1:4), length = 10)
```

```
##  [1] 1 2 3 4 1 2 3 4 1 2
```

Regular sequences can be created using `seq`.
Example

```r
seq(from = 0, to = 1, length.out = 1)
```

```
## [1] 0
```

```r
seq(from = 1, to = 9, by = 2)
```

```
## [1] 1 3 5 7 9
```

```r
seq(from = 1, to = 6, by = 3)
```

```
## [1] 1 4
```

```r
seq_len(length.out = 4)
```

```
## [1] 1 2 3 4
```

```r
seq_along(along.with = c(0.1, 34, 8, 9, 2))
```

```
## [1] 1 2 3 4 5
```

### rev

### sample, choose, factorial, combn
`sample()` takes a sample of the specified size form the elements of `x` either with or without replacement.
Example

```r
sample(x = LETTERS, size = 5, replace = TRUE)
```

```
## [1] "O" "Z" "R" "A" "J"
```
### (is/as).(character/numeric/logical/...)



## Lists & data.frames
### list, unlist
### data.frame, as.data.frame
### split
### expand.grid



## Control Flow
### if, &&, || (short circuiting)
### for, while
### next, break
### switch
### ifelse


## Apply & friends
### lapply, sapply, vapply
### apply
### tapply
### replicate




# Common data structures

## Character manipulation

### grep()
The call `grep(pattern, x)` searches for a specified substring `pattern` in
a vector `x` of strings. If `x` has _n_ elements - that is, it contains _n_ 
strings - then `grep(pattern, x)` will return a vector of length up to _n_. 
Each element of this vector will be the index in `x` at which a match of
`pattern` as a substring of `x[i]` was found.

Example

```r
grep("Pole", c("Equator", "North Pole", "South Pole"))
```

```
## [1] 2 3
```

```r
grep("pole", c("Equator", "North Pole", "South Pole"))
```

```
## integer(0)
```

```r
grep("Pole", c("Equator", "North Pole", "South Pole"), value = TRUE)
```

```
## [1] "North Pole" "South Pole"
```
In the first case, the string `"Pole"` was found in elements 2 and 3 of the 
second argument, hence the output `(2,3)`. In the second case, string `"pole"`
was not found anywhere, so an empty vector was returned. In the third case,
`grep(pattern, x, value= TRUE)` returns a character vector containing the 
selected elements of `x`.


### agrep()
The call `agrep(pattern, x)` searches for __approximate__ matches to `pattern`
within each element of the string `x`.

```r
agrep("pole", c("Equator", "North Pole", "South Pole"))
```

```
## [1] 2 3
```
In this case, the string `"pole"` was found in elements 2 and 3 of the second
argument despite differences in the case of "P".


### gsub()
The call `gsub(pattern, replacement, x)` searches for matches to argument 
`pattern` within each element of a character vector and performs replacement of
all matches.

```r
gsub(pattern = "\\.", replacement = "_", 
     x = c("LP.01", "LP.370", "LP371"))
```

```
## [1] "LP_01"  "LP_370" "LP371"
```
In this case, the pattern `"."` in the string `x` was replaced by the 
`replacement` `"_"`.

### strsplit()
The call `strsplit(x, split)` split a string `x` into an R list of substrings 
based on another string split in `x`. 

Example

```r
strsplit(x = "F103xD060", split = "x")
```

```
## [[1]]
## [1] "F103" "D060"
```


### chartr()
`chartr(old, new, x)` translates each character in `x` that is specified in 
`old` to the corresponding character specified in `new`.

Example

```r
chartr(old = "._", new = "_x", x = "HDF.375_110")
```

```
## [1] "HDF_375x110"
```
In this case, each `"."` in `x` was replaced by a `"_"` whereas each `"_"` in 
`x` was replaced by a `"x"`.


### nchar()
The call `nchar(x)` finds the length of a string `x`. Note, that the string 
must be of class `character`.

Example

```r
nchar("South Pole")
```

```
## [1] 10
```
The string `"South Pole"` was found to have 10 characters.


### tolower(), toupper()
`tolower(x)` and `toupper(x)` convert upper-case characters in a character 
vector to lower-case, or vice versa. Non-alphabetic characters are left 
unchanged.

Example

```r
x <- "miXeD cAsE 123"
tolower(x)
```

```
## [1] "mixed case 123"
```

```r
toupper(x)
```

```
## [1] "MIXED CASE 123"
```


### substr()
The call `substr(x, start, stop)` returns the substring in a given character
position range `start:stop` in the given string `x`.

Example

```r
substring(text = "Equator", first = 3, last = 5)
```

```
## [1] "uat"
```


### paste()
The call `paste(...)` concatenates several strings, returning the result in one
long string. 

Examples

```r
paste("North", "Pole")
```

```
## [1] "North Pole"
```

```r
paste("North", "Pole", sep = "")
```

```
## [1] "NorthPole"
```

```r
paste("North", "Pole", sep = ".")
```

```
## [1] "North.Pole"
```

```r
paste("North", "and", "South", "Poles")
```

```
## [1] "North and South Poles"
```
As you can see, the optional argument `sep` can be used to put something other
than a space between the pieces being spliced together. If you specify `sep` as
an empty string, the pieces won't have any characters between them.


### paste0()
The call `paste0(...)` is a shortcut for `paste(..., sep = "", collapse = NULL)`, which is a common case for the concatenation of long files names.

Example

```r
paste0("./very/long/path/to/a/", 
       "directory/and/a/certain/file.txt")
```

```
## [1] "./very/long/path/to/a/directory/and/a/certain/file.txt"
```



## Factors

### factor()
The function `factor` is used to encode a vector as a factor. If argument
`ordered` is `TRUE`, the factor levels are assumed to be ordered.

Examples

```r
factor(c("LP01", "LP370", "LP371"))
```

```
## [1] LP01  LP370 LP371
## Levels: LP01 LP370 LP371
```

```r
factor(c("LP01", "LP370", "LP371"), labels = c("Trial_1", "Trial_2", "Trial_3"))
```

```
## [1] Trial_1 Trial_2 Trial_3
## Levels: Trial_1 Trial_2 Trial_3
```


### gl()
Generate factors by specifying the pattern of their levels.
`gl(n, k, length= n*k, labels= seq_len(n), ordered= FALSE)`
* `n` an integer giving the number of levels
* `k` an integer giving the number of replications
* `length` an integer giving the length of the result
* `labels` an optional vector of labels for the resulting factor levels
* `ordered` a logical indicating whether the result should be ordered or not

Examples

```r
gl(n = 2, k = 8, labels = c("Control", "Treatment"))
```

```
##  [1] Control   Control   Control   Control   Control   Control   Control  
##  [8] Control   Treatment Treatment Treatment Treatment Treatment Treatment
## [15] Treatment Treatment
## Levels: Control Treatment
```


### levels()
`levels` provides access to the levels attributed of a variable. The first form
`levels(x)` returns the value of the levels of its argument `x` and the second
`levels(x) <- value` sets the attribute.

Examples

```r
## assign individual levels
x <- gl(n = 2, k = 4, length = 8)
levels(x)[1] <- "low"
levels(x)[2] <- "high"
x
```

```
## [1] low  low  low  low  high high high high
## Levels: low high
```


### nlevels()
Return the number of levels which its argument `x` has.

Example

```r
nlevels(gl(n = 3, k = 7))
```

```
## [1] 3
```


### reorder()
The `"default"` method treats its first argument `x` as a categorical variable
and reorder its levels based on the values of a second variable `X`, usually
numeric.

Example

```r
reorder(x = factor(c("large", "small", "huge")), X = c(2, 1, 3))
```

```
## [1] large small huge 
## attr(,"scores")
##  huge large small 
##     3     2     1 
## Levels: small large huge
```


### relevel()
The levels of a factor are re-ordered so that the level specified by `ref` is 
first and the others are moved down. This is useful for `contr.treatment` 
contrasts, which take the first level as the reference.

Example

```r
cols <- gl(n = 3, k = 2, labels = c("blue", "yellow", "red"))
relevel(x = cols, ref = "red")
```

```
## [1] blue   blue   yellow yellow red    red   
## Levels: red blue yellow
```


### cut()
A common way to generate factors, especially for tables, is the `cut()`
function. You give it a data vector `x` and a set of bins defined by vector 
`b`. The function then determines which bin each of the elements of `x` falls
into. 

Example

```r
set.seed(1234)
z <- runif(n = 10, min = 0.0, max = 1)
z
```

```
##  [1] 0.113703411 0.622299405 0.609274733 0.623379442 0.860915384
##  [6] 0.640310605 0.009495756 0.232550506 0.666083758 0.514251141
```

```r
binmarks <- seq(from = 0.0, to = 1.0, by = 0.1)
binmarks
```

```
##  [1] 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
```

```r
cut(x = z, breaks = binmarks, labels = FALSE)
```

```
##  [1] 2 7 7 7 9 7 1 3 7 6
```
This says that `z[1]`, `0.113703411`, fell into bin 2, which was `(0.1, 0.2]`;
`z[2]`, `0.622299406`, fell into bin 7, which was `0.6, 0.7]` and so on.


### findInterval()
Given a vector `vec` of non-decreasing breakpoints, find the interval 
containing each element of `x`.

Example

```r
x <- 2:18
v <- c(5, 10, 15)
findInterval(x = x, vec = v)
```

```
##  [1] 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3
```
The range of values in `x` goes from 2 to 18. The first four elements of `x` 
are smaller than the boundary of the first breakpoint in `vec`, hence they 
belong to interval `0`. The next four elements in `x, (5:9)` are part of the
first interval, the next five elements are part of the second interval from 10
to 15 (denoted as '2') and the remaining elements in `x` are outside of the 
intervals in `vec`.


### interaction()
`interaction` computes a factor, which represents the interaction of the given
factors.

`interaction(..., drop= FALSE, sep= ".", lex.order= FALSE)`
* `...` the factors for which interaction is to be computed or a single list
giving those factors.
* `drop` if `drop` is `TRUE`, unused factor levels are dropped fro mthe result.
* `sep` string to construct the new level labels by joining the constituent 
ones.


Example

```r
trial <- factor(c("LP01", "LP370", "LP371"))
field_block <- gl(n = 3, k = 3, labels = c("1", "2", "3"))
interaction(trial, field_block, sep = "_")
```

```
## [1] LP01_1  LP370_1 LP371_1 LP01_2  LP370_2 LP371_2 LP01_3  LP370_3 LP371_3
## 9 Levels: LP01_1 LP370_1 LP371_1 LP01_2 LP370_2 LP371_2 ... LP371_3
```
In this case we had three field trials with three field blocks each. The field
blocks were labeled with `1, 2, 3`, respectively, and are thereby not unique.
Through `interaction` we could create a unique field block variable by 
combining the levels from both objects.



# Input/Output
## Output
### print()
`print` is necessary if you need to print from within the body of a function or
from within a loop in the case of `ggplot2`.


### cat()
`cat` outputs the objects, concatenating the representations. It performs much
less conversion than `print`.

Example

```r
let <- LETTERS
sel_let <- sample(x = let, size = 10, replace = FALSE)
cat("Out of", length(let), "letters", length(intersect(let, sel_let)), 
    "letters were selected.")
```

```
## Out of 26 letters 10 letters were selected.
```


### message()
Generate diagnostic messages which are neither warnings nor errors.

Example #1

```r
for(i in 1:10) {
  Sys.sleep(0.2)
  message(i, "\r", appendLF = FALSE)
  flush.console()
}
```

```
## 1 2 3 4 5 6 7 8 9 10
```


### warning()
Generates a warning message that corresponds to its argument(s) and 
(optionally) the expression of function from which it was called.

Example

```r
testit <- function() warning("problem in testit", call. = FALSE)
testit()
```

```
## Warning: problem in testit
```
In this case, the function was told to output a warning if the `testit()` 
function is not provided without any actual arguments.


### dput()
Writes an ASCII text representation of an `R` object to a file or connection, 
or uses one to recreate the object.

Example

```r
# Original vector with fruits.
fruits <- c("apple", "banana", "pineapple", "orange", "kiwi", "lemon", "peach",
            "pear")
# Subset of fruits.
sub_fruits <- fruits[c(4, 6, 8)]

# Untracked changes to the original 'fruits' object.
fruits <- sort(fruits)
```
The same subset as 'sub_fruits' cannot be obtained by using the previous
indexing `4, 6, 8` anymore since the order of elements was changed.

Solution:

```r
sub_fruits <- dput(fruits[fruits %in% sub_fruits])
```

```
## c("lemon", "orange", "pear")
```


### format()
Format an `R` object for pretty printing.

* `digits` how many significant digits are to be used; overridden by `nsmall`
* `nsmall` the minimum number of digits to the right of the decimal point
* `scientific` encode objects of class `numeric` in scientific format

Examples

```r
# Use of `digits`
format(2^31-1, digits = 3)
```

```
## [1] "2.15e+09"
```

```r
# Use of nsmall
format(c(3.02401404, 1.05), nsmall = 5)
```

```
## [1] "3.024014" "1.050000"
```

```r
# Use of `scientific`
format(2^31-1, scientific = TRUE, digits = 4)
```

```
## [1] "2.147e+09"
```



### sink()
The `sink("filename")` function redirects output to the file `filename`. By 
default, if the file already exists, its contents are overwritten. Include
the option `append= TRUE` to append text to the file rather than overwriting 
it. 


### capture.output()
Evaluates its arguments with the output being returned as a character string
or send to a file. This function related to `sink` in the same way as `with`
relates to `attach`.













