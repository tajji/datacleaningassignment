# Getting and Cleaning Data - Course Project
Version 1.0

***

## Overview
The assignment asks to create a tidy data set from the provided "Human Activity Recognition Using Smartphones Dataset" data by carrying out certain steps. The analysis code in the file run_analysis.R performs the steps which are described as follows:

## Step 1 : Merges the training and the test sets to create one data set.

The data from the test set is first read in and the columns for activity id, subject id and measurements are combined using cbind. We end up with 563 columns of data in which the first one is activity id, the second one is subject id and the remaining are measurement variables.
Similarly, data from the train set is read in and combined.
Subsequently, the two data sets are combined using rbind to get one data set called "alldata".

## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 

The list of features is read in. Then the indices of all features which have the text "mean" or "std" (case insensitive) are kept while the rest are discarded. This list of indices is used to get the right columns from the dataset.

## Step 3 : Uses descriptive activity names to name the activities in the data set

The list of activity labels is read in. It is then merged with the activity ids in the dataset (first column). Since the data does not remain in order after merging, some data massaging is done to get the data back in order it was in using the row number of each observation.

## Step 4 : Appropriately labels the data set with descriptive variable names

The indices of the shortened featurelist are used to get the feature names. 
The feature names are cleaned and made more readable by removing parenthesis symbols, converting commas to hyphens, and then converting all hyphens to dots. This makes the feature names readable and descriptive.
The list of feature names is then used as column names for the dataset.

## Step 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

The data is first "melted" using the melt function from the reshape2 package. (This package is loaded in the beginning of the analysis using the library function). The melted data contains observations for every combination of Activity Name, Subject and measured variables.
In the next step, average of the measured variables for each activity and subject is obtained by using the dcast function of the reshape2 package.

The resulting dataset is alled "alldataCast", and is written using the write.table function to a file called tidy-data.txt






