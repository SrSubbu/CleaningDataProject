runAnalysis <- function(){
  library(stringr)
  library(dplyr)
  ##Get the current WD to reset it at the end of function
  CurrentWD <- getwd()
  print(CurrentWD)
  ##1.Read the test data
  ##1.1Set the test folder as working directory
  setwd(str_c(getwd(),"/","test"))
  ##1.2Get the data of subject, X and Y values
  testSubject<-read.table("subject_test.txt")
  testX<-read.table("X_test.txt")
  testY<-read.table("y_test.txt")
  testTable<-cbind(testSubject,testY,rbind(testX))
  
  ##1.3ReSet the main folder as thw working directory
  setwd(CurrentWD)
  
  ##1.4Set the test folder as working directory
  setwd(str_c(getwd(),"/","train"))
  ##1.5Get the data of subject, X and Y values
  trainSubject<-read.table("subject_train.txt")
  trainX<-read.table("X_train.txt")
  trainY<-read.table("y_train.txt")
  Traintable<-cbind(trainSubject,trainY,rbind(trainX))  

  ##1.6ReSet the main folder as thw working directory
  setwd(CurrentWD)
  
  ##1.7Merge the test and train data
  combinedTable<-rbind(testTable,Traintable)
  
  ##1.8ReSet the main folder as thw working directory
  setwd(CurrentWD)
  
  ##1.9Set the column headers of the table
  t1<-c("SubjectID","Activity_Labels")
  t2<-readLines("features.txt")
  headers<-append(t1,t2)
  colnames(combinedTable)<-headers
  
  ##1.10Map the activity labels and activity name
  activityLabels<-read.table("activity_labels.txt")
  for (i in 1:nrow(combinedTable)){
    combinedTable[i,2]<-toString(activityLabels[combinedTable[i,2],2])
  }
  
  StdMeanData<-cbind(combinedTable$SubjectID,combinedTable$Activity_Labels)
  ##set the column names of first 2 columns
  colnames(StdMeanData)<-t1
  ##1.11Loop through the columns which has mean() and std() in it
  for (name in colnames(combinedTable)){
    if (str_detect(name,"mean()")){
      StdMeanData<-cbind(StdMeanData,combinedTable[name])
    }
    else if (str_detect(name,"std()")){
      StdMeanData<-cbind(StdMeanData,combinedTable[name])  
    }
    
  }
  
  newColNames<-c('')
  ##1.12Loop through the column names of refined data (stdMeanData)
  for (i in 1:ncol(StdMeanData)){
    name<-colnames(StdMeanData[i])
    ##Change the Acc to acceleration
    name<-gsub("BodyAcc","BodyAcceleration",name)
    name<-gsub("GravityAcc","GravityAcceleration",name)
    ##Change the Mag to Magnitude
    name<-gsub("Mag","Magnitude",name)
    ##Edit the Variable 't' and 'f' to "Time" and "Freq"
    name<-gsub(" t","Time",name)
    name<-gsub(" f","Freq",name)
    ##Remove the mean() and std()
    name<-gsub("mean()","Mean",name)
    name<-gsub("std()","Std",name)
    ##Replace the word BodyBody to Body
    name<-gsub("BodyBody","Body",name)
    if (length(newColNames==1) && newColNames[1]==''){
      newColNames<-c(name)
    }
    else{
      newColNames<-append(newColNames,name)
    }    
  }
  ##1.13Assign the new column names to the data table
  colnames(StdMeanData)<-newColNames
  
  ##1.14 Group the data by subject and activity. Then get the average of each column
  tidyData <- StdMeanData %>% group_by(SubjectID,Activity_Labels) %>% summarise_each(funs(mean)) 
  
  write.table(tidyData,"IndependentTidyData.txt",row.names=FALSE)
  ##write.csv(tidyData,"tidyData.csv",row.names=FALSE)
  ##write.csv(combinedTable,"CombinedData.csv",row.names=FALSE)
}

