GettingAndCleaningData
======================

###How to use this code

After saving run_analysis.R to your working directory, you can source and run this script to tidy up a set of Samsung Galaxy S smartphone accelerometer data.  This script will download and unzip the source data into your working directory, if you have not already done so. When run, this script will both return a copy of the tidy data, and save a copy of that data to a local file named "tidy UCI HAR Dataset.txt".
```
source("run_analysis.R")
tidyData <- run_analysis()
```
For more details on the data stored in the columns of this data set, see the file: codebook.md

###What this code does

The code in the run_analysis script does the following:  

1. downloads and unzips the source accelerometer data to your working direction, if it is not already there  
2. reads the following files into R: features.txt, activity_labels.txt, test\X_test.txt, test\subject_test.txt, test\y_test.txt, train\X_train.txt, train\subject_train.txt, train\y_train.txt  
3. adds a columns of subjects ids and a column of activity ids to the test and train datasets, before combining the rows in those two datasets into a single dataset  
4. labels the columns of this single data set  
5. removes the non-mean and non-std columns from this dataset, but leaves the subject and activity ids intact  
6. replaces the activity code numbers with descriptive text  
7. averages each of the mean and std values accross individual subjects for each type of activity  
8. sorts the dataset by subject and then activity  
9. saves the dataset to a text file named "tidy UCI HAR Dataset.txt", and then reads it back in  
10. returns the tidy dataset  
