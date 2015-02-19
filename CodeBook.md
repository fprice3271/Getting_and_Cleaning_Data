##Code Book

**Raw data collection**

The dataset is derived from the "Human Activity Recognition Using Smartphone Data Set" which is available at (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The experiments were carried out with a group of 30 volunteers within an age bracket of 19 to 48 years.  Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a Samsung Galaxy S II smartphone on the waist.  Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.  The experiments were video-taped to label the data manually.
The obtained data set was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% for the test data.

The accelerometer and gyroscope signals were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).  The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.  

The features selected for this data set came from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  The acceleration signal was seperated body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ).  The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).  The magnitude of these 3-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyByroJerkMag).  A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyACCJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.  (NOTE: '-XYZ' is used to denote 3-axial signals in the X, Y, and Z directions).

From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  The set of variables that were estimated from these signals were:
  .  mean(): mean value
  .	std(): standard deviation
  .	mad(): median absolute deviation
  .	max(): largest value in array
  .	min(): smallest value in array
  .	sma(): signal magnitude area
  .	energy(): energy measure (sum of the squares divided by the number of values)
  .	iqr(): interquartile range
  .	entropy(): signal entropy
  .	arCoeff(): autoregression coefficients with burg order equal to 4
  .	correlation(): correlation coefficient between two signals
  .	maxInds(): index of the frequency component with the largest magnitude
  .	meanFreq(): weighted average of the frequency components to obtain a mean frequency
  .	skewness(): skewness of the frequency domain signal
  .	kurtosis(): kurtosis of the frequency domain signal
  .	bandsEnergy(): energy of a frequency interval within the 64 bins of the FFT of each window
  .	angle(): angle between some vectors

All features are normalized and bounded within [-1,1].

**Data transformation**

The raw data sets are processed with run_analysis.R script to create a tidy data set.

  1.	Merge training and test sets - test and training data, subject ids, and activity ids are merged to obtain a single data set.  Variables are labelled with the names assigned by the original observers.
  2.	Extract mean and standard deviation - from the merged data set, the estimated mean and standard deviations for each measurement are extracted.
  3.	Use descriptive activity names - replace the activity ID's with activity labels for clarity.
  4.	Appropriately label descriptive variable names - replace the abbreviated variable labels with clearer labels
  5.	Create an independent tidy data set with mean of each variable - a final tidy data set is created where numeric variables are averaged for each activity and each subject. 
  

