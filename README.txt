Step 0: Download the dataset and unzip it in the working directory. Load every table in the session with "read.table()" command.
Step 1: Merges the training and the test sets to create one data set. Uses rbind for binding tables by the rows, and later cbind for binding tables by their clumns.
Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. Uses dplyr for selecting the first two columns and inspect and select only the columns with "mean" or "std" in them.
Step 3: Uses descriptive activity names to name the activities in the data set. Assign labels from the "Activity_labels" table.
Step 4: Appropriately labels the data set with descriptive variable names. Substitutes the suffix "mean" or "std" for the intended labels.
Step 4: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.. Uses dplyr for cereating this new data set, and "write.table()" for creating a .txt object.
