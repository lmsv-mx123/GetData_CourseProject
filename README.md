# Getting and Cleaning Data

## The raw data files
The main folder UCI HAR Dataset contains:
  
1. a train data folder of
 * X\_train.txt: Train feature data set, consisting of 561 measurements/features from accelerometer and gyroscope
 * y\_train.txt: Train activity data set (identified by activity\_id)
 * subject\_train.txt: Subject train data set (identified by subject\_id)

2. a test data folder of
 * X\_test.txt: Test feature data set, consisting of 561 measurements/features from accelerometer and gyroscope
 * y\_test.txt: Test activity data set (identified by activity\_id)
 * subject\_test.txt: Subject test data set (identified by subject\_id)

3. activity\_labels.txt: Data set with the Activity\_id and Activity\_Label relationship (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)

4. features.txt: All of the features obtained, namely a multiplication of

 ><table>
  <tr>
  <th>Name</th>
  <th>Time</th>
  <th>Freq.</th>
  </tr>
  <tr>
  <td>Body Linear Acceleration</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Gravity Linear Acceleration</td>
  <td>1</td>
  <td>0</td>
  </tr>
  <tr>
  <td>Body Linear Jerk</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Body Angular Velocity</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Body Angular Acceleration</td>
  <td>1</td>
  <td>0</td>
  </tr>
  <tr>
  <td>Body Linear Acceleration Magnitude</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Gravity Linear Acceleration Magnitude</td>
  <td>1</td>
  <td>0</td>
  </tr>
  <tr>
  <td>Body Linear Jerk Magnitude</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Body Angular Velocity Magnitude</td>
  <td>1</td>
  <td>1</td>
  </tr>
  <tr>
  <td>Body Angular Acceleration Magnitude</td>
  <td>1</td>
  <td>1</td>
  </tr>
  </table>
  
  with

 ><table>
  <tr>
  <th>Function</th>
  <th>Description</th>
  </tr>
  <tr>
  <td>mean</td>
  <td>Mean value</td>
  </tr>
  <tr>
  <td>std</td>
  <td>Standard deviation</td>
  </tr>
  <tr>
  <td>mad</td>
  <td>Median absolute value</td>
  </tr>
  <tr>
  <td>max</td>
  <td>Largest values in array</td>
  </tr>
  <tr>
  <td>min</td>
  <td>Smallest value in array</td>
  </tr>
  <tr>
  <td>sma</td>
  <td>Signal magnitude area</td>
  </tr>
  <tr>
  <td>energy</td>
  <td>Average sum of the squares</td>
  </tr>
  <tr>
  <td>iqr</td>
  <td>Interquartile range</td>
  </tr>
  <tr>
  <td>entropy</td>
  <td>Signal Entropy</td>
  </tr>
  <tr>
  <td>arCoeff</td>
  <td>Autorregresion coefficients</td>
  </tr>
  <tr>
  <td>correlation</td>
  <td>Correlation coefficient</td>
  </tr>
  <tr>
  <td>maxFreqInd</td>
  <td>Largest frequency component</td>
  </tr>
  <tr>
  <td>meanFreq</td>
  <td>Frequency signal weighted average</td>
  </tr>
  <tr>
  <td>skewness</td>
  <td>Frequency signal Skewness</td>
  </tr>
  <tr>
  <td>kurtosis</td>
  <td>Frequency signal Kurtosis</td>
  </tr>
  <tr>
  <td>energyBand</td>
  <td>Energy of a frequency interval</td>
  </tr>
  <tr>
  <td>angle</td>
  <td>Angle between two vectors</td>
  </tr>
  </table>
  
  >Description of function from: https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf

5. features\_info.txt: A description of the base feature list

6. README.txt: a general readme file

## Procedure for tidying up data

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Files included for Project

1. README.md: General readme file for project.
2. CodeBook.md: Code Book describing the variables, the data, and the transformations performed to clean up the data.
3. run\_analysis.R: R script which does the procedure described earlier to tidy up data.
4. tidy\_data.txt: Tidy data set file, output as a txt file.
5. tidy\_data.xls: Tidy data set file, output as xls file for those who see easier data in xls files :)

 * Output files not uploaded into the repository.

## Running the script

* Download the script to the home directory ("~/")

* Execute the following commands (required libraries and the zipped data file are automatically used and if not present, are downloaded and extracted/installed)

  * Curl must be properly set-up in file system when using the script to also fetch zipped data file into working directory, otherwise download and extract the zipped file externally into working directory ("~/").

```
source("run_analysis.R")
run_analysis()
```

## Viewing the text file in R

* To view the text file in a readable way, issue

```
tidydata <- read.table("tidy_data.txt", header = TRUE) #tidy_data.txt must be in current working directory!
View(tidydata)
```

## For further information
Read CodeBook.md for a description of the transformations used as well as the variables and data.
