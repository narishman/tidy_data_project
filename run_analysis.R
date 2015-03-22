
suppressPackageStartupMessages(library(dplyr))

## setting up the relative paths to all the files needed from the Samsung dataset.
activity_labels_file <- "UCI HAR Dataset/activity_labels.txt"
set_column_names_file <- "UCI HAR Dataset/features.txt"

training_set_file <- "UCI HAR Dataset/train/X_train.txt"
training_subject_id_file <- "UCI HAR Dataset/train/subject_train.txt"
training_activity_id_file <- "UCI HAR Dataset/train/y_train.txt"

test_set_file <- "UCI HAR Dataset/test/X_test.txt"
test_subject_id_file <- "UCI HAR Dataset/test/subject_test.txt"
test_activity_id_file <- "UCI HAR Dataset/test/y_test.txt"

## Read in all the files to separate data frames.
activity_labels <-read.table(activity_labels_file,header=FALSE)
set_column_names <-read.table(set_column_names_file,header=FALSE)
training_subject_id <-read.table(training_subject_id_file,header=FALSE)
training_activity_id <-read.table(training_activity_id_file,header=FALSE)
test_subject_id <-read.table(test_subject_id_file,header=FALSE)
test_activity_id <-read.table(test_activity_id_file,header=FALSE)
training_set <- read.table(training_set_file,header=FALSE)
test_set <- read.table(test_set_file,header=FALSE)

## concatenate all training and test table data
full_set <- rbind(training_set, test_set)
full_subject_id <- rbind(training_subject_id,test_subject_id)
full_activity_id <- rbind(training_activity_id,test_activity_id)

## assign header names for all the tables
column_header<-  gsub("-","_", set_column_names[,2])
column_header<-  gsub("\\(\\)","_", column_header)

names(full_set)<- column_header
names(activity_labels)<- c("activity_id","activity_name")
names(full_subject_id) <- "subject_id"
names(full_activity_id) <- "activity_id"

## map the activity_id with activity name
full_activity_labels<-inner_join(full_activity_id, activity_labels)
full_activity_labels<- full_activity_labels[,"activity_name"]
full_activity_labels<- as.data.frame(full_activity_labels)
names(full_activity_labels) <- "activity_name"

## extract only the mean and standard deviation data from the full_set
full_set_mean_std <- full_set[,grepl(".*std_|mean_.*",names(full_set),perl=TRUE)]

## append the subject id and activity id to the full set data frame
full_set_mean_std <- cbind(full_subject_id, full_activity_labels,full_set_mean_std)

## Create the final tidy dataset
tidy_data<-full_set_mean_std %>%
    group_by(subject_id,activity_name) %>%
    summarise_each(funs(mean), contains("mean_"),contains("std_"))
#tidy_data[,c(-1,-2)] <- round(tidy_data[,c(-1,-2)], 8)
colnames(tidy_data)[c(-1,-2)] <- gsub("$", "_grouped_by_subject_and_activity", names(tidy_data[,c(-1,-2)]))

## write out the final tidy dataset.
write.table(tidy_data,file = "tidy_data.txt",row.names = FALSE)
