# Downloading dataset

if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/UCIData.zip")

# Unzipping dataset

unzip(zipfile="./data/UCIData.zip", exdir="./data")

# Reading training data

xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing data

xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature data

features <- read.table("./data/UCI HAR Dataset/features.txt")

# Reading activity labels

activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# Assigning column names
  
colnames(xtrain) <- features[,2] 
colnames(ytrain) <-"activityId"
colnames(subjecttrain) <- "subjectId"

colnames(xtest) <- features[,2] 
colnames(ytest) <- "activityId"
colnames(subjecttest) <- "subjectId"

colnames(activitylabels) <- c("activityId","activityType")

# Merging all data into one data frame
  
totaltrain <- cbind(ytrain, subjecttrain, xtrain)
totaltest <- cbind(ytest, subjecttest, xtest)
fulldata <- rbind(totaltrain, totaltest)

# Extracting only mean and standard deviation for each measurement by creating a vector identifying the required data
# and then subsetting that out from the full data
  
colNames <- colnames(fulldata)
  
mean_and_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) )
  
data_mean_std <- fulldata[ , mean_and_std == TRUE]

# Using descriptive activity names

data_activitynames <- merge(data_mean_std, activitylabels,
                                by="activityId",
                                all.x=TRUE)
  
# Making a new tidy data frame with the mean of each variable for each subject and for each activity

data_subsetted <- aggregate(. ~subjectId + activityId, data_activitynames, mean)
data_subsetted <- data_subsetted[order(data_subsetted$subjectId, data_subsetted$activityId),]

# Cleaning up the column names

names(data_subsetted) <- gsub("^t", "time", names(data_subsetted))
names(data_subsetted) <- gsub("^f", "frequency", names(data_subsetted))
names(data_subsetted) <- gsub("Acc", "Accelerometer", names(data_subsetted))
names(data_subsetted) <- gsub("Gyro", "Gyroscope", names(data_subsetted))
names(data_subsetted) <- gsub("Mag", "Magnitude", names(data_subsetted))
names(data_subsetted) <- gsub("BodyBody", "Body", names(data_subsetted))

# Writing the tidy dataset to a txt file

write.table(data_subsetted, "tidy_dataset.txt", row.name=FALSE)