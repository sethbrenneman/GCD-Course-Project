library(dplyr)

##read in the data from the relevant files, and combine them into one set
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
test <- cbind( x_test, subject_test, y_test)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
train <- cbind( x_train, subject_train, y_train)

all_data <- rbind(test, train)

## read in the features file, get the indeces of the measurements we want to keep
## and subset the table.
features <- read.table("./UCI HAR Dataset/features.txt")
indeces <- grep("*((mean\\(\\))|(std\\(\\)))", features[[2]])
cnames <- as.character(features[indeces,2])

all_data <- all_data[,c(indeces, 562, 563)]

##Rename the columns of the table
for(i in 1:length(cnames))
  names(all_data)[i] <- cnames[i]
names(all_data)[67] <- "subjectID"
names(all_data)[68] <- "activityID"

##create final, tidy data set with averaged measurements grouped by
## subject/activity
grouped_data <- group_by(all_data, subjectID, activityID)
grouped_data <- summarize_each(grouped_data, "mean")

##write data set to a file
write.table(grouped_data, file = "./final_data_set.txt", row.names = FALSE)