## Download the data package and unzip the target file
filename <-"project.zip"

if(!file.exists(filename)){
download.file("https://d396qusza40orc.cloudfront.net/
getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="./project.zip")}
unzip(zipfile="project.zip")


## Obtain the activity lables,and variable names

setwd("./UCI HAR Dataset")
library(dplyr)
library(varhandle)
activity_labels <-tbl_df(read.table("activity_labels.txt",
                                    sep=" "))
names(activity_labels) <-c("activityID","activityLabel")
feature_data<-read.table("features.txt", sep=" ")
features <-as.character(unfactor(feature_data$V2))
mean_std <- grep("(mean|std)\\(\\)",features)
features_mean_std <- features[mean_std]

## Organize the test data into a dataset
setwd("./test")
test_y <-tbl_df(read.table("y_test.txt"))
test_x <-tbl_df(read.table("x_test.txt"))
test_subject<-tbl_df(read.table("subject_test.txt"))
test_value<-cbind(test_subject,test_y,
                  test_x)
## Organize the train data into a dataset
setwd("../")
setwd("./train")
train_y <-tbl_df(read.table("y_train.txt"))
train_x <-tbl_df(read.table("x_train.txt"))
train_subject<-tbl_df(read.table("subject_train.txt"))
train_value<-cbind(train_subject,train_y,
                   train_x)
datall<-rbind(test_value,train_value)

## Extracts only the measurements on the mean and standard
## deviation for each measurement.

data_mean_std <-datall[c(1,2,mean_std+2)]

## Uses descriptive activity names to name the activities
## n the data set
names(data_mean_std)[1:2]<-c("subjectID","activityID")
data_mean_std<-merge(activity_labels,data_mean_std,
                     by="activityID")

##Appropriately labels the data set with descriptive 
##variable names.

names(data_mean_std)[4:69]<-features_mean_std

## From the data set in step 4, creates a second, 
##independent tidy data set with the average of each 
##variable for each activity and each subject.
setwd("../../")
by_data_mean_std<-data_mean_std %>% 
        group_by(activityLabel,subjectID)%>% 
        summarize_all(mean)

write.table(by_data_mean_std,"tidy_data_set.txt",
            row.names = FALSE)
