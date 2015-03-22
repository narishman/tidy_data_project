---
title: "README"
output: html_document
---

## Initial Setup :
 The samsung dataset should be available in your current working directory. The directory structure of the raw data should not be altered.
 
base directory name : UCI HAR Dataset
 
## run_analysis.R
 
+ The script reads in the following files into individual data frames.
    - 'features_info.txt': Shows information about the variables used on the feature vector.
    - 'features.txt': List of all features.
    - 'activity_labels.txt': Links the class labels with their activity name.
    - 'train/X_train.txt': Training set.
    - 'train/y_train.txt': Training labels.
    - 'test/X_test.txt': Test set.
    - 'test/y_test.txt': Test labels.
    - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

+ Data frames of the data sets read from the following to files are concatenated, in order, to form a new data frame 'full_set'.
    - 'train/X_train.txt': Training set.
    - 'test/X_test.txt': Test set.

+ The subject id read from the following files are concatenated into a single data frame 'full_subject_id'
    - 'train/subject_train.txt'
    - 'test/subject_test.txt'    
    
+ The activity id read from the following files are concatenated into a single data frame 'full_activity_id'
    - 'train/y_train.txt'
    - 'test/y_test.txt'  
+ content of the features.txt are cleaned up to replace "-" with "_" and "()" with "". It is then set as the column names for the concatenated 'full_set' data frame.
+ subject_id is assigned as the column name for the 'full_subject_id' data frame
+ activity_id is assigned as the column name for the 'full_activity_id' data frame
+ Using the content of the data fram 'activity_labels' from the below file, and the content of 'full_activity_id' dataframe, a join operation is performed to create the new data frame 'full_activity_labels'. The column names of this new data frame are 'activity_id' and 'activity_name'
    - 'activity_labels.txt': Links the class labels with their activity name.
+ A new data frame 'full_set_mean_std' is created by extracting only those columns which capture variable 'mean' and 'standard deviation' from the base 'full_set' data frame.
+ 'subject_id' column from 'full_subject_id' data frame, 'activity_name' column from the 'full_activity_labels' data frame are merged into  the 'full_set_mean_std' data frame.
+ The final tidy_data data frame file is generated by generating means on all columns of the 'full_set_mean_std' data frame grouped by 'subject_id' and 'activity_name'
The column names (except for subject_id and activity_id) of the 'tidy_data' data frame are renamed to include the suffix "_grouped_by_subject_and_activity"
+ The 'tidy_data' data frame is then exported to the 'tidy_data.txt' file.



