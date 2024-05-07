library(dplyr)

#0- Download the dataset and unzip it in the working directory:
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCI HAR dataset.zip")
unzip("UCI HAR dataset.zip")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#-STEP 1: Merges the training and the test sets to create one data set.
Xbind <- rbind(X_train, X_test)
Ybind <- rbind(Y_train, Y_test)
Subject <- rbind(subject_train, subject_test)
Data <- cbind(Subject, Ybind, Xbind)

#STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
Data.mean.std <- Data %>% select(subject, code, contains("mean") | contains("std"))

#STEP 3: Uses descriptive activity names to name the activities in the data set
Data.mean.std$code <- activity_labels[Data.mean.std$code, 2]

#STEP 4: Appropriately labels the data set with descriptive variable names. 
names(Data.mean.std) <- gsub("-mean", "_mean", names(Data.mean.std))
names(Data.mean.std) <- gsub("-std", "_std", names(Data.mean.std))
names(Data.mean.std) <- gsub( "Acc", "_accelerometer", names(Data.mean.std))
names(Data.mean.std) <- gsub("Gyro", "_gyroscope", names(Data.mean.std))
names(Data.mean.std) <- gsub("BodyBody", "Body", names(Data.mean.std))
glimpse(Data.mean.std)

#STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- Data.mean.std %>%
  group_by(subject, code) %>%
  summarise(across(starts_with("t"), mean), .groups = "drop")
write.table(tidy_data, "Tidy_Data.txt", row.name=FALSE)
str(tidy_data)
