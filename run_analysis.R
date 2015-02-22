
## Install critical package
#install.packages("dplyr")
#library(dplyr)

# set working directory to the location of UCI HAR Dataset

setwd('/Users/Owner/Desktop/CourseraX/UCI HAR Dataset/');

## where y = activity ; x = subject; z = features

# Begin by importing all data rows in both files

# Read the y data rows for test
ytest <- read.table("./test/y_test.txt", header=F)

# Read the y data rows for train
ytrain <- read.table("./train/y_train.txt", header=F)

# Concatenate test and train activity data together
activity <- rbind(ytest, ytrain)

# Create a column name for activity using unique identifier 
colnames(activity) <- c("activityid")

# Read the x data rows for test
stest <- read.table("./test/subject_test.txt", header=F)

# Read the subject rows for train
strain <- read.table("./train/subject_train.txt", header=F)

# Add the test and train data together
subject <- rbind(stest, strain)

# Create a column name for subject
colnames(subject) <- c("subject")

# Read the featurelabels for the columns of the test and train data
featurelabels <- read.table("features.txt", header=F, sep=" ")

# Create column names for featurelabels
colnames(featurelabels) <- c("featurenr", "featurename")

# Read the x-test feature data
featurestest <- read.table("./test/x_test.txt", header=F)

# Read the x-train feature data
featurestrain <- read.table("./train/x_train.txt", header=F)

# Concatenate test and train feature data together
features <- rbind(featurestest, featurestrain)

# Create column names for the featurelabels
# Ensure that the column names are unique, otherwise we'll encounter errors later when merging
colnames(features) <- make.names(featurelabels$featurename, unique=T)

# add the activity, subject feature data together
mergedata<-cbind(activity, subject, features)


#Q2. For each measurement extract only mean and SD

# Create a new table containing only columns with subjects, activityid, mean and std
datameanstd <- select(mergedata,matches("subject|activityid|mean|std"))

#Q3. Name the activities in the dataset using descriptive activity names

# Read the activities labels
activitylabels<-read.table("activity_labels.txt", header=F, sep=" ")

# Create column names for activity labels
colnames(activitylabels)<- c("activityid","activity")

# Add the activity label to the dataset using a merge on activityid
data <- merge(x=datameanstd, y=activitylabels, by="activityid")

# Exclude the activityid field
data <- select(data, -activityid)

# Reorder the columns so that the dataset starts with subject and activity
data<-select(data, subject, activity, 2:87)


#Q4. Appropriately labels the dataset with descriptive variable names

# Get the column names and make them unique
colnames <-colnames(data)
colnames <- make.names(colnames, unique=TRUE)

#Cleanup the variable names by replacing characters
colnamesclean <- gsub("-", " ", colnames) #Replace - with a space
colnamesclean <- gsub("\\.", " ", colnamesclean) #Replace . with a space
colnamesclean <- gsub("\\  ", " ", colnamesclean) #Replace . with a space
colnamesclean <- gsub("\\  ", " ", colnamesclean) #Replace . with a space
colnamesclean <- gsub("\\  ", " ", colnamesclean) #Replace . with a space
colnamesclean <- gsub("tBody", "Body", colnamesclean) #Remove the t
colnamesclean <- gsub("tGravity", "Gravity", colnamesclean) #Remove the t
colnamesclean <- gsub("fBody", "Body", colnamesclean) #Remove the f
colnamesclean <- gsub("BodyBody", "Body", colnamesclean) #Remove double Body
colnamesclean <- gsub("^\\s+|\\s+$", "", colnamesclean) #Strip leading and trailing spaces

# Recreate the column names for the dataset
colnames(data) <- colnamesclean

#Q5 Create secondary indepedent tidy date with mean of each variable
# for each activity and each subject

# Create a dataframe table (Dplyr)
tidy <- tbl_df(data)

# Create unique column names, otherwise the summary will give errors
colnames(tidy) <- make.names(colnames(tidy) , unique=TRUE)

# Group the data by subject and activity
tidygp <- group_by(tidy, subject, activity)

# Calculate the mean for all features using a Dplyr function
tidymean <- summarise_each(tidygp, funs(mean))

# Reapply the clean column names
colnames(tidymean) <- colnamesclean

# Create tidy dataset from step 5
write.table(tidymean, file="ProfCubetidy.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=TRUE)

