
file<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#If file does not exist download dataset and unzip. 
if (!file.exists("temp.zip")){
    download.file(file, destfile="temp.zip")
    unzip("temp.zip", exdir="/Users/analesin/Smartphone")
} 
#Read relevant files from the directory. To run the code the change of the directory paths could be n
#needed.

features<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/features.txt")
Xtrain<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/X_train.txt")
Xtest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/X_test.txt")
ytrain<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/y_train.txt")
ytest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/y_test.txt")
subjecttrain<-read.table("/Users/analesin/Smartphone/UCI HAR Dataset/train/subject_train.txt")
subjecttest<- read.table("/Users/analesin/Smartphone/UCI HAR Dataset/test/subject_test.txt")
activitylabel<-read.table("/Users/analesin/Smartphone/UCI HAR Dataset/activity_labels.txt")
featuredata<- as.data.frame(features[,2])

#Pick up the names of the features containing mean and std
featutes_row<- grep(".*mean().*|.*std().*",featuredata[,2])
feature_sample<- as.data.frame(featuredata[features_row,1])

#Trasnspose the dataframe of names of features to put it in a row form
feature_sample_transpose<- t(feature_sample)

#Pick up the training set and testing set associated with the feature names and then merge them
X_train<- Xtrain[,features_row]
X_test<- Xtest[,features_row]
train_test_X<- rbind(X_train,X_test)

#Merge the activity numbers
train_test_y<- rbind(ytrain,ytest)

#Merge the subject numbers
train_test_subject<- rbind(subjecttrain,subjecttest)

#Merge everything to create a new dataframe
all_data<- cbind(train_test_X,train_test_y,train_test_subject)
colnames(all_data)<- c(feature_sample_transpose,"Activity","Subject")
all_data_mean<- aggregate(all_data, by=list(all_data$Activity, all_data$Subject), mean)

#Replace the activity numbers by activity labels.
for (i in 1:6){
  idx<- which(all_data_mean["Activity"]==i)
  all_data_mean[idx,"Activity"]<- as.character(activitylabel[i,2])
}
all_data_mean<- all_data_mean[,-c(1,2)]

#Create a tidy data set.
write.table(all_data_mean, file="/Users/analesin/Smartphone/UCI HAR Dataset/cleandata.txt", sep="\t",row.names=FALSE)
