#This script will perform the following steps on the UCI HAR Dataset:
# 1. merge the training and test data sets to create one data set.
# 2. extract only the measurements on the mean and standard deviation for each measurement.
# 3. use descriptive activity names to name the activities in the data set.
# 4. appropriately label the data set with descriptive variable names.
# 5. create a second, independent tidy data set with the average of each variable for each activity and subject.

# read in the data from the files
setwd("C://Coursera/GDAssign/UCI HAR Dataset")

features     <- read.table('./features.txt',header=FALSE) 
activity_Type <-read.table('./activity_labels.txt',header=FALSE) 

subject_Train <- read.table('./train/subject_train.txt',header=FALSE) 
x_Train <-read.table('./train/x_train.txt',header=FALSE) 
y_Train <- read.table('./train/y_train.txt',header=FALSE) 
 
subject_Test <- read.table('./test/subject_test.txt',header=FALSE) 
x_Test <- read.table('./test/x_test.txt',header=FALSE) 
y_Test <- read.table('./test/y_test.txt',header=FALSE) 


# Assigin column names to the data imported above 

colnames(activity_Type)  = c('activityId','activityType') 
colnames(subject_Train) = "subjectId" 
colnames(x_Train) = features[,2]  
colnames(y_Train) = "activityId" 


# Create the final training set by merging y_Train, subject_Train, and x_Train 
training_Data <- cbind(y_Train,subject_Train,x_Train) 
 
# Assign column names to the test data 
colnames(subject_Test) = "subjectId" 
colnames(x_Test) = features[,2]  
colnames(y_Test) = "activityId" 
 
# Create the final test set by merging the x_Test, y_Test and subject_Test data 
test_Data <- cbind(y_Test,subject_Test,x_Test) 


# Combine training and test data to create a final data set 
final_Data <- rbind(training_Data,test_Data)

# Create a vector for the column names from the finalData, which will be used 
# to select the desired mean() & stddev() columns 
colNames  = colnames(final_Data)


# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others 
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames)) 
 

# Subset finalData table based on the logicalVector to keep only desired columns 
final_Data <- final_Data[logicalVector==TRUE] 
 

 # Merge the finalData set with the acitivityType table to include descriptive activity names 
final_Data = merge(final_Data,activity_Type,by='activityId',all.x=TRUE) 
 

# Update the colNames vector to include the new column names after merge 
colNames  = colnames(final_Data) 
 

# Cleaning up the variable names 
for (i in 1:length(colNames))  { 
    colNames[i] = gsub("\\()","",colNames[i]) 
    colNames[i] = gsub("-std$","StdDev",colNames[i]) 
    colNames[i] = gsub("-mean","Mean",colNames[i]) 
    colNames[i] = gsub("^(t)","time",colNames[i]) 
    colNames[i] = gsub("^(f)","freq",colNames[i]) 
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i]) 
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i]) 
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i]) 
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i]) 
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i]) 
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i]) 
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i]) 
}
 

# Reassigning the new descriptive column names to the finalData set 
colnames(final_Data) = colNames 


  
 # Create a new table, finalDataNoActivityType without the activityType column 
finalDataNoActivityType  <- final_Data[,names(final_Data) != 'activityType'] 
 

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject 
mean_Data <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean) 
 

# Merging the tidyData with activityType to include descriptive acitvity names 
mean_Data <- merge(mean_Data,activity_Type,by='activityId',all.x=TRUE)
 

# Export the tidyData set  
write.table(mean_Data, './mean_tidY_Data.txt',row.names=TRUE,sep='\t') 
