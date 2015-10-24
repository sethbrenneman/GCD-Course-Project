

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R Script in this repo constructs a tidy data set from the original data using the following steps:

1. Reads in the tables of data from the relevant test/train files
2. Merges the data into one table using cbind and rbind
3. Subsets the data so that only the subject IDs, activity IDs, and mean/std measurements remain.
4. Relabels the columns
5. Calculates the the average of each measurement, grouped by the subject and activity
6. Writes the final table to file