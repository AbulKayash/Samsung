#########################################################################################
#Merges the training and the test sets to create one data set.  
#######################################################################################
if (!file.exists("Combined")) {
dir.create("Combined")        }

if (!file.exists("Combined/Inertial Signals")) {
  dir.create("Combined/Inertial Signals")      }


file.copy ("test/X_test.txt","Combined/X.txt",overwrite = T)
file.append("Combined/X.txt","train/X_train.txt")

file.copy ("test/y_test.txt","Combined/y.txt",overwrite = T)
file.append("Combined/y.txt","train/y_train.txt")


file.copy ("test/subject_test.txt","Combined/subject.txt",overwrite = T)
file.append("Combined/subject.txt","train/subject_train.txt")

dir.create("Combined/Inertial Signals")


##########################################################################################################


file.copy ("test/Inertial Signals/body_acc_x_test.txt","Combined/Inertial Signals/body_acc_x.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_acc_x.txt","train/Inertial Signals/body_acc_x_train.txt")

file.copy ("test/Inertial Signals/body_acc_y_test.txt","Combined/Inertial Signals/body_acc_y.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_acc_y.txt","train/Inertial Signals/body_acc_y_train.txt")

file.copy ("test/Inertial Signals/body_acc_z_test.txt","Combined/Inertial Signals/body_acc_z.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_acc_z.txt","train/Inertial Signals/body_acc_z_train.txt")

##########################################################################################################

file.copy ("test/Inertial Signals/body_gyro_x_test.txt","Combined/Inertial Signals/body_gyro_x.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_gyro_x.txt","train/Inertial Signals/body_gyro_x_train.txt")

file.copy ("test/Inertial Signals/body_gyro_y_test.txt","Combined/Inertial Signals/body_gyro_y.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_gyro_y.txt","train/Inertial Signals/body_gyro_y_train.txt")

file.copy ("test/Inertial Signals/body_gyro_z_test.txt","Combined/Inertial Signals/body_gyro_z.txt",overwrite = T)
file.append("Combined/Inertial Signals/body_gyro_z.txt","train/Inertial Signals/body_gyro_z_train.txt")

##############################################################################################################
file.copy ("test/Inertial Signals/total_acc_x_test.txt","Combined/Inertial Signals/total_acc_x.txt",overwrite = T)
file.append("Combined/Inertial Signals/total_acc_x.txt","train/Inertial Signals/total_acc_x_train.txt")

file.copy ("test/Inertial Signals/total_acc_y_test.txt","Combined/Inertial Signals/total_acc_y.txt",overwrite = T)
file.append("Combined/Inertial Signals/total_acc_y.txt","train/Inertial Signals/total_acc_y_train.txt")

file.copy ("test/Inertial Signals/total_acc_z_test.txt","Combined/Inertial Signals/total_acc_z.txt",overwrite = T)
file.append("Combined/Inertial Signals/total_acc_z.txt","train/Inertial Signals/total_acc_z_train.txt")

################################################################################
# 2. Extract only measurements on the mean
############################################################################################
library(data.table)


X <- read.table("Combined/X.txt")
cols <- read.table("features.txt")
names(X) <- cols$V2
x <- data.table(X)


ms <- X[,c(grep("mean",cols$V2) ,grep("std",cols$V2))]  ## mean and std cols


#################################################################################
# 3. name activity
##################################################################################

y <- read.table("Combined/y.txt")
y_labled <- read.table("activity_labels.txt")
ylab <- data.table(y_labled)
setkey (ylab, V1)

y <- data.table(y)
setkey(y, V1)
merge(ylab,y)
activity_name <- merge(ylab,y)
ms$activity <- activity_name$V2

#################################################################################
# 4. Appropriately labels the data set with descriptive variable names
##################################################################################  

colnames(ms)<-gsub("\\(\\)","",colnames(ms))
colnames(ms)<-gsub("-","_",colnames(ms))

####################################################################################
# 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
####################################################################################
subject <- read.table("Combined/subject.txt")
ms$subject <- subject$V1

agg<-aggregate(. ~subject+activity, ms, mean)

write.table(agg, file='tidy.txt', row.name=FALSE) 



