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

# basic data manipulation
# for vectors, brackets [] return the element
letters
letters[1]
letters[26]

letters[1:4]
letters[c(5, 10, 15, 20, 25)]
x <- c(1, 2, 5); letters[-x] # return everything but x, x is 1, 2, 5; semicolon put two command lines together

#matrix
# use square brackets with comma [ , ]
mat <- matrix(c(1:4, 20:17), ncol = 2)
mat

mat[c(2, 4), ] #index row, second and fourth row

mat[, 1]
mat[2, ]
mat[2, 1]

#name the matrix
mat<-matrix(c(1:4,20:17),ncol=2,
            dimnames=list(NULL,
                          c("First","Second")))
mat

str(iris)
iris[1:4, 2:4]
View(iris)

iris[1, ]
iris[ , c("Sepal.Length", "Species")]
iris$Sepal.Length

# Lists(1D)
x <- list("HI", c(10:20), 1)
x[2:3] # return second and third elements

# use double square brackets [[]] for single list element
x[[1]]
x[[2]][4:5]

# name list elements
x <- list(First = "HI", Second = c(10:20), Third = 1)
# if named list elements, can use $ sign
x$Second

# data frame = list of equal length vectors
str(x)
str(iris)

# connection between data frame and lists
iris[[2]] # return elements of the second column (because that is just the second list)
iris[2]

# class activities
dataDF
# first row
dataDF[1, ]
# first column
dataDF[, 1]
# first row first column
dataDF[1, 1]


# third row
dataDF[3, ]

dataDF$adj
dataDF[, 2]
dataDF[[2]]
dataDF[2] #returns a list
str(dataDF[2])

# first and 4th rows of just the nouns 
dataDF[c(1,4), 3]
dataDF$nouns[c(1, 4)]

# data structure
str(dataDF)

#delimited data: csv
#SAS data
#JSON (often from a database or API)

# read in data
dir()
getwd()

neuralgiaData <- read.csv("datasets/neuralgia.csv")

countiesData <- read.csv("datasets/counties.csv")

library(readr)
countiesData <- readr::read_csv("datasets/counties.csv")

library(readxl)
edData <- read_excel("datasets/censusEd.xlsx")
edData

# specify the sheet (name or integers)
# range option pulls specific excel columns
edData <- read_excel("datasets/censusEd.xlsx", sheet = "EDU01A", 
                     range = cell_cols("A:D"))
edData


#SAS data
library(haven)
smokeData <- read_sas("datasets/smoke2003.sas7bdat")
smokeData

str(smokeData)

#get the label for the variable
attr(smokeData$SDDSRVYR, "label")

#SPSS data
bodyFatData <- read_spss("datasets/bodyFat.sav")
bodyFatData

#stata
effortData <- read_dta("datasets/effort.dta")
effortData


# Writing out data
# usually write to .csv (or other delimiter)
# write_csv() from readr package
# append option (will not overwrite but structures must match)
write_csv(x = smokeData, path = "datasets/smokeData.csv")

#JSON - JavaScript Object Notation
#Uses key-value pairs
# in excel or other software, usually a row is a record and colunmn is variable
# in JSON, each row denotes a "variable"

#APIs - Application Programming Interfaces
#webaddress and provide api
install.packages("RSQLite")
library(RSQLite)
install.packages("RCurl")
library(RCurl)

baseURL <- "https://www.potterapi.com/v1/"
value <- "spells?"
key <- "key=$2a$10$UMvDCH.93fa2KOjKbJYkOOPMNzdzQpJ0gMnVEtcHzW5Ic04HUmcsa"
URL <- paste0(baseURL, value, key)
spellData <- RCurl::getURL(URL)

##spellDataDF <- jsonlite::fromJSON(spellData)
##as_tibble(spellDataDF)

#SQL language
#manipulate data and pull information from different tables

#class activity
help("read_delim")
BreastCancerData <- readr::read_delim("datasets/BreastCancer.dat", delim = "\t") #\t tab delimitor
#alternatively, could just use .tsv data
BreastCancerData <- readr::read_tsv("datasets/BreastCancer.dat")
View(BreastCancerData)

mosquitoData <- readr::read_delim("datasets/mosquito.txt", delim = "&")
mosquitoData2 <- readr::read_tsv("datasets/mosquito2.txt", col_names = c("Day", "Cage", "trt", "Response"))

#make sure the structure and column names are the same
mosquitobind <- rbind(mosquitoData, mosquitoData2)

write_csv(x = mosquitobind, path = "datasets/mosquitobind.csv")

effortData <- read_dta("datasets/effort.dta")
effortData

#data manipulation
# grab only certain types of observations (subsetting the dataset) filter rows
# logical statements
"hi" == " hi" # there is a space in second "hi"
4 >= 1
4 != 1
sqrt(3)^2 == 3 #rounding issue sqrt3 will have decimal points

dplyr::near(sqrt(3)^2, 3)

# is. statements
is.numeric("Word")
is.numeric(10)

is.character("10")
is.na(c(1:2, NA, 3))
is.matrix(c("hello", "world"))

iris <- as_tibble(iris)
iris
head(iris)

# subset rows or columns
iris$Species == "setosa" #vector indicating setosa values
iris[iris$Species == "setosa", ] #picking all columns and true rows

subset(iris, Species == "setosa")

# filter from dplyr
filter(iris, Species == "setosa")


#implicit data change
#coerce numeric to string
c("hi", 10)
#coerce TRUE/FALSE to numeric
c(TRUE, FALSE) + 0

#explicit coercion with as. functions
as.numeric(c(TRUE, FALSE, TRUE))
mean(c(TRUE, FALSE, TRUE))
as.character(c(1, 2, 3.5, TRUE)) #note that true coerced to 1

set.seed(3)
x <- runif(n = 10, min = 0, max = 1); x

(x < 0.25) | (x > 0.75)

(x < 0.25) || (x > 0.75) # this only checks the first element

filter(iris, (Petal.Length > 1.5) & (Petal.Width > 0.3) & (Species == "setosa"))

#dplyr
# as_tibble
install.packages("Lahman")
library(Lahman)
head(Batting, n = 4)

Batting <- as_tibble(Batting)

# filter() - subset rows
filter(Batting, teamID == "PIT" & yearID == 2000)

# arrange() - reorder rows
arrange(Batting, teamID)
arrange(Batting, teamID, G)
# descending instead
arrange(Batting, teamID, desc(G))

# select columns
select(Batting, X2B)

# Piping or Chaining
Batting %>%
  filter(teamID == "PIT") %>%  #step 1
  select(playerID, G, X2B) %>%
  arrange(desc(X2B))

# Generally pipe does the following
# x %>% f(y) turns into f(x, y)
# x %>% f(y) %>% g(z) turns into g(f(x, y), z)

#all columns between
Batting %>% select(X2B:HR)

#all columns containing
Batting %>% select(contains("X"))

#all columns starting with
Batting %>% select(starts_with("X"))

#multiple selections
Batting %>% select(starts_with("X"), ends_with("ID"), G)

#reorder
Batting %>% select(playerID, HR, everything())

#renaming
Batting %>% 
  select(starts_with("X"), ends_with("ID"), G) %>% 
  rename("Doubles" = X2B, "Triples" = X3B)  #rename after selecting them

temp <- cbind(iris, extra = rep("a", 150))
temp

#class activity 
getwd()
SO2Conc <- readr::read_csv("datasets/SO2+Concentrations+(tidy).csv")
View(SO2Conc)

SO2Conc <- as_tibble(SO2Conc)
SO2Conc

SO2Conc %>% 
  filter((Count>=21) & (Max >= 0)) %>%
  select(Day, Max, Count) %>%
  arrange(Day)

#mutate - add newly created columns to current data frame
# mutate()
# transmute - create new dataframe using only the new variables
# group_by()
# ifelse(vector)







































































