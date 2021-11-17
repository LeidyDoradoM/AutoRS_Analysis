library(jsonlite)
library(ggplot2) # for ggplot
library(dplyr) # for %>%
library(magrittr)

head(mtcars)

plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot