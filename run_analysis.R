library(dplyr)
library(data.table)
library(reshape2)

filename <- "cleaning_data.zip"
foldername <- "UCI HAR Dataset"
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(filename)){
    download.file(fileurl, filename)
}
if (!file.exists(foldername)){
    unzip(filename)
}

activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
features$V1 <- NULL
features$V2 <- gsub("-", "", features$V2)

features$V2 <- gsub("[() *]|[0-9]|,", "", features$V2)

#Loading the Test data
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test_subjects) <- "subject_number"
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")

#loading the Train show
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train_subjects) <- "subject_number"
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")

colnames(test_x) <- features$V2
colnames(train_x) <- features$V2

test_activity_levels <- left_join(test_y, activity_lables)
train_activity_levels <- left_join(train_y, activity_lables)

test_sub_act_lev <- cbind(test_subjects ,test_activity_levels)
train_sub_act_lev <- cbind(train_subjects ,train_activity_levels)

test_sub_act_lev$V1 <- NULL
train_sub_act_lev$V1 <- NULL

names(test_sub_act_lev)[2] <- "action_performed" 
names(train_sub_act_lev)[2] <- "action_performed"

test_sub_act_lev <- cbind(test_sub_act_lev, test_x)
train_sub_act_lev <- cbind(train_sub_act_lev, train_x)

combdata <- rbind(train_sub_act_lev, test_sub_act_lev)

tidy <- combdata[, grepl( "(subject)|(action)|(mean)|(std)", names(combdata))]

melted <- melt(tidy, id=c("subject_number","action_performed"))
completed <- dcast(melted, subject_number + action_performed ~ variable, mean)

write.table(completed, "tidyData.txt", row.names = FALSE, quote = FALSE)






