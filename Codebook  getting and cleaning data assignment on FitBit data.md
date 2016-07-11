
This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

THE DATA SOURCE

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones




DATA SET INFORMATION

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window); The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data

Codebook

The dataset includes the following files:

'README.txt'

'features_info.txt': Shows information about the variables used on the 561 feature vector.

'features.txt': List of all 561 features.

'activity_labels.txt': Links the class labels with their activity name; 6 activities,
 1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
.

'train/X_train.txt': data values for Training set; out of the 30 volunteers for the sample, 70% or 21 were randomly assigned to train set and 30% or 9 were assigned to the test set. 

'train/y_train.txt': Training labels for each observation in data set.

'test/X_test.txt': Test set of data values.

'test/y_test.txt': Test labels for each observation in test set of data values.

The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject or the volunteer who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. The 561 features in data set were calculated using these as raw data.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.





CHANGES I MADE

There are 5 parts:

1.	Merged the training and the test sets to create one data set;
2.	Selected only the measurements on the mean and standard deviation for each measurement;
3.	Used descriptive activity names to name the activities in the data set;
4.	Appropriately labeled the data set with descriptive activity names;
5.	Created a second, independent tidy data set with the average of each variable for each activity and each subject or volunteer;




HOW run.analysis.R  WORKS TO PERFORM STEPS 1 THROUGH 5:

Require reshapre2 and data.table libraries.
Load both test and train data
Load the features and activity labels.
Extract the mean and standard deviation column names and data.
Process the data. There are two parts processing test and train data respectively.
Merge data set.
Melt data set to form long data from wide data to long data form then use dcast to find averages for each variable or measured feature for each volunteer for each activity.
