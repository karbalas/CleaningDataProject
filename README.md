##CleaningDataProject

### How to run and what to expect from this project

List of script files:
---------------------
run_analysis.R

List of functions in the script file:
-------------------------------------
1) setWorkDir() : This function sets the working directory in R session for this project. (dir set to d:/CleanData/proj1 in windows)

2) getExtractDataFile(): This function downloads and / or unzips the data file for this project IF the extracted data files do not exists in the working directory. Due to the size of the download file and file servers download speed, it is very slow. DO download the data zip file and place it in the working directory set in this script to speed up the processing.

3) getMeanAndStdMeasurementColumns(): This function loads the features.txt file provided as part of the data files. Shortlists the column names and indexes for those columns that has one of the following patterns in the column names (case insensitive): 

"-mean()", 
"-std()" or 
"-meanFreq()"

4) loadMeanStdMeasurementData(): This function loads the provided set of columns from the given data file. For this project, the list of columns are mean and standard deviation measurements data.

5) loadData(): This function simply loads the data from the given data file. This function is mainly used to load the X, y and subject data files for test and training related tests.

6) generateCodebook(): This function generates a code book based on the provided set of tidy column names and description information for the columns, if the code book file doesn't exist in the working directory.

7) getTidyColumnData(): This function generates tidy column names and an apt description for the column based on the provided untidy column names.

8) createDatasetWithAverages(): This function generates a dataset with calculated averages for each measurements based on the activities and subject information that is part of the given dataset.

9) run_analysis(): This is the main function that will put all the other functions together to do the following actions:
step 1) Merges the training and the test sets to create one data set.
step 2) Extracts only the measurements on the mean and standard deviation for each measurement.
step 3) Uses descriptive activity names to name the activities in the dataset.
step 4) Appropriately labels the data set with descriptive variable names.
step 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
step 6) returns a list containing the two data sets generated from steps 1:4 and step 5


Other relevant files:
---------------------

1) run_analysis.R - The R script file as explained above
2) codebook.md    - This file contains the information about the column names and a description for each column in the datasets generated using the run_analysis.R script for the analyzer to get up to speed.
3) README.md      - This file.
