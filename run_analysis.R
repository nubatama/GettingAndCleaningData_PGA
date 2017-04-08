loadLibraries <- function() {
    # Load necessary libraries
    library(dplyr)
    library(readr)
}

loadFeatureList <- function(dataFolder) {
    # Get feature list from features.txt
    
    # Load features.txt
    feature_df <- read_table2(file = paste0(dataFolder,"/features.txt"),
                              col_names = c("id", "name"))
    feature_df <- tbl_df(feature_df)
    
    # Get feature list
    feature_list <- feature_df[["name"]]
    
    # Remove feature_df
    remove(feature_df)
    
    return(feature_list)
}

loadActivityList <- function(dataFolder) {
    # Get feature list from features.txt
    
    # Load features.txt
    activity_df <- read_table2(file = paste0(dataFolder,"/activity_labels.txt"),
                              col_names = c("activity_id", "Activity"))
    activity_df <- tbl_df(activity_df)
    
    return(activity_df)
}

loadTrainData <- function(dataFolder, feature_list, activity_df) {
    # read train/X_train.txt
    X_train_df <- read_table2(file = paste0(dataFolder,"/train/X_train.txt"),
                              col_names = feature_list)
    X_train_df <- tbl_df(X_train_df)
    
    # select necessary columns
    X_train_df <- select(X_train_df, c(contains("mean()"), contains("std()")))
    
    # read train/Y_train.txt
    Y_train_df <- read_table2(file = paste0(dataFolder,"/train/Y_train.txt"),
                              col_names = "activity_id")
    Y_train_df <- tbl_df(Y_train_df)
    
    # merge X and Y
    train_df <- bind_cols(X_train_df, Y_train_df)

    # remove X and Y
    remove(X_train_df, Y_train_df)
    
    # merge activity
    train_df <- inner_join(train_df, activity_df, by = "activity_id")
    
    # remove activity
    train_df <- select(train_df, -matches("activity_id"))
    
    return(train_df)
}

loadTestData <- function(dataFolder, feature_list, activity_df) {
    # read test/X_test.txt
    X_test_df <- read_table2(file = paste0(dataFolder, "/test/X_test.txt"),
                             col_names = feature_list)
    X_test_df <- tbl_df(X_test_df)
    X_test_df
    
    # select necessary columns
    X_test_df <- select(X_test_df, c(contains("mean()"), contains("std()")))
    
    # read test/Y_test.txt
    Y_test_df <- read_table2(file = paste0(dataFolder, "/test/Y_test.txt"),
                             col_names = "activity_id")
    Y_test_df <- tbl_df(Y_test_df)
    Y_test_df
    
    # merge X and Y
    test_df <- bind_cols(X_test_df, Y_test_df)
    
    # remove X and Y
    remove(X_test_df, Y_test_df)

    # merge activity
    test_df <- inner_join(test_df, activity_df, by = "activity_id")
    
    # remove activity
    test_df <- select(test_df, -matches("activity_id"))
    
    return(test_df)
}

mergeData <- function(trainDf, testDf) {
    whole_df <- bind_rows(trainDf, testDf)
    return(whole_df)
}

summariseData <- function(whole_df) {
    activities <- group_by(whole_df, Activity)
    summary_df <- summarise_each(activities, funs(mean))
}

run_analysis <- function(dataFolder) {
    # Load libraries
    loadLibraries()
    
    # Load features
    featureList <- loadFeatureList(dataFolder)
    
    # Load activity
    activityDf <- loadActivityList(dataFolder)

    # Load training data
    trainingDf <- loadTrainData(dataFolder, featureList, activityDf)

    # Load test data
    testDf <- loadTestData(dataFolder, featureList, activityDf)
    
    # merge training data and test data
    wholeDf <- mergeData(trainingDf, testDf)
    
    # summarise data
    summariseDf <- summariseData(wholeDf)
    
    # store summarised dataset
    write.table(summariseDf, "summarisedDataset.txt", row.names = FALSE)
}