library(jsonlite)

# loading data
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)
demo_table2 <- fromJSON(txt='demo.json')

#accessing data
demo_table[3,"Year"] # naming the column
demo_table[3,3] #accessing directly to the position in the table
demo_table$"Vehicle_Class"  #using special character to name an entire column- output is a vector
demo_table$"Vehicle_Class"[2] # within the output vector, accessing the second item

# filtering the table using some condition
filter_table <- demo_table2[demo_table2$price > 10000,]

#another way to filter data is using the function subset
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) #filter by price and drive train

# Sample function to randomly select data (sample) from a larger vector
sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4) #choose randomly 4 items from vector 

# sampling a two dimensional dataset
num_rows <- 1:nrow(demo_table) # create a numerical vector w/the same length as the number of rows in the data frame
sample_rows <- sample(num_rows, 3) # sample a list of indices from our first vector.
demo_table[sample_rows,] # retrieve data frame rows from sample list.
# the three steps in a single statement
demo_table[sample(1:nrow(demo_table), 3),]

# ------ Transform data ------
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE) #add columns to original data frame

summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep') #create summary table

summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep') #create summary table with multiple columns


# ---- Reshape Data ------ 
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)

long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)

long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)

wide_table <- long_table %>% spread(key="Metric",value="Score")

# ------ ggplot2 - for data visualization -------

head(mpg)  # loading mpg data 
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar plot

#create summary table
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') 
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) 
plt + geom_col() #plot a bar plot

#plot bar plot with labels
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") 
#plot a boxplot with labels
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + 
  theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees

ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot
shapiro.test(mtcars$wt)
