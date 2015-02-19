##The R script, run_analysis.R, does the following: 
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##3. Uses descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names. 
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") {
  
  message("Loading required packages ...")
  
  ##Download required packages if not present in library
  if (!require("data.table")) {
    install.packages("data.table")
  }
  if (!require("reshape2")) {
    install.packages("reshape2")
  }
  if (!require("tools")) {
    install.packages("reshape2")
  }
  if (!require("dataframes2xls")) {
    install.packages("dataframes2xls")
  }
  
  library(data.table)
  library(reshape2)
  library(tools)
  library(dataframes2xls) ##optional since column names a bit long, for some users it might be more readable as xls
  
  ##Change to home working directory
  setwd("~/")
  
  ##Fetch and store file
  decoded_url <- URLdecode(url)
  file <- basename(decoded_url)
  ##Download and extract only if not already downloaded
  if(!file.exists(file)) {
    message("Downloading data file")
    download.file(url, file, method = "curl")
    unzip(file)
  }
  
  message("Reading files ...")
  ##Load train data.
  message("Reading X_train.txt")
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  message("Reading y_train.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  message("Reading subject_train.txt")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
  ##Combine train data (subject_train+y_train+X_train) with cbind
  train_data <- cbind(subject_train, y_train, X_train)
  names(train_data)[c(1,2)] = c("Subject_ID", "Activity_ID")
  
  ##Load test data.
  message("Reading X_test.txt")
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  message("Reading y_test.txt")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  message("Reading subject_test.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  ##Combine test data (subject_test+y_test+X_test) with cbind
  test_data <- cbind(subject_test, y_test, X_test)
  names(test_data)[c(1,2)] = c("Subject_ID","Activity_ID")
  
  message("Merging data")
  ## 1. Merge train and test data with rbind
  merged_data <- rbind(train_data,test_data)
  
  ##Load Activity Labels. 1st col=id, 2nd col=label, 
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  ##Load Features (The data column names)
  features <- read.table("UCI HAR Dataset/features.txt")
  
  ##Features with either mean or std
  desired_feature_index <- grep(".*mean.*|.*std.*", features[,2])
  desired_features <- features[features[,1] %in% desired_feature_index,2]
  
  message("Filtering data to keep only columns with mean or std features")
  ## 2. Extract and keep only the measurements on the mean and standard deviation for each measurement.
  filtered_data <- merged_data[,2+desired_feature_index]
  
  message("Labeling column names for data ...")
  ## 3. Use descriptive activity names to name the activities in the data set
  ##Append the first 2 columns(Subject_ID,Activity_ID) and match Activity_ID with Activity_Label
  activity_names <- activity_labels[merged_data[,2],2] ##id in 2nd col of merged_data and name in 2nd col of activity_labels
  complete_filtered_data <- cbind(merged_data[,c(1,2)],activity_names,filtered_data)
  
  ## 4. Appropriately labels the data set with descriptive variable names.
  old_names<-desired_features
  new_names<-sub("^t","TD-",old_names)
  new_names<-sub("^f","FD-",new_names)
  new_names<-sub("mean\\(\\)","Mean",new_names)
  new_names<-sub("std\\(\\)","Std",new_names)
  new_names<-sub("meanFreq\\(\\)","MeanFreq",new_names)
  new_names<-sub("AccJerk","LinearJerk",new_names)
  new_names<-sub("GyroJerk","AngularAcceleration",new_names)
  new_names<-sub("AccMag","LinearAccelerationMagnitude",new_names)
  new_names<-sub("GyroMag","AngularVelocityMagnitude",new_names)
  new_names<-sub("Acc-","LinearAcceleration-",new_names)
  new_names<-sub("Gyro-","AngularVelocity-",new_names)
  new_names<-sub("Mag-","Magnitude-",new_names)
  new_names<-sub("BodyBody","Body",new_names)
  new_names<-sub("Body","Body-",new_names)
  new_names<-sub("Gravity","Gravity-",new_names)
  names(complete_filtered_data) = c("Subject_ID","Activity_ID", "Activity_Label",
                                    as.vector(new_names))
  
  message("Reshaping data and calculating avg for each subject and activity ...")
  ## 5. From the data set in step 4, create a second, independent tidy data set with the
  ## average of each variable for each activity and each subject.
  ##Separate between id columns and measure columns for melt
  id_vars = c("Subject_ID", "Activity_ID", "Activity_Label")
  measure_vars = setdiff(colnames(complete_filtered_data), id_vars)
  
  ##Melting to have data in unique id-variable combination
  melt_data = melt(complete_filtered_data, id.vars = id_vars, measure.vars = measure_vars)
  
  ##Describing the shape of the data with dcast (based on subject and activity as id) and aggregating with mean
  tidy_data <<- dcast(melt_data, Subject_ID + Activity_Label ~ variable, 
                      fun.aggregate = mean, 
                      na.rm = TRUE)
  
  message("Exporting to local file tidy_data.txt")
  ##Export table to file
  write.table(tidy_data, file = "tidy_data.txt", sep="\t", row.names=FALSE)
  write.xls(tidy_data, file = "tidy_data.xls", row.names=FALSE)
}