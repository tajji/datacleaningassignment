library(reshape2)

#Step 1
# Merges the training and the test sets to create one data set.

##read in test data
testdataSubject <- read.table("./test/subject_test.txt")
testdataX <- read.table("./test/X_test.txt")
testdataY <- read.table("./test/y_test.txt")
##combine to get test data
testdata <- cbind(testdataY, testdataSubject, testdataX)

##read in train data
traindataSubject <- read.table("./train/subject_train.txt")
traindataX <- read.table("./train/X_train.txt")
traindataY <- read.table("./train/y_train.txt")
##combine to get test data
traindata <- cbind(traindataY, traindataSubject, traindataX)

##Combine test and train data
alldata <- rbind(traindata, testdata)

# Step 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 

## Read in the features list
features <- read.table("features.txt")

## Get indices of variable names which have "mean" or "std" in the name
meanStdIndex <- grep(pattern="*mean|*std",unlist(features[2]),ignore.case=TRUE)
allIndex <- c(1, 2, meanStdIndex + 2)

## Get data for the required indices
alldata <- alldata[,allIndex]
names(alldata)<-c("ActivityID", "SubjectID")

# Step 3
# Uses descriptive activity names to name the activities in the data set

## Get activity labels from file
activity_labels <- read.table("activity_labels.txt")
names(activity_labels)<-c("ActivityID", "Activity")

## Merge into alldata to replace feature numbers with feature labels
alldata$rownum <- as.numeric(row.names(alldata))
activityData <- merge(alldata[,c("ActivityID","rownum")], activity_labels, by.x = "ActivityID", by.y = "ActivityID")
activityData <- activityData[order(activityData$rownum),]
alldata1 <- cbind(activityData[3], alldata[,-which(names(alldata) %in% c("ActivityID"))])
row.names(alldata1) <- as.character(alldata1[,"rownum"])
alldata1 <- alldata[,-which(names(alldata) %in% c("rownum"))]

# Step 4
# Appropriately labels the data set with descriptive variable names

## Get descriptive names from features
featureNames <- as.character(features[meanStdIndex,2])
featureNames <- gsub("\\(\\)", "", featureNames)
featureNames <- gsub("\\(", "-", featureNames)
featureNames <- gsub(pattern="\\)", "", featureNames)
featureNames <- gsub(pattern=",", "-", featureNames)
featureNames <- gsub(pattern="-", "\\.", featureNames)

## Apply feature names to data
names(alldata1) <- c("Activity", "SubjectID", featureNames)

# Step 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Melting the dataset
alldataMelt <- melt(alldata1, id=c("Activity","SubjectID"), measure.vars=names(alldata1)[-(1:2)])

## using dcast to get the average of all variables
alldataCast <- dcast(alldataMelt, Activity + SubjectID ~ variable, mean)
alldataCast

# Wrapping up

## Write the dataset to a file
write.table(alldataCast,file="./tidy-data.txt",row.name=FALSE)






