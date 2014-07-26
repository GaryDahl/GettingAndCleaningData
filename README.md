GettingAndCleaningData
======================

After saving run_analysis.R to your working directory, you can source and run this script to tidy up a set of Samsung Galaxy S smartphone accelerometer data.  This script will download and unzip the source data into your working directory, if you have not already done so. When run, this script will both return a copy of the tidy data, and save a copy of that data to a local file named "tidy UCI HAR Dataset.txt".
```
source("run_analysis.R")
tidyData <- run_analysis()
```
For more details on the data stored in the columns of this data set, see the file: codebook.md
