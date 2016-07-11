
## Getting and Cleaning Data assignment
##	Run_Analysis.R
##
##
##
##
## Instructions
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
## Review criterialess 
## The submitted data set is tidy.
## The Github repo contains the required scripts.
## GitHub contains a code book that modifies and updates the available codebooks with the data to indicate 
## all the variables and summaries calculated, along with units, and any other relevant information.
## The README that explains the analysis files is clear and understandable.
## The work submitted for this project is the work of the student who submitted it.
## Getting and Cleaning Data Course Projectless 
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
## The goal is to prepare tidy data that can be used for later analysis. 
## You will be graded by your peers on a series of yes/no questions related to the project. 
## You will be required to submit: 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations or work that you performed 
## to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
## This repo explains how all of the scripts work and how they are connected.
##
## One of the most exciting areas in all of data science right now is wearable computing -
## see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop 
## the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the accelerometers 
## from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
##
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## Here are the data for the project:
## 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## You should create one R script called run_analysis.R that does the following.
##
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
## Good luck!
##
##
## Answer the W questions for this data set;
## Who: who are the individuals in the data set? 30 volunteers, randomly assigned 9 to 
## a test group (30%) and 21 to a train group(70%)
##
## What: what are the variables measured in the data set? 
## 561 variables computed using the raw data taken from accelerometer and gyroscope
##
## Why? Why bother with it? 
## health mangement, develop exercise regimes etc.
##
## When? When was the data collected?
##
## 2012
##
## Where? where was the data collected?
## UCI
## how was it collected?
## by having sample of 30 volunteers wear the Samsung Galaxy fitbit to generate data and use video
## to label the activities that are performed while generating the data
##
##Begin work on R script
## set working directory to the one with assignment dataset UCI HAR Dataset
##
directory =getwd()
##
## dir()
## [1] "activity_labels.txt" "features.txt"        "features_info.txt"  
## [4] "README.txt"          "test"                "train"     
##
## 
## load packages data.table and reshape2
##
##         
packages <- c( "data.table" , "reshape2" )
sapply( packages , require , character.only = TRUE , quietly = TRUE )
##
## data.table 1.9.6  For help type ?data.table or https://github.com/Rdatatable/data.table/wiki
## The fastest way to learn (by data.table authors): https://www.datacamp.com/courses/data-analysis-the-data-table-way
##
## Attaching package: ‘reshape2’
##
## The following objects are masked from ‘package:data.table’:
##
##   dcast, melt
##
## data.table   reshape2 
##      TRUE       TRUE 
##
## read label of activities that data is collected for; what the volunteers were doing
##
> whattheyaredoing <- read.table( "activity_labels.txt" ) [ , 2 ]
## whattheyaredoing
##
## [1] WALKING            WALKING_UPSTAIRS   WALKING_DOWNSTAIRS SITTING            STANDING           LAYING            
## Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
##
## read the vector of features that are calculated from the raw data collection; 
## 561 different measures for each observation made up of processing readings from accelerometer and gyroscope
##
##
> differentmeasures561 <- read.table( "features.txt" ) [ , 2 ]
##
##
## str( differentmeasures561)
##
## Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...
##
##
##
##
##  data table contains many other statistics as described in file features_info;
## 
## 
## The set of variables that were estimated from these signals are:  mean(): Mean value
## std(): Standard deviation, mad(): Median absolute deviation , max(): Largest value in array
## min(): Smallest value in array, sma(): Signal magnitude area, energy(): Energy measure.
##  Sum of the squares divided by the number of values, iqr(): Interquartile range 
## entropy(): Signal entropy , arCoeff(): Autorregresion coefficients with Burg order equal to 4
## correlation(): correlation coefficient between two signals, 
## maxInds(): index of the frequency component with largest magnitude
## meanFreq(): Weighted average of the frequency components to obtain a mean frequency
## skewness(): skewness of the frequency domain signal, kurtosis(): kurtosis of the frequency domain signal 
## bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
## angle(): Angle between to vectors.
##
## Additional vectors obtained by averaging the signals in a signal window sample. 
## These are used on the angle() variable:gravityMean, tBodyAccMean, tBodyAccJerkMean
## tBodyGyroMean , tBodyGyroJerkMean
## 
## The complete list of variables of each feature vector is available in 'features.txt'
##
## need to extract only the mean and standard deviation variables for each measurement;
##
## mean and standard deviations are the first 2 to appear in the list
## will use logical vector created through grepl() function to select these
##
##
> meanandstdev <- grepl( "mean|std" , differentmeasures561 )

##
##
## randomly assigned 9 volunteers to test group; 
## read data values of variables measured for test group
##
> measurestestgroup9 <- read.table( "test/X_test.txt" )

##
## str( measurestestgroup9 )
## 'data.frame':   2947 obs. of  561 variables:
##  $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
## $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
## etc.
##
## dim( measurestestgroup9 )
## [1] 2947  561
##
##
## Now read data where each row identifies the subject or volunter who performed the activity 
## for each window sample. Its range is from 1 to 30. Test group has 9 volunteers randomly assigned to it.
##
> volunteersrandomlytestgroup9 <- read.table( "test/subject_test.txt" )
## dim( volunteersrandomlytestgroup9 )
## 2947    1
##
## 
## assign column headings to data file of computed variables by using the labels of features measured
##
> names( measurestestgroup9 ) = differentmeasures561
##
##
## Now select only the columns with measurement on the mean and standard deviation 
## of each calculated variable
##
##
> meanstdevmeasurestestgroup9 = measurestestgroup9[ , meanandstdev ]
##
## dim( meanstdevmeasurestestgroup9 )
## [1] 2947   79
##
## reduces the number of columns from 561 to 79; the rest are of other measures, such as correlation etc.
##
##
## meanstdevmeasurestestgroup9[ 1:2, 1:8 ]
##     
##
##tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
## 1         0.2571778       -0.02328523       -0.01465376       -0.9384040       -0.9200908       -0.6676833            0.9364893           -0.2827192
## 2         0.2860267       -0.01316336       -0.11908252       -0.9754147       -0.9674579       -0.9449582            0.9274036           -0.2892151
##
##
## Now read table of labels for each observation computed for the 9 volunteers in test group 
##
> labelsobservationtest9 <- read.table( "test/y_test.txt" )

##
## dim( labelsobservationtest9)
## [1] 2947    1
## head( labelsobservationtest9 )
##    V1
## 1  5
## 2  5
## 3  5
## 4  5
## 5  5
## 6  5
##
##
## assign activity descriptions to the 2nd column using numbers contained in column 1 of 
## labels of activity id for each observation in test group
##
> labelsobservationtest9[ , 2 ] = whattheyaredoing[ labelsobservationtest9[ , 1 ] ]
## > head(labelsobservationtest9)
##   V1       V2
## 1  5 STANDING
## 2  5 STANDING
## 3  5 STANDING
## 4  5 STANDING
## 5  5 STANDING
## 6  5 STANDING
##
## assign column headings to the labels of each observation of measured data 
## for 9 volunteers in test group
##
##
> names( labelsobservationtest9 ) = c( "idofwhatheyaredoing" , "descriptionofwhattheyaredoing" )
##
##
## assign column heading for the subject  or volunteer that the observation belongs to 
##
> names(volunteersrandomlytestgroup9 ) = "volunteersorsubjects" 
##
## dim( volunteersrandomlytestgroup9 )
## [1] 2947    1
## head( volunteersrandomlytestgroup9 )
##    volunteersorsubjects
##1                      2
##2                      2
##3                      2
##4                      2
##5                      2
##6                      2
##
##
## columnbind data for test group using labels for volunteers and activities and data values
##
> testgroup9data <- cbind( as.data.table( volunteersrandomlytestgroup9) , labelsobservationtest9, meanstdevmeasurestestgroup9 )
##
## dim(testgroup9data)
##[1] 2947   82
##
## added two columns for volunteer label and observation label
##
## testgroup9data[ 1:3 , 1:7 ]
##   Volunteers or subjects idofwhatheyaredoing descriptionofehattheyaredoing tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
##1:                      2                   5                      STANDING         0.2571778       -0.02328523       -0.01465376       -0.9384040
##2:                      2                   5                      STANDING         0.2860267       -0.01316336       -0.11908252       -0.9754147
##3:                      2                   5                      STANDING         0.2754848       -0.02605042       -0.11815167       -0.9938190
##
##
## Now repeat process for putting together data table for train group of 21 volunteers
## (70 % of 30 volunteers randomly assigned to train group)
##
## read data values for train group
##
> measurestraingroup21 <- read.table( "train/X_train.txt" )
## dim( measurestraingroup21 )
## [1] 7352  561
##
## measurestraingroup21[ 1:3 , 1:5 ]
##  tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
##1         0.2885845       -0.02029417        -0.1329051       -0.9952786       -0.9831106
##2         0.2784188       -0.01641057        -0.1235202       -0.9982453       -0.9753002
##3         0.2796531       -0.01946716        -0.1134617       -0.9953796       -0.9671870
##> tail(measurestraingroup21[ , 1:5])
##     tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
##7347         0.2379665      -0.001087807       -0.14832590       -0.2189488      -0.01292675
##7348         0.2996653      -0.057193414       -0.18123302       -0.1953865       0.03990485
##7349         0.2738527      -0.007749326       -0.14746837       -0.2353085       0.00481628
##7350         0.2733874      -0.017010616       -0.04502183       -0.2182182      -0.10382198
##7351         0.2896542      -0.018843044       -0.15828059       -0.2191394      -0.11141169
##7352         0.3515035      -0.012423118       -0.20386717       -0.2692704      -0.08721154
##
## read labels for observations in train group data for 21 volunteers
##
> labelsobservationtrain21 <- read.table( "train/y_train.txt" )
##
##
## read labels for 21 volunteers randomly assigned to tran group
##
##
> volunteersrandomlytraingroup21 <- read.table( "train/subject_train.txt" )
##
##
## assign names for column headings of data calculated for 21 volunteers in train group
##
##
> names( measurestraingroup21 ) = differentmeasures561
##
## assign activity descriptions to the 2nd column using numbers contained in column 1 of 
## labels of activity id for each observation in test group
##
> labelsobservationtrain21[ , 2 ] = whattheyaredoing[ labelsobservationtrain21[ , 1 ] ]
##
##
## assign column headings to the labels of each observation of measured data 
## for 21 volunteers in train group
##
>  names( labelsobservationtrain21 ) = c( "idofwhatheyaredoing" , "descriptionofwhattheyaredoing" )
##
##
##assign column heading for the subject  or volunteer that the observation belongs to 
##
> names( volunteersrandomlytraingroup21 ) = "volunteersorsubjects"
##
## Now select only the columns with measurement on the mean and standard deviation 
## of each calculated variable for train group
##
> meanstdevmeasurestraingroup21 = measurestraingroup21[ , meanandstdev ]
##
## dim(meanstdevmeasurestraingroup21)
##[1] 7352   79
## reduced to 79 columns because other things such as correlation were not selected
##
##columnbind data for test group using labels for volunteers and activities and data values
##
> traingroup21data <- cbind( as.data.table( volunteersrandomlytraingroup21) , labelsobservationtrain21, meanstdevmeasurestraingroup21 )
## dim( traingroup21data)
## [1] 7352   82
## head(traingroup21data[ , 1:7 ] )
##   volunteersorsubjects idofwhatheyaredoing descriptionofwhattheyaredoing tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
##                      1                   5                      STANDING         0.2885845       -0.02029417        -0.1329051       -0.9952786
##                      1                   5                      STANDING         0.2784188       -0.01641057        -0.1235202       -0.9982453
##                      1                   5                      STANDING         0.2796531       -0.01946716        -0.1134617       -0.9953796
##                      1                   5                      STANDING         0.2791739       -0.02620065        -0.1232826       -0.9960915
##                      1                   5                      STANDING         0.2766288       -0.01656965        -0.1153619       -0.9981386
##                      1                   5                      STANDING         0.2771988       -0.01009785        -0.1051373       -0.9973350
##
##
## now merge test groupof 9 volunteers data with train group of 21 volunteers data using rowbind function
## so there will then be data for all of the 30 volunteers together
##
> datatogether30 <- rbind( testgroup9data, traingroup21data )

##
## dim(datatogether30)
## [1] 10299    82
## head(datatogether30[ , 1:7 ])
##     volunteersorsubjects idofwhatheyaredoing descriptionofwhattheyaredoing tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
##1:                      2                   5                      STANDING         0.2571778       -0.02328523       -0.01465376       -0.9384040
##2:                      2                   5                      STANDING         0.2860267       -0.01316336       -0.11908252       -0.9754147
##3:                      2                   5                      STANDING         0.2754848       -0.02605042       -0.11815167       -0.9938190
##4:                      2                   5                      STANDING         0.2702982       -0.03261387       -0.11752018       -0.9947428
##5:                      2                   5                      STANDING         0.2748330       -0.02784779       -0.12952716       -0.9938525
##6:                      2                   5                      STANDING         0.2792199       -0.01862040       -0.11390197       -0.9944552
##> tail(datatogether30[ , 1:7 ] )
##     volunteersorsubjects idofwhatheyaredoing descriptionofwhattheyaredoing tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
##1:                     30                   2              WALKING_UPSTAIRS         0.2379665      -0.001087807       -0.14832590       -0.2189488
##2:                     30                   2              WALKING_UPSTAIRS         0.2996653      -0.057193414       -0.18123302       -0.1953865
##3:                     30                   2              WALKING_UPSTAIRS         0.2738527      -0.007749326       -0.14746837       -0.2353085
##4:                     30                   2              WALKING_UPSTAIRS         0.2733874      -0.017010616       -0.04502183       -0.2182182
##5:                     30                   2              WALKING_UPSTAIRS         0.2896542      -0.018843044       -0.15828059       -0.2191394
##6:                     30                   2              WALKING_UPSTAIRS         0.3515035      -0.012423118       -0.20386717       -0.2692704
##
##
## now begin process of calculating the averages across all observations with a particular 
## mean or standad deviation measure for a particular volunteer and a particular activity;
## since there are 6 activities and 30 variables,there will be 180 rows in the resulting tidy data set
## the number of columns will still be the same. 
##
## assign id labels of measures that will determine what to select to figure the averages
##
> idlabels = c( "volunteersorsubjects" , "idofwhatheyaredoing" , "descriptionofwhattheyaredoing" )
##
## use setdiff function to gather overlapping measures for volunteers and activities
##
> datalabels = setdiff( colnames( datatogether30 ) , idlabels )
## convert wide data to long data form writing rows under one another for particular volunteer and
## particular activity
##
> meltdatatogether30 = melt( datatogether30 , id = idlabels , measure.vars = datalabels )
##
##
## dim(meltdatatogether30)
## [1] 813621      5
## head(meltdatatogether30)
##   Volunteers or subjects idofwhatheyaredoing descriptionofehattheyaredoing          variable     value
##1:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2571778
##2:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2860267
##3:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2754848
##4:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2702982
##5:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2748330
##6:                      2                   5                      STANDING tBodyAcc-mean()-X 0.2792199
##
##
## now use dcast() function to apply mean function to defie the tidy data set
## so that averages will be calculated for each measure for a particular volunteer and
## for a particular activity
##
##
> tidydatatogether30 = dcast( meltdatatogether30, volunteersorsubjects + descriptionofwhattheyaredoing ~ variable , mean )
##
##
##> dim(tidydatatogether30)
##[1] 180  81
##
##
## tidydatatogether30[ 1:10, 1:7 ]
## volunteersorsubjects descriptionofehattheyaredoing tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
##1                   1                        LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647     -0.836827406
##2                   1                       SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901     -0.922618642
##3                   1                      STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990     -0.973190056
##4                   1                       WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337
##5                   1            WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943
##6                   1              WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265
##7                   2                        LAYING         0.2813734      -0.018158740        -0.1072456      -0.97405946     -0.980277399
##8                   2                       SITTING         0.2770874      -0.015687994        -0.1092183      -0.98682228     -0.950704499
##9                   2                      STANDING         0.2779115      -0.018420827        -0.1059085      -0.98727189     -0.957304989
##10                  2                       WALKING         0.2764266      -0.018594920        -0.1055004      -0.42364284     -0.078091253
##
##
## Now write the tidy data set on to the assignment directory in computer
##
##
> write.table( tidydatatogether30 , file = "./averageactivitybysubjectrownamesequalfalse " , row.name=FALSE)
##
##
##  dir()
##[1] "activity_labels.txt"                     "averagevariableforactivitybysubject.txt"
##[3] "features.txt"                            "features_info.txt"                      
##[5] "READ
##