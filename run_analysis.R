filename <- "UCI_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

##Read in tables from dataset 

feats <- read.table("UCI HAR Dataset/features.txt")
acts = read.table("UCI HAR Dataset/activity_labels.txt")

trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingValues <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testValues <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt")


##Name columns for merging
colnames(acts) <- c('activityId','activityType')

colnames(trainingValues) <- features[,2] 
colnames(testValues) <- features[,2] 
colnames(trainingActivity) <-"activityId"
colnames(testActivity) <- "activityId"
colnames(trainingSubjects) <- "subjectId"
colnames(testSubjects) <- "subjectId"

##Merge all previous tables together

fullTable<-rbind(cbind(trainingActivity,trainingValues,trainingSubjects),cbind(testActivity,testValues,testSubjects))


##get a list of columns with "mean" or "std" in their name

cols<- colnames(fullTable)
ms <-(grepl("activityId",cols) | grepl("subjectId",cols)| grepl("mean..",cols)| grepl("std..",cols))



##subset full table with list above and add activity ID

table_ms<-fullTable[,ms==TRUE]
table_ms_named <- merge(table_ms, acts,by='activityId',all.x=TRUE)


##Tidy data and order columns by Subject ID and Activity ID, then write the table
tidyData<-aggregate(. ~subjectId + activityId, table_ms_named, mean)
tidyData<-tidyData[order(tidyData$subjectId, tidyData$activityId),]

write.table(tidyData, "UCI HAR mean and std tidy.txt", row.name=FALSE)