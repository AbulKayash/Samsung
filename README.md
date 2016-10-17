# Samsung
The script assums that the test set and the training set is in the same directory.
1. Creates a directory names "combined" and merges all the data files in test and training and stores in them in the combined directory.
2. Extract only the mean and std colums to table named:ms
3. Append activity names to the ms table
4. Tidy the column names of ms table by removing  chars:(,),-
5. creates a second, independent tidy data set with the average of each variable for each activity and each subject. Then write the data set to a file named:tidy.txt
