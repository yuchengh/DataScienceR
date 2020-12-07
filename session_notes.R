#install.package("tidyverse")
library(tidyverse)

#########This is the notes for Intro R########################
View(cars)
plot(cars)

data() #open built-in datasets
hist(cars$speed)

help("hist") # open up help file for hist function

# R object
avg <- (5 + 7 + 6)/3
avg

ls() # look at all current objects
rm(avg) # remove the object

#plot could apply to dataframe and function
# it depends on what you put in
# for models, for example, predictions, it could be really handy. do not need to use the same syntex everytime

vec <- c(1, 4, 10)
class(vec)

fit <- lm(dist ~ speed, data = cars)
class(fit)

# investigating objects
class(cars)
typeof(cars)
str(cars) # look at the structure of the object

# common data structure
# vetor (1 dimensional of elements with an ordering)
# vectors can be numeric or character
# R starts counting elements at 1 (instead of 0)
# building blocks of more complex data frame

x <- c(17, 22, 1, 3, -3)
y <- c("cat", "dog", "bird", "frog")

# functions to output a numeric vector
# seq (from, to, by)
v <- seq(from =1, to=5, by=1)
v
str(v)

1:20

# runif
help(runif) # uniform distribution
runif(10, min = 0, max = 1)

#matrix (2 dimension data structure)
# row index and column index, elements

#populate vectors
x <- c(17, 3, 13, 11)
y <- rep(-3, times = 4)
z <- 1:4

is.numeric(x)
length(x)

help(matrix)

#combine in a matrix
#four rows and three columns
matrix(c(x, y, z), ncol = 3)

# matrix elements can also be character strings
# fill in by rows or by columns
matrix(c(x, y, z), nrow = 6, byrow = TRUE)

# most of the time our data will have both characters and numerics, so matrix is not enough to handle this
# dataframe will come in handy

# dataframe is also 2D data structure
x <- c("a", "b", "c", "d", "e", "f")
y <- c(1, 3, 4, -1, 5, 6)
z <- 10:15
data.frame(x, y, z) # as long as each colunmn has the same length
# name the column (easy to grab a column)
data.frame(char = x, data1 = y, data2 = z)

df <- data.frame(char = x, data1 = y, data2 = z)
# transpose the dataframe
t(df)

z <- 1:4
z <- c(z, NA, NA) #with misiing data
z
is.na(z)

# List (1D group of objects with ordering)
# each element can be whatever you want them to be, and you just want to order them in 1 dimensional
# super flexible when you do not have a rectangular dataframe
list(1:3, rnorm(2), c("!", "?"))
# name the elements
list(seq = 1:3, normVals = rnorm(2), punctuation = c("!", "?"))

# how do we access/change parts of our objects
cars$dist
mean(cars$dist)

#class activity
vec <-c(4, 7, 10, 13)
vec2 <- vec+8
vec2
vec <-vec^2
vec
sum(vec)

adj <- c("good", "bad", "beautiful", "ugly")
nouns <- c("cat", "dog", "frog", "bird")
paste(adj, nouns) #past two elements together if you have same length
matrix(c(adj, nouns), ncol = 2)
dataDF<-data.frame(vec, adj, nouns)
dataDF

m1 <- matrix(c(vec, vec2), ncol=2)
m1square <- m1^2
m2 <- matrix(c(vec2, vec), ncol=4)
m2

m1 %*% m2
df3 <- as.data.frame(m1)
class(df3)
df3








