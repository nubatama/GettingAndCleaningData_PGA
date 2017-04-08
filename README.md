# GettingAndCleaningData_PGA
Peer-graded Assignment: Getting and Cleaning Data Course Project /  Data Science specialized course 3

Function List:
* loadLibraries
* loadFeatureList
* loadActivityList
* loadTrainData
* loadTestData
* mergeData
* summariseData
* run_analysis

### loadLibraries
This function load libraies that need in this script.
This function is called from "run_analysis" function.

### loadFeatureList
This function load "features.txt" file and return feature list to caller funtion.
This function is called from "run_analysis" function.

### loadActivityList
This function load "activity_labels.txt" file and return data frame to caller funtion.
This function create data frame that have two variables, "activity_id" and "Activity".
This function is called from "run_analysis" function.

### loadTrainData
First, this function load two files, "X_train.txt" and "Y_train.txt", and bind row by row.
When loading  "X_train.txt", this function use feature list created by "loadFeatureList" function.
Second, this function select variables that have "mean()" or "std()".
Third, this function join train data and activity data by activity id. 

### loadTestData
This function work similar "loadTrainData". The deference is handled file, this file handle two files, "X_test.txt" and "Y_test.txt".
This function is called from "run_analysis" function.

### mergeData
This function merge train data and test data, that created two functions, "loadTrainData" and "loadTestData".

### summariseData
This function create summarised data frame. 
First, this function create grouping data, group by activity variable.
Second, this function create summarise data.

### run_analysis
This function is main function of this script.
This function call above functions by following sequence.

1. loadLibraries()
2. loadFeatureList()
3. loadActivityList()
4. loadTrainData()
5. loadTestData()
6. mergeData()
7. summariseData()
