require(data.table)
require(plyr)
require(reshape2)

##
## These are the constant variables used globally in this script
##
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dataFile <- ".//getdata-projectfiles-UCI HAR Dataset.zip"
codebook <- ".//codebook.md"
featuresFile <- ".//UCI HAR Dataset//features.txt"
activityLabelFile <- ".//UCI HAR Dataset//activity_labels.txt"

testXFile <- ".//UCI HAR Dataset//test//X_test.txt"
testYFile <- ".//UCI HAR Dataset//test//y_test.txt"
testSubjectFile <- ".//UCI HAR Dataset//test//subject_test.txt"

trainXFile <- ".//UCI HAR Dataset//train//X_train.txt"
trainYFile <- ".//UCI HAR Dataset//train//y_train.txt"
trainSubjectFile <- ".//UCI HAR Dataset//train//subject_train.txt"
## End of global variables for this script

### This function sets the working directory
### to d:/CleanData/proj1 and creates 
### any / all missing directories in it's path
setWorkDir <- function() {
  if (!file.exists("d:/CleanData/proj1")) {
    if (!file.exists("d:/CleanData")) {
      dir.create("d:/CleanData")
    }
    dir.create("d:/CleanData/proj1")
  }
  
  setwd("d:/CleanData/proj1")
}

### This function downloads the data zip file
### and unzips the downloaded zip file
### Do not execute this function UNLESS you do not
### have the downloaded zip file already. VERY SLOW
getExtractDataFile <- function () {
  if (!file.exists(dataFile)) {
    download.file(fileUrl, destfile = dataFile)
  }
  unzip(dataFile)
}

## This function returns a function that can identify 
## the columns that are either mean, std or meanFreq 
## based on the col name (features)
shortlistCols <- function () {
  ## This function identifies if the given value has
  ## mean, std or meanFreq in the col name (features)
  c <- function(x){
    splt <- unlist(strsplit(x,split="-",fixed=TRUE))
    if (length(splt) < 2) {
      FALSE
    } else {
      val <- tolower((strsplit(splt[2],split="()",fixed=TRUE))[[1]])
      if (val == "mean" || val == "std" || val == "meanfreq") {
      #if (val == "mean" || val == "std") {
        TRUE
      } else {
        FALSE
      }
    }
  }
  c
}

getMeanAndStdMeasurementColumns <- function(colNms) {
  ## colNms dataset has 2 cols, 1st is index and 2nd label
  ## identify the col names that are either mean or std of 
  ## some value from the label names.
  ## colToExt is now a logical vector of select cols 
  colToExt <- unlist(lapply(colNms$V2, shortlistCols()))
  colToExt
}

## instead of reading the file contents using the read.table or any variations of it
## which is slower, read the lines from file connection, manipulate separtor character
## and use fread to load the data for only the required mean and std measurement data
## This is way more faster to load the entire data than the other routes
loadMeanStdMeasurementData <- function(filename, columnNames, selectColumns) {
  ##open the file connections
  rcon <- file(filename)
  wcon <- file(paste0(filename,"1"))
  
  ##read the original data file as is
  dat1 <- readLines(con = rcon)
  
  ##remove the whitespaces at the start of each line
  dat1 <- gsub("^\\s\\s", "", dat1)
  
  ##replace all double spaces and single space characters with 1 comma separator
  dat1 <- gsub("  ", ",", dat1)
  dat1 <- gsub(" ", ",", dat1)
  
  ##write this into a temp file for further processing
  writeLines(dat1, con = wcon, sep = "\n")
  
  ## close the file connections
  close(rcon)
  close(wcon)
  
  ##load the data table using fread and selecting only the 
  ##required mean and standard deviation measurements data
  data <- fread(paste0(filename,"1"), 
                header = FALSE, 
                select=columnNames$V1[selectColumns],
                sep=",",
                stringsAsFactors = FALSE)
  ## set the column names correctly
  try(suppressWarnings(names(data) <- columnNames$V2[selectColumns]),TRUE)
  ##return the mean and std measurement data
  data
}

##Simple fread to load the subject and activity data
loadData <- function(filename) {
  data <- fread(filename, 
                header = FALSE, 
                stringsAsFactors = FALSE)
  ##return the read data
  data
}

##This function automatically generates the codebook that is attached
##for this project
generateCodebook <- function(tidyColData) {
  ##open the file connections
  wcon <- file(codebook)
  
  myLines <- c("##Code Book for the Dataset column names and descriptions\n")
  myLines <- c(myLines,
               "\tThis code book provides detailed information about the various steps involved in manipulating the test and training set data",
               "to get to the final resulting output from running the run_analysis.R script. This code book also lists the variable names,",
               "data types, data values that is contained in the resulting data set from run_analysis.R script.\n\n",
               "###Variable Names / Data Types / Possible values:\n",
               "\tSubject:",
               "\t\tnumeric, values between 1 and 30, unique identifier for each participant.\n",
               "\tActivity:",
               "\t\tcharacter, values include one of the activities for which measurement was taken:",
               "\t\t\t(LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)\n",
               "\tALL other variables:",
               "\t\tnumeric, values are either mean or standard deviation of each activity measured.\n\n",
               "###Processing or Data Manipulation steps:\n",
               "\tLoading:",
               "\t\tOnly mean and standard deviation related data was loaded from the given data set.\n",
               "\tMerging:",
               "\t\tTest and training set related data for mean and standard deviation of measurements were merged into a single data set.\n",
               "\tTransformations:",
               "\t\tAvtivityId numeric values from original data set was transformed to reflect the activity names instead.\n",
               "\tLabels:",
               "\t\tThe column name / labels were tidied up to be more meaningful and valid as per naming conventions.\n",
               "\tMutated:",
               "\t\tMerged data set was mutated and transformed to summarize average of each of the mean and standard deviation measurements based on each Subject and each Activity.\n",
               "\tResulting data set:",
               "\t\tAfter performing the above list of data manipulations, a list containing both the merged data set and summarized data set is returned.\n\n"
               )
  myLines <- c(myLines,
               "###Variable Names / Labels:")
  
  myLines <- c(myLines,
               paste(paste0("\n\t",
                            tidyColData$Names),
                     tidyColData$Descriptions, 
                     sep=":\n\t\t"))
  
  ##write this into a code book file for future use by others
  writeLines(myLines, con = wcon, sep = "\n")
  
  ## close the file connections
  close(wcon)
}

##This function modifies the column names using the use proper conventions
##This function returns a data frame with tidied up column names as 1st column
##and each columns description that goes in the code book as 2nd column
getTidyColumnData <- function(untidyColNames) {
  ##remove the whitespaces at the start of each line
  tidyColNames <- gsub("\\(\\)", "", untidyColNames, ignore.case = TRUE)

  tidyColNames <- gsub("^t", "time", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("^f", "frequency", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("Acc", "Acceleration", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("Gyro", "Gyroscope", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("Mag", "Magnitude", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("std", "StandardDeviation", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("-mean", "-Mean", tidyColNames, ignore.case = TRUE)
  tidyColNames <- gsub("meanFreq", "Mean_Frequency", tidyColNames, ignore.case = TRUE)
  
  tidyDescription <- gsub("time", "time domain signals of ", tidyColNames, ignore.case = TRUE)
  tidyDescription <- gsub("^frequency", "frequency domain signals of ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("bodybody", "body", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("bodyacce", "body linear acce", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("acceleration", "acceleration ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("bodyGyroscope", "body angular velocity ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("gravity", "gravity ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("jerk", "jerk ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("magnitude", "magnitude ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("-xyz", " on all the 3 axis ", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("-x", " on the X axis", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("-y", " on the Y axis", tidyDescription, ignore.case = TRUE)
  tidyDescription <- gsub("-z", " on the Z axis", tidyDescription, ignore.case = TRUE)
  
  logIndex <- grepl(" -Mean_Frequency",tidyDescription)
  tidyDescription <- gsub(" -Mean_Frequency", "", tidyDescription, ignore.case = TRUE)
  tidyDescription[logIndex] <- gsub("^", "Weighted average of the frequency components on ", tidyDescription[logIndex], ignore.case = TRUE)

  logIndex <- grepl(" -Mean",tidyDescription)
  tidyDescription <- gsub(" -Mean", "", tidyDescription, ignore.case = TRUE)
  tidyDescription[logIndex] <- gsub("^", "Mean of ", tidyDescription[logIndex], ignore.case = TRUE)
  
  logIndex <- grepl(" -StandardDeviation",tidyDescription)
  tidyDescription <- gsub(" -StandardDeviation", "", tidyDescription, ignore.case = TRUE)
  tidyDescription[logIndex] <- gsub("^", "Standard deviation of ", tidyDescription[logIndex], ignore.case = TRUE)
  
  dataReturn <- data.frame(Names=tidyColNames, Descriptions=tidyDescription)
  names(dataReturn) <- c("Names","Descriptions")
  dataReturn
}

## This method works on mergedData to create the second dataset that 
## contains the average of each measurement on Subject and Activity
createDatasetWithAverages <- function(myData) {
  aggregateColumnNames <- names(myData)
  aggregateColumnNames <- aggregateColumnNames[1:(length(aggregateColumnNames)-2)]
  
  meltData <- melt(myData,
                   id=c("Subject","ActivityId"),
                   measure.vars=aggregateColumnNames)
  
  sdata<-dcast(meltData,Subject+ActivityId~variable,mean,na.rm=TRUE)
  sdata
}

##This is the core function that is called to process the entire 
##project requirements.
run_analysis <- function() {
  ## set the working directory
  ## NOTE: if you are testing this code, ensure that working dir is set to parent dir of 
  ## location where the data file is extracted from zip file already.
  ## otherwise, it will download the entire zip file and then extract it before proceeding.
  ## which might cause this to run for a very very long time.
  setWorkDir()
  
  ## comment this line if the getwd() has the extracted data file contents.
  if (!file.exists(testXFile)) {
    ## download and extract the data file
    getExtractDataFile()
  }
  
  ## read the list of column names and column index information 
  ## from the provided features.txt file
  featureColumns <- fread(featuresFile)
  
  ## identify and pick only the mean and standard deviation specific 
  ## measurement data column information like index and column names
  meanAndStdColumns <- getMeanAndStdMeasurementColumns(featureColumns)
  
  ##Before doing step3, ensure that the subject and activity are part of the dataset 
  ##as well, so that the activities can be tracked by each subject 
  
  ## load the test data for the mean and std measurements
  testX <- loadMeanStdMeasurementData (testXFile, featureColumns, meanAndStdColumns)
  
  ## load and append the activity data to test data
  testY <- loadData(testYFile)
  testX$ActivityId <- testY
  testY <- NULL
  
  ## load and append the subject data to test data
  testSubject <- loadData(testSubjectFile)
  testX$Subject <- testSubject
  testSubject <- NULL
  
  ## load the train data for the mean and std measurements
  trainX <- loadMeanStdMeasurementData (trainXFile, featureColumns, meanAndStdColumns)
  
  ## load and append the activity data to train data
  trainY <- loadData(trainYFile)
  trainX$ActivityId <- trainY
  trainY <- NULL
  
  ## load and append the subject data to train data
  trainSubject <- loadData(trainSubjectFile)
  trainX$Subject <- trainSubject
  trainSubject <- NULL
  
  ##steps 1 and 2
  mergedData <- rbind(testX,trainX)
  testX <- NULL
  trainX <- NULL
  ##NOW we have the data for steps 1 and 2
  
  ## step 5 can be done here before the column names are tidied up
  tempData <- createDatasetWithAverages(mergedData)
#  tempData <- tempData[order(tempData$Subject,tempData$ActivityId),]
  mergedSecondDataWithAverages <- tempData
  
  ## load and append the subject data to train data
  activityLabels <- loadData(activityLabelFile)
  try(suppressWarnings(names(activityLabels) <- c("ActivityId","Activity")),FALSE)
  
  ## step 3
  mergedData <- merge(mergedData,activityLabels,by="ActivityId",allow.cartesian=TRUE,suffixes=c("",""),all=TRUE)
  mergedSecondDataWithAverages <- merge(mergedSecondDataWithAverages,activityLabels,by="ActivityId",allow.cartesian=TRUE,suffixes=c("",""),all=TRUE)
  activityLabels <- NULL
  try(suppressWarnings(mergedData$ActivityId <- NULL),
      FALSE)
  try(suppressWarnings(mergedSecondDataWithAverages$ActivityId <- NULL),
      FALSE)
  ##NOW we have the data for step 3
  
  ## step 4, tidying up the column names other than subject and activity
  tidyColumnData <- getTidyColumnData(names(mergedSecondDataWithAverages))
  
  ##print(tidyColumnData$Names)
  ## set the tidy column names for the 2 data sets
  try(suppressWarnings(names(mergedData) <- tidyColumnData$Names),TRUE)
  try(suppressWarnings(names(mergedSecondDataWithAverages) <- tidyColumnData$Names),TRUE)

  ##NOW we have both step4 and step5 completed. 
  ##tidy data set mergedData for step 4
  ##tidy data set mergedSecondDataWithAverages for step 5
  
  if(!file.exists(codebook)) {
    generateCodebook(tidyColumnData)
  }
  
  ##Returns the second tidy data set that has the calculated averages
  ##Data set is ordered 
  mergedSecondDataWithAverages <- mergedSecondDataWithAverages[order(mergedSecondDataWithAverages$Subject,mergedSecondDataWithAverages$Activity),]
  #list(mergedSecondDataWithAverages,tempData)
  try(suppressWarnings(row.names(mergedSecondDataWithAverages) <- NULL),TRUE)
  mergedSecondDataWithAverages
}

outcome <- run_analysis()
# z<-system.time(n<-run_analysis())
# z
