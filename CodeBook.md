# CodeBook for Course Project

## Input data
The input data 

- [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

constists of a set of measurements, based on accelerometer (3-axial linear acceleration) and gyroscope (3-axial angular velocity) sensors, performed on a group of 30 volunteers performing  6 different activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING). The data is partitioned into train and test, where the former represents 70% of the volunteers and the latter 30%. 

Due to the acceleration signal being constitued by gravitational and body motion components, the authors separated those components into a features vector: (tBodyAcc, tGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag) separated by the X, Y, Z components. Signals labeled with Jerk were derived in time (AccJerk would result in Linear Jerk and GyroJerk in Angular Acceleration). For the signals, different estimations were performed by the authors, mean(), std(), meanFreq(), etc (see features\_info.txt for full listing). 

With the exception of tGravityAcc, tBodyGyroJerk, and tGravityAccMag, the FFT was calculated on the earlier mentioned signals giving the signals in the frequency domain (fBodyAcc, fBodyAccJerk, fBodyGyro, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag).

The data is without units as it is provided normalized by the authors.

## Data Transformation

In order to transform the partitioned and separate data into a tidy data set, the following was performed.
1. Merge train and test data into one merged data set
* Train data was column binded with subject id & activity id & whole feature measurements from the train data
* Test data was similarly column binded subject id & activity id & whole feature measurements from the test data
* The merged data is a row bind of the train data & test data
2. Extract (keep) only the measurements (features) with mean or standard deviation
* Select the columns containing either the keyword mean or std
* Filtered data is the subset of the merged data with the selected columns
3. Obtain the activity names and place them into the data set
* Generate a vector of activity labels, which is a match of the activity id on merged data with the activity label corresponding to the activity id.
* Insert the activity label onto the filtered data set
4. Appropriately label the data set with descriptive variable names (column names)
* Take the filtered column names (features) and since they are abbreviations, to make human readable, a substitution of string patterns is used:

>patterns

"^t" -> "TD-"
"^f" -> "FD-"
"mean\\(\\)" -> "Mean"
"std\\(\\)" -> "Std"
"meanFreq\\(\\)" -> "MeanFreq"
"AccJerk" -> "LinearJerk"
"GyroJerk" -> "AngularAcceleration"
"AccMag" -> "LinearAccelerationMagnitude"
"GyroMag" -> "AngularVelocityMagnitude"
"Acc-" -> "LinearAcceleration-"
"Gyro-" -> "AngularVelocity-"
"Mag-" -> "Magnitude-"
"BodyBody" -> "Body"
"Body" -> "Body-"
"Gravity" -> "Gravity-"

Where some abbreviations are replaced with their full name or their correspondence (AccJerk is Linear Jerk, GyroJerk is Angular Acceleration, etc). TD and FD represent Time-Domain and Frequency-Domain, respectively.
  >Description based on: https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
* The completed data set of step 4 is melted into the id variables and measure variables to have them in unique id-variable combinations
* The shape of the melted data is then described (dcast), based on subject and activity as identifiers, and aggregating afterwards with mean.
* The resulting data set is then exported to a text file and for those who desire a xls file.

## Output data

The output data consists in the column names shown below. Subject\_ID is the subject (1-30), Activity\_Label is the description of the activity performed by the subject (LAYING, SITTING, STANDING, WALKING, WALKING\_DOWNSTAIRS, WALKING\_UPSTAIRS) and the rest of the columns is the aggregated measured data using mean. Due to the fact that the input measured data is normalized, the output measured data is without units.

1.  Subject\_ID
2.  Activity\_Label
3.  TD-Body-LinearAcceleration-Mean-X
4.  TD-Body-LinearAcceleration-Mean-Y
5.  TD-Body-LinearAcceleration-Mean-Z
6.  TD-Body-LinearAcceleration-Std-X
7.  TD-Body-LinearAcceleration-Std-Y
8.  TD-Body-LinearAcceleration-Std-Z
9.  TD-Gravity-LinearAcceleration-Mean-X
10. TD-Gravity-LinearAcceleration-Mean-Y
11. TD-Gravity-LinearAcceleration-Mean-Z
12. TD-Gravity-LinearAcceleration-Std-X
13. TD-Gravity-LinearAcceleration-Std-Y
14. TD-Gravity-LinearAcceleration-Std-Z
15. TD-Body-LinearJerk-Mean-X
16. TD-Body-LinearJerk-Mean-Y
17. TD-Body-LinearJerk-Mean-Z
18. TD-Body-LinearJerk-Std-X
19. TD-Body-LinearJerk-Std-Y
20. TD-Body-LinearJerk-Std-Z
21. TD-Body-AngularVelocity-Mean-X
22. TD-Body-AngularVelocity-Mean-Y
23. TD-Body-AngularVelocity-Mean-Z
24. TD-Body-AngularVelocity-Std-X
25. TD-Body-AngularVelocity-Std-Y
26. TD-Body-AngularVelocity-Std-Z
27. TD-Body-AngularAcceleration-Mean-X
28. TD-Body-AngularAcceleration-Mean-Y
29. TD-Body-AngularAcceleration-Mean-Z
30. TD-Body-AngularAcceleration-Std-X
31. TD-Body-AngularAcceleration-Std-Y
32. TD-Body-AngularAcceleration-Std-Z
33. TD-Body-LinearAccelerationMagnitude-Mean
34. TD-Body-LinearAccelerationMagnitude-Std
35. TD-Gravity-LinearAccelerationMagnitude-Mean
36. TD-Gravity-LinearAccelerationMagnitude-Std
37. TD-Body-LinearJerkMagnitude-Mean
38. TD-Body-LinearJerkMagnitude-Std
39. TD-Body-AngularVelocityMagnitude-Mean
40. TD-Body-AngularVelocityMagnitude-Std
41. TD-Body-AngularAccelerationMagnitude-Mean
42. TD-Body-AngularAccelerationMagnitude-Std
43. FD-Body-LinearAcceleration-Mean-X
44. FD-Body-LinearAcceleration-Mean-Y
45. FD-Body-LinearAcceleration-Mean-Z
46. FD-Body-LinearAcceleration-Std-X
47. FD-Body-LinearAcceleration-Std-Y
48. FD-Body-LinearAcceleration-Std-Z
49. FD-Body-LinearAcceleration-MeanFreq-X
50. FD-Body-LinearAcceleration-MeanFreq-Y
51. FD-Body-LinearAcceleration-MeanFreq-Z
52. FD-Body-LinearJerk-Mean-X
53. FD-Body-LinearJerk-Mean-Y
54. FD-Body-LinearJerk-Mean-Z
55. FD-Body-LinearJerk-Std-X
56. FD-Body-LinearJerk-Std-Y
57. FD-Body-LinearJerk-Std-Z
58. FD-Body-LinearJerk-MeanFreq-X
59. FD-Body-LinearJerk-MeanFreq-Y
60. FD-Body-LinearJerk-MeanFreq-Z
61. FD-Body-AngularVelocity-Mean-X
62. FD-Body-AngularVelocity-Mean-Y
63. FD-Body-AngularVelocity-Mean-Z
64. FD-Body-AngularVelocity-Std-X
65. FD-Body-AngularVelocity-Std-Y
66. FD-Body-AngularVelocity-Std-Z
67. FD-Body-AngularVelocity-MeanFreq-X
68. FD-Body-AngularVelocity-MeanFreq-Y
69. FD-Body-AngularVelocity-MeanFreq-Z
70. FD-Body-LinearAccelerationMagnitude-Mean
71. FD-Body-LinearAccelerationMagnitude-Std
72. FD-Body-LinearAccelerationMagnitude-MeanFreq
73. FD-Body-LinearJerkMagnitude-Mean
74. FD-Body-LinearJerkMagnitude-Std
75. FD-Body-LinearJerkMagnitude-MeanFreq
76. FD-Body-AngularVelocityMagnitude-Mean
77. FD-Body-AngularVelocityMagnitude-Std
78. FD-Body-AngularVelocityMagnitude-MeanFreq
79. FD-Body-AngularAccelerationMagnitude-Mean
80. FD-Body-AngularAccelerationMagnitude-Std
81. FD-Body-AngularAccelerationMagnitude-MeanFreq
