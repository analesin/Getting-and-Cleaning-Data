---
title: "Codebook.md"
output: html_document
---

**# Description**

  1) Download the given dataset
  2) read relevant train and test files
  3) merge them
  4) find mean according to subject categories.


**# Explanation**
```{r}
if (!file.exists("temp.zip")){
    download.file(file, destfile="temp.zip")
    unzip("temp.zip", exdir="/Users/analesin/Smartphone")
} 
```

downloads the dataset and if the zipped file is not there then unzips it. 


```{r}
features<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/features.txt")
Xtrain<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/X_train.txt")
Xtest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/X_test.txt")
ytrain<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/y_train.txt")
ytest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/y_test.txt")
subjecttrain<-read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/subject_train.txt")
subjecttest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/subject_test.txt")
activitylabel<-read.table("/Users/analesin/Smartphone/UCI HAR Dataset/activity_labels.txt")
```
reads the relevant .txt files. Here **Xtrain,ytrain,subjecttrain** are the training sets and **Xtest, ytest, subjecttest** are the test sets. ytrain and ytest file constains the activitiy numbers.Xtrain and Xtest sets contain mean() and std() numbers. 

```{r}
featutes_row<- grep(".*mean().*|.*std().*",featuredata[,2])
```

We get the features with strings mean() and std() in them. We then use rbind() to merge Xtrain and Xtest. Also ytrain and ytest. Same with subjecttrain and subjecttest. All are merged using cbind(). The data created is "all_data". The colnames of "all_data" are assigned the names of the features with mean() and std() in them."all_data_mean" is the final dataset of the required output of means. A new file call "cleandata.txt" is created with all "all_data_mean" in it.The .txt file is tab delimited and should be opened in excel for better formatting. 

**Feature Selection**

=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

**Activity**

The activities are the following associated with a unique number:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

