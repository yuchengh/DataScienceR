################programming in R##############################

# clear everything to start
rm(list = ls())
gc()

x <- c("a", "b", "c", "d", "e", "f")
y <- c(1, 3, 4, -1, 5, 6)
z <- 10:15
data.frame(char = x, data1 = y, data2 = z)

iris
str(iris)
attributes(iris)
iris[1:4, 2:4]
iris[1, ]
iris[ , c("Sepal.Length", "Species")]
iris$Sepal.Length

library(tidyverse)

#####################subsetting/manipulating data############################
#tbl_bf() -convert data frame to one with better printing

install.packages("fivethirtyeight")
library(fivethirtyeight)
head(fandango, n = 4) #look at just first 4 observations

fandango <- tbl_df(fandango)
fandango <- tibble::as_tibble(fandango)

filter(fandango, year == 2014)
filter(fandango, (year == 2014) & (rottentomatoes <= 60))
arrange(fandango, year, desc(film))

#piping or chaining
fandango %>%
  filter(year == 2014) %>%
  arrange(desc(film))

#quantile
fandango$imdb %>% 
  quantile() %>%
  range()

#selecting columns
fandango %>% select(film, fandango_stars)
#all columns between
fandango %>% select(film, year:rottentomatoes_user)
#all columns containing
fandango %>% select(film, contains("fandango"))
#all columns starting with
fandango %>% select(film, starts_with("imdb"))
#all columns ending with
fandango %>% select(film, ends_with("user"))

#mutate - add newly created variable
fandango %>%
  mutate(avgRotten = (rottentomatoes + rottentomatoes_user)/2) %>%
  select(avgRotten)

#summarise() -apply basic function to data
fandango %>%
  group_by(year) %>%
  summarise(avgStars = mean(fandango_stars))

#ungroup for the rest of the chain ungroup()
#ungroup just for the summarize function 

#combine two data sets left_join(), right_join(), inner_join, full_join
a <- tibble(color = c("green", "yellow", "red"), num = 1:3)
b <- tibble(color = c("green", "yellow", "pink"), size = c("S", "M", "L"))
a
b
inner_join(a, b)
full_join(a, b)
#include all observations found in "a", match with b
# left table is dominating, b is just adding information
left_join(a, b)
# right_join vice versa
right_join(a, b)
left_join(b, a)
# filter "a" to only show observations that match "b"
# use b as a filter, the presence in b will allow you stay in the combined data
semi_join(a, b)
# filter "a" to only show observations that do not match "b"
anti_join(a, b)

#sometimes matching variables do not have identical names
b <- b %>% rename(col = color)
a
b
inner_join(a, b, by = c("color" = "col"))

###################Manipulating data###########################

# gather() takes multiple columns, and gathers them into key-value pairs
# make wide datasets longer

tempsData <- read_delim("Programming-in-R-master/datasets/cityTemps.txt", delim = " ")
tempsData

gather(tempsData, key = day, value = temp, 2:8) 
#key - variable name
#value - new variable to contain information
#2:8 columns I want to transpose

newTempsData <- gather(tempsData, key = day, value = temp, 2:8)

#spread() switch to wide from long, opposite from gather
spread(newTempsData, key = day, value = temp)

#dplyr to manipulate data, tidyr to expend or condense data

#class activity
#install.packages("Lahman")
library(Lahman)

PitchingData <- as_tibble(Pitching) 

PitchingData %>%
  select(playerID, yearID, teamID, W, L, ERA) %>%
  filter(yearID == 2010) %>%
  mutate(WLP = W / (W + L)) %>%
  arrange(desc(teamID)) %>%
  group_by(teamID) %>%
  summarise(sum(W)) %>%
  rename(TotalWins = `sum(W)`)

# compare this with the answer
PitchingData %>%
  select(playerID, yearID, teamID, W, L, ERA) %>%
  filter(yearID == 2010) %>%
  mutate(WLP = W / (W + L)) %>%
  arrange(desc(teamID)) %>%
  group_by(teamID) %>%
  summarise(TotalWins=sum(W))

##############Streamline repeated sections of code######################
#For Loops

# an example
for (i in 1:10){
  print(i)
}

for (value in c("cat", "hat", "worm")){
  print(value)
}

set.seed(10)
data<-round(runif(5),2)
data

words <- c("first", "second", "third", "fourth", "fifth")
paste0("The ", words[1], " data point is ", data[1], ".")

for (i in 1:5){
  print(paste0("The ", words[i], 
               " data point is ", data[i], "."))
}

#find summary() for each column
library(Lahman)
Batting2010 <- Batting %>% 
  filter(yearID == 2010) %>% 
  select(playerID, teamID, G, AB, R, H, X2B, X3B, HR)

Batting2010
summary(Batting2010[ , 3])

#summary will give you 6 stats, we have 7 columns of numeric value
stats <- matrix(nrow = 6, ncol = 7)
#dim() asks for dimension
#dim()[2] asks for second dimension, i.e. column
for (i in 1:(dim(Batting2010)[2]-2)){
  stats[ , i] <- summary(Batting2010[ , i + 2])
}
stats

#add column names
colnames(stats) <- names(Batting2010)[3:9]
stats

#class activity
set.seed(100)
df <- data.frame(gamma = rgamma(n = 20, shape = 4, scale = 2), 
                 uniform = runif(n = 20), 
                 normal = rnorm(n = 20))
df
sd(df[, 2])
dim(df)[2]

#Create a for loop that will cycle through the columns and save the standard deviation of each column in a vector called 'sds'.
sds <- c()
# alternatively
sds <- vector(mode = "numeric", length = 3)
# for (i in 1:length(sds))
for (i in 1:3){  
  sds[i] <- print(sd(df[ , i]))
}
sds

set.seed(100)
Obs <- matrix(sample(5:50, 12, replace = TRUE), nrow = 4, ncol = 3)
Exp <- matrix( , nrow = dim(Obs)[1], ncol = dim(Obs)[2])

Obs
sum(Obs)

for (i in 1:dim(Exp)[1]){
  for (j in 1:dim(Exp)[2]){
    Exp[i, j] <- (sum(Obs[i, ]))*(sum(Obs[, j]))/sum(Obs)
  }
}
Exp

#try to avoid hardcoding (in case you need to update the data)
# use dim() to figure out the size

##################Vectorized Function######################
#colMeans
colMeans(select(Batting, G:GIDP), na.rm = TRUE) #remove missing before we compute column means

#comparing computational time
install.packages("microbenchmark")
library(microbenchmark)

Bat <- select(Batting, G:GIDP)
microbenchmark(
  colMeans(Bat, na.rm = TRUE)
)

#colMedian
install.packages("matrixStats")
library(matrixStats)
library(matrixStats, warn.conflicts = FALSE)

Batting %>%
  group_by(playerID) %>%
  summarise(totG = sum(G), totAB = sum(AB), .groups='drop') %>%
  select(-playerID) %>% 
  as.matrix() %>%
  colMedians(na.rm = TRUE)

#If then, if then else
airquality <- as_tibble(airquality)
airquality

# initialize vector to save results
status <- vector()

for (i in 1:(dim(airquality)[1])){
  if(airquality$Wind[i] >= 15) {
    status[i] <- "HighWind"
  } else if (airquality$Wind[i] >= 10){
    status[i] <- "Windy"
  } else if (airquality$Wind[i] >= 6){
    status[i] <- "LightWind"
  } else if (airquality$Wind[i] >= 0){
    status[i] <- "Calm"
  } else {
    status[i] <- "Error"
  }
}

status

#ifelse(vector_condition, if_true_do_this, if_false_do_this)
#saves computational time
ifelse(airquality$Wind >= 15, "HighWind", 
       ifelse(airquality$Wind >= 10, "Windy",
              ifelse(airquality$Wind >= 6, "LightWind", "Calm")))

#apply family
#apply()
#use apply() to find summary for columns of airquality data (work on dataframe)
apply(X = select(airquality, Ozone:Temp), MARGIN = 2, FUN = summary, na.rm = TRUE)
# Think of margin as dimension, margin =2 i.e. column

#use lapply() to apply function to lists
fit <- lm(Ozone ~ Wind, data = airquality)
fit <- list(fit$residuals, fit$effects, fit$fitted.values)

fit[[2]]

#apply mean() function to each list element
lapply(X = fit, FUN = mean)

#sapply returns a vector if possible (condense the output)
sapply(X = fit, FUN = mean)

#class activity
CO2Data <- CO2 

CO2Data1 <- CO2Data %>%
  mutate(group = ifelse(((Type=="Quebec") & (Treatment == "nonchilled")), 1,
                        ifelse(((Type == "Quebec") & (Treatment == "chilled")), 2,
                               ifelse(((Type == "Mississippi") & (Treatment == "nonchilled")), 3, 
                                      ifelse(((Type == "Mississippi") & (Treatment == "chilled")), 4, 0)))))

CO2Data1

#2. Report the means of each numeric column.
colMeans(select(CO2Data1, conc:group), na.rm = TRUE)

#3. Report the standard deviations of each column (use the matrixStats package).
library(matrixStats)
colSds(as.matrix(select(CO2Data1, conc:group)))
# alternatively: 
apply(select(CO2Data1, conc:group), MARGIN = 2, FUN = sd)


#######################Writing Functions##############################
#nameOfFunction <- function(input1, input2, ...) {
  #code
  #return something with return()
  #or returns last value
#}

standardize <- function(vector) {
  return((vector - mean(vector)) / sd(vector))
}

data <- runif(5)
data
result <- standardize(data)
result

# put in options
standardize <- function(vector, center, scale) {
  if (center == TRUE) {
    vector <- vector - mean(vector)
  }
  if (scale == TRUE) {
    vector <- vector / sd(vector)
  } 
  return(vector)
}


# add in defaults
standardize <- function(vector, center = TRUE, scale = TRUE) {
  #center and scale if appropriate
  if (center == TRUE) {
    vector <- vector - mean(vector)
  }
  if (scale == TRUE) {
    vector <- vector / sd(vector)
  } 
  return(vector)
}

result <- standardize(data)
result



















