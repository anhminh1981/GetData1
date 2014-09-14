features <- read.table('UCI HAR Dataset/features.txt')
features$V2 <- gsub("-", "_", features$V2)
features$V2 <- gsub("[\\(\\)]", "", features$V2)


cols <- grep('.*(mean|std)(_.)?$', features$V2, value=TRUE)

subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names='subject_id')
data_test <- cbind(subject_test, 
                   read.table('UCI HAR Dataset/test/X_test.txt', col.names=features[,2]),
                   read.table('UCI HAR Dataset/test/y_test.txt', col.names="activity"))

data_test <- data_test[, c("subject_id", cols, "activity")]

subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names='subject_id')
data_train <- cbind(subject_train, 
                   read.table('UCI HAR Dataset/train/X_train.txt', col.names=features[,2]),
                   read.table('UCI HAR Dataset/train/y_train.txt', col.names="activity"))

data_train <- data_train[, c("subject_id", cols, "activity")]

data <- rbind(data_test, data_train)

activities <- read.table('UCI HAR Dataset/activity_labels.txt')

data$activity <- factor(data$activity, labels = activities$V2)

tidy_data <- aggregate(data[, cols], 
                       by = list(subject_id = data$subject_id, activity = data$activity), 
                       FUN="mean")

write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)