This script requires the following libraries (and loading of that is included in the script itself),
1. stringr
2. dplyr

1. Data to be obtained are the measurement of variables obtained when 30 volunteers performed 6 different activities.
2. As time and frequency domain variables are required only those datasets are read from X_test and X_train text files.
3. The mapping between the reading and the subject is obtained by reading the Subject text files.
4. The mapping between the reading and the id of the activity performed to obtain that is obtained by reading Y text files.
5. Then mapping between the activity id and their labels are obtained by reading activity labels text.
6. Extracted the variables which represents the mean and SD.
7. Grouped the data by Activity and subject as the requirement was to get  independent tidy data set with the average of each variable for each activity and each subject.

"SubjectID" was given as the column name for column denoting the id of subject
"Activity_Labels" was given as the column name for column denoting the activity performed
Modified the column names representing variables with the following,
a. Replaced " t" with "Time"
b. Repalced " f" with "Freq"
c. Replaced "BodyAcc" with "BodyAcceleration"
d. Replaced "GravityAcc" with "GravityAcceleration"
e. Replaced "mean" with "Mean"
f.  Replaced "std" with "Std"
g. Replaced "Mag" with "Magnitude"
h. Replaced "BodyBody" with "Body"