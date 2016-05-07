#setwd("/Users/sandraezidiegwu/Documents/Data Science/")
#clear workspace
rm(list=ls())

#Create directory for data + unzip file and direct workspace to path
if(!file.exists("./3_GETDATA")){
	dir.create("./3_GETDATA")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./3_GETDATA/Dataset.zip", method = "curl")
unzip(zipfile = "./3_GETDATA/Dataset.zip", exdir = "./3_GETDATA")
path_UCI <- file.path("./3_GETDATA", "UCI HAR Dataset")
listUCI <- list.files(path_UCI, recursive = TRUE)
listUCI

#Read .txt files from respective folders
TestActivity <- read.table(file.path(path_UCI, "test", "y_test.txt"), header = FALSE)
TrainActivity <- read.table(file.path(path_UCI, "train", "y_train.txt"), header = FALSE)

TestSubject <- read.table(file.path(path_UCI, "test", "subject_test.txt"), header = FALSE)
TrainSubject <- read.table(file.path(path_UCI, "train", "subject_train.txt"), header = FALSE)

TestFeature <- read.table(file.path(path_UCI, "test", "X_test.txt"), header = FALSE)
TrainFeature <- read.table(file.path(path_UCI, "train", "X_train.txt"), header = FALSE)

#Merge Training and Test sets of Subject, Activity and Feature data 
Subjectdata <- rbind(TestSubject, TrainSubject)
Activitydata <- rbind(TestActivity, TrainActivity)
Featuredata <- rbind(TestFeature, TrainFeature)

#Assign Column names to table + include feature names
names(Subjectdata) <- c("subject")
names(Activitydata) <- c("activity")
feature_name <- read.table(file.path(path_UCI, "features.txt"), header = FALSE)
names(Featuredata) <- feature_name[,2]

#combine feature subject and activity data
UCI_Data <- cbind(Featuredata, Subjectdata, Activitydata)

#Extract only the measurements on the mean and standard deviation
#for each measurement
subFeaturedata <- feature_name[,2][grep("mean\\(\\)|std\\(\\)", feature_name[,2])]
UCI_Data <- subset(UCI_Data, select = c(as.character(subFeaturedata), "subject", "activity"))

#label activities with appropriate description
ActivityLabel <- read.table(file.path(path_UCI, "activity_labels.txt"), header = FALSE)
UCI_Data$activity <- ActivityLabel[UCI_Data$activity,2]

#display descriptive variable names in data set
names(UCI_Data) <- gsub("^t", "time", names(UCI_Data))
names(UCI_Data) <- gsub("^f", "frequency", names(UCI_Data))
names(UCI_Data) <- gsub("Acc", "Accelerometer", names(UCI_Data))
names(UCI_Data) <- gsub("Gyro", "Gyroscope", names(UCI_Data))
names(UCI_Data) <- gsub("Mag", "Magnitude", names(UCI_Data))
names(UCI_Data) <- gsub("BodyBody", "Body", names(UCI_Data))
names(UCI_Data) <- gsub("X$", "X-axis", names(UCI_Data))
names(UCI_Data) <- gsub("Y$", "Y-axis", names(UCI_Data))
names(UCI_Data) <- gsub("Z$", "Z-axis", names(UCI_Data))

#Create a second independent tidy data set with the average of
#each variable for each acitivity and each subject
library(plyr)
UCI_Data2 <- aggregate(. ~subject + activity, UCI_Data, mean)
UCI_Data2 <- UCI_Data2[order(UCI_Data2$subject, UCI_Data2$activity),]
write.table(UCI_Data2, file = "tidydata.txt", row.name = FALSE)