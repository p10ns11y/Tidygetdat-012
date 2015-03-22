# run_analysis.R 

library(reshape2)
# 1. Merging the training and the data sets 

#files <- list.files("train") # test folder also has same str
#reqfiles <- files[2:4] # ignoring Inertial Signals to save memory/operations

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject <- merge(subject_train,subject_test,all=TRUE)

X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
X <- merge(X_train,X_test,all=TRUE) # has 561 feature vectors

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
y <- rbind(y_train,y_test) # yet to have col name activity

# hardata <- cbind(subject, y, X) - will combine later 

# 2. Extracting only the measurements on the mean 
# and standard deviation for each measurement
fts <- read.table("features.txt")
extmeanstd <- grep("-mean\\(|-std\\(",fts[,2])
X <- X[, extmeanstd] # meanFreq() alikes !!!

# 3. Using descriptive activity names to name the activities in the data set

actlables <- read.table("activity_labels.txt")
actlables[, 2] = gsub("_", "", tolower(as.character(actlables[, 2])))
y[,1] = actlables[y[,1], 2]


# 4 . Appropriately labeling the data set with descriptive variable names
names(subject) <- "subject"
names(y) <- "activity"
xnames <- fts[extmeanstd, 2]
names(X) <- gsub("\\(|\\)", "", tolower(xnames))

mergedData <- cbind(subject,y,X)

# 5. From the data set in step 4, creating a second, independent tidy data set 
# with the average of each variable for each activity and each subject

meltData <- melt(tidydata, id=c("subject","activity")) # all vars default
tidySensorData <- dcast(meltData, subject + activity ~ variable, mean)

write.table(tidySensorData, "tidy_acc_sensor_data.txt", row.name=FALSE)