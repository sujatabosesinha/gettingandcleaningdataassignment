
Getting and cleaning data assignment

You should create one R script called run_analysis.R that does the following.

This is my resubmission because th first submission did not earn enough for me to pass. 

One reviewer suggested renaming the README and CODEBOOK files to the regular names for the assignment so I've done that, although I don't know how to get rid of the other stuff I've uploaded to Github.

I have read David Hood's very helpful site on optimising the submission of this assignment and
made changes hopefully to sufficiently improve it.
https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ 

The dimensions of the two sets of raw data are as follows:

dim(test)
[1] 2947   561

dim(train)
[1] 7352   561




Extracts only the measurements on the mean and standard deviation for each measurement.
After labelling the data and extracting only the variables that contain either the mean or the standard deviation measures, the data set reduces to 

dim(test)
[1] 2947   82

dim(train)
[1] 7352   82


Merges the training and the test sets to create one data set.
After using rowbind to merge the 2 datasets, the dimensions are:
dim(datatogether30)
[1] 10299    82


Appropriately labels the data set with descriptive activity names.
Uses descriptive activity names to name the activities in the data set
WALKING            
WALKING_UPSTAIRS   
WALKING_DOWNSTAIRS 
SITTING            
STANDING           
LAYING 

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
uses melt and dcast from the reshape2 package to do this. 

The dimensions of this final data set, the data set that should be uploaded to the submission, is 
(it does not have the column of 'activity id', it has only 'activity description'): the full explanation of the acronymns of the descriptive names are given in the Codebook.

dim(tidydatatogether30)
[1] 180   81

The principles of tidy data are followed here, which mean that it answers the following questions in the affirmative 
(taken from david hood's helpful hints on submission of this assignment):

1.	Does it have headings so I know which columns are which ?
2.	Are the variables in different columns (depending on the wide/long form) ?
3.	Are there no duplicate columns ?


Steps to work on this course project

Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.

Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.

Run source("run_analysis.R"), then it will generate a new file averageactivitybysubjectrownamesequalfalse.txt in your working directory.


run_analysis.R file will help you to install the dependencies automatically. It needs reshape2 and data.table.

 To check on the final data file, you can save averageactivitybysubjectrownamesequalfalse.txt in the directory and then type in something like

checktidydata <- read.table( "averageactivitybysubjectrownamesequalfalse.txt" , header = TRUE )

and the check the head and tail of the data set or something like that. 

This was suggested in David Hoods web site with suggestions for the submission for assignment to forllow the principle that 
the submission should be done in a manner to make it as easy as possible for the assignment markers 

https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ 

