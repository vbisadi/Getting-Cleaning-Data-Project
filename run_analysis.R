library("plyr", lib.loc="~/R/win-library/3.1")
#Read data files------------------------------------------------------------------
subject_test<-read.table(".\\test\\subject_test.txt")
X_test<-read.table(".\\test\\X_test.txt")
y_test<-read.table(".\\test\\y_test.txt")
subject_train<-read.table(".\\train\\subject_train.txt")
X_train<-read.table(".\\train\\X_train.txt")
y_train<-read.table(".\\train\\y_train.txt")
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")
#Change activity names to more descriptive names-----------------------------------
features1<-gsub("Acc","-acceleration",features$V2)
features2<-gsub("Gyro","-angular-velocity-",features1)
features3<-gsub("[[:punct:]]"," ",features2)
names(activity_labels)<-c("Activity_NO","Activity")
#Combine test and train data-------------------------------------------------------
X<-rbind(X_test,X_train)
names(X)<-features3
activity_numbers<-rbind(y_test,y_train)
names(activity_numbers)<-"Activity_NO"
activity<-join(activity_numbers,activity_labels,by="Activity_NO")
activity<-activity$Activity
names(activity)<-"Activity"
subject<-rbind(subject_test,subject_train)
names(subject)<-"Subject"
#Select those columns that include mean and standard deviation data------------------
mean_std_cols<-grepl("mean",features[,2])|grepl("std",features[,2])
mean_std_variables<-X[,mean_std_cols]
tidytable<-cbind(subject,activity,mean_std_variables)
#Prepare second tidy table-----------------------------------------------------------
second_tidytable<-ddply(tidytable,.(Subject,activity),summarise,ind.m.Value=mean(tidytable[,3]))
for (i in 4:ncol(tidytable)){
  nextcolumn<-tidytable[,i]
  mean_tidytable1<-ddply(tidytable,.(Subject,activity),summarise,ind.m.Value=mean(nextcolumn))
  newColumn<-mean_tidytable1[,3]
  second_tidytable<-cbind(second_tidytable,newColumn)  
}
names(second_tidytable)<-names(tidytable)
write.table(second_tidytable,"tidy_data.txt")
