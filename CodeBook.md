# Introduction
  This project was based on Human Activity Recognition Using Smartphones Dataset.
  The experiments have been carried out with a group of 30 volunteers within an     age bracket of 19-48 years. 
  Each person performed six activities (WALKING,WALKING_UPSTAIRS,
  WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung      Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we     captured 3-axial linear acceleration and 3-axial angular velocity at a constant   rate of 50Hz. 
  The experiments have been video-recorded to label the data manually. The          obtained dataset has been randomly partitioned into two sets, where 70% of the    volunteers was selected for generating the training data and 30% the test data. 
  
  Shown in the run_analysis.R script file in the url for obtaining this data.

# Description of Run_analysis.R File
  Shown below is a description of each step of the script file in its entirity.
  - The first step sets the working directory of choice and clears the                workspace to clear out unneeded variables.
  - Creates directory for raw data + unzip file and direct workspace to path 
  - Read .txt files from respective folders 
  - Merges Training and Test sets of Subject, Activity and Feature data using         the rbind() function.
  - Assign Column names to table + include feature names using the cbind()            function. 
  - Combine feature subject and activity data 
  - Extract only the measurements on the mean and standard deviation for each         measurement 
  - Label activities with appropriate description 
  - Displays descriptive variable names in data set using the gsub() function.
  - Creates a second independent tidy data set with the average of each               variable for each acitivity and each subject called UCI_data2

# Description of Script Variables
  - 'features.txt': List of all features.
  - 'activity_labels.txt': Links the class labels with their activity name.
  - 'X_train.txt': Training set data.
  - 'y_train.txt': Training class labels.
  - 'X_test.txt': Test set data.
  - 'y_test.txt': Test class labels.
  - 'subject_train.txt': Each row identifies the subject who performed the            activity for each window sample. Its range is from 1 to 30.
  - 'subject_test.txt': Each row identifies the subject who performed the activity     for each window sample. Its range is from 1 to 30. 
  
  - UCI_Data - Shows the merged training and test data
  - UCI_Data2 - Will display the second independent tidy data set with the average     of each variable for each activity and each subject.