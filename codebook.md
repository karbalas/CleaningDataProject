##Code Book for the Dataset column names and descriptions

	This code book provides detailed information about the various steps involved in manipulating the test and training set data
to get to the final resulting output from running the run_analysis.R script. This code book also lists the variable names,
data types, data values that is contained in the resulting data set from run_analysis.R script.


###Variable Names / Data Types / Possible values:

	Subject:
		numeric, values between 1 and 30, unique identifier for each participant.

	Activity:
		character, values include one of the activities for which measurement was taken:
			(LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)

	ALL other variables:
		numeric, values are either mean or standard deviation of each activity measured.


###Processing or Data Manipulation steps:

	Loading:
		Only mean and standard deviation related data was loaded from the given data set.

	Merging:
		Test and training set related data for mean and standard deviation of measurements were merged into a single data set.

	Transformations:
		AvtivityId numeric values from original data set was transformed to reflect the activity names instead.

	Labels:
		The column name / labels were tidied up to be more meaningful and valid as per naming conventions.

	Mutated:
		Merged data set was mutated and transformed to summarize average of each of the mean and standard deviation measurements based on each Subject and each Activity.

	Resulting data set:
		After performing the above list of data manipulations, a list containing both the merged data set and summarized data set is returned.


###Variable Names / Labels:

	Subject:
		Subject

	timeBodyAcceleration-Mean-X:
		Mean of time domain signals of body linear acceleration on the X axis

	timeBodyAcceleration-Mean-Y:
		Mean of time domain signals of body linear acceleration on the Y axis

	timeBodyAcceleration-Mean-Z:
		Mean of time domain signals of body linear acceleration on the Z axis

	timeBodyAcceleration-StandardDeviation-X:
		Standard deviation of time domain signals of body linear acceleration on the X axis

	timeBodyAcceleration-StandardDeviation-Y:
		Standard deviation of time domain signals of body linear acceleration on the Y axis

	timeBodyAcceleration-StandardDeviation-Z:
		Standard deviation of time domain signals of body linear acceleration on the Z axis

	timeGravityAcceleration-Mean-X:
		Mean of time domain signals of gravity acceleration on the X axis

	timeGravityAcceleration-Mean-Y:
		Mean of time domain signals of gravity acceleration on the Y axis

	timeGravityAcceleration-Mean-Z:
		Mean of time domain signals of gravity acceleration on the Z axis

	timeGravityAcceleration-StandardDeviation-X:
		Standard deviation of time domain signals of gravity acceleration on the X axis

	timeGravityAcceleration-StandardDeviation-Y:
		Standard deviation of time domain signals of gravity acceleration on the Y axis

	timeGravityAcceleration-StandardDeviation-Z:
		Standard deviation of time domain signals of gravity acceleration on the Z axis

	timeBodyAccelerationJerk-Mean-X:
		Mean of time domain signals of body linear acceleration jerk on the X axis

	timeBodyAccelerationJerk-Mean-Y:
		Mean of time domain signals of body linear acceleration jerk on the Y axis

	timeBodyAccelerationJerk-Mean-Z:
		Mean of time domain signals of body linear acceleration jerk on the Z axis

	timeBodyAccelerationJerk-StandardDeviation-X:
		Standard deviation of time domain signals of body linear acceleration jerk on the X axis

	timeBodyAccelerationJerk-StandardDeviation-Y:
		Standard deviation of time domain signals of body linear acceleration jerk on the Y axis

	timeBodyAccelerationJerk-StandardDeviation-Z:
		Standard deviation of time domain signals of body linear acceleration jerk on the Z axis

	timeBodyGyroscope-Mean-X:
		Mean of time domain signals of body angular velocity on the X axis

	timeBodyGyroscope-Mean-Y:
		Mean of time domain signals of body angular velocity on the Y axis

	timeBodyGyroscope-Mean-Z:
		Mean of time domain signals of body angular velocity on the Z axis

	timeBodyGyroscope-StandardDeviation-X:
		Standard deviation of time domain signals of body angular velocity on the X axis

	timeBodyGyroscope-StandardDeviation-Y:
		Standard deviation of time domain signals of body angular velocity on the Y axis

	timeBodyGyroscope-StandardDeviation-Z:
		Standard deviation of time domain signals of body angular velocity on the Z axis

	timeBodyGyroscopeJerk-Mean-X:
		Mean of time domain signals of body angular velocity jerk on the X axis

	timeBodyGyroscopeJerk-Mean-Y:
		Mean of time domain signals of body angular velocity jerk on the Y axis

	timeBodyGyroscopeJerk-Mean-Z:
		Mean of time domain signals of body angular velocity jerk on the Z axis

	timeBodyGyroscopeJerk-StandardDeviation-X:
		Standard deviation of time domain signals of body angular velocity jerk on the X axis

	timeBodyGyroscopeJerk-StandardDeviation-Y:
		Standard deviation of time domain signals of body angular velocity jerk on the Y axis

	timeBodyGyroscopeJerk-StandardDeviation-Z:
		Standard deviation of time domain signals of body angular velocity jerk on the Z axis

	timeBodyAccelerationMagnitude-Mean:
		Mean of time domain signals of body linear acceleration magnitude

	timeBodyAccelerationMagnitude-StandardDeviation:
		Standard deviation of time domain signals of body linear acceleration magnitude

	timeGravityAccelerationMagnitude-Mean:
		Mean of time domain signals of gravity acceleration magnitude

	timeGravityAccelerationMagnitude-StandardDeviation:
		Standard deviation of time domain signals of gravity acceleration magnitude

	timeBodyAccelerationJerkMagnitude-Mean:
		Mean of time domain signals of body linear acceleration jerk magnitude

	timeBodyAccelerationJerkMagnitude-StandardDeviation:
		Standard deviation of time domain signals of body linear acceleration jerk magnitude

	timeBodyGyroscopeMagnitude-Mean:
		Mean of time domain signals of body angular velocity magnitude

	timeBodyGyroscopeMagnitude-StandardDeviation:
		Standard deviation of time domain signals of body angular velocity magnitude

	timeBodyGyroscopeJerkMagnitude-Mean:
		Mean of time domain signals of body angular velocity jerk magnitude

	timeBodyGyroscopeJerkMagnitude-StandardDeviation:
		Standard deviation of time domain signals of body angular velocity jerk magnitude

	frequencyBodyAcceleration-Mean-X:
		Mean of frequency domain signals of body linear acceleration on the X axis

	frequencyBodyAcceleration-Mean-Y:
		Mean of frequency domain signals of body linear acceleration on the Y axis

	frequencyBodyAcceleration-Mean-Z:
		Mean of frequency domain signals of body linear acceleration on the Z axis

	frequencyBodyAcceleration-StandardDeviation-X:
		Standard deviation of frequency domain signals of body linear acceleration on the X axis

	frequencyBodyAcceleration-StandardDeviation-Y:
		Standard deviation of frequency domain signals of body linear acceleration on the Y axis

	frequencyBodyAcceleration-StandardDeviation-Z:
		Standard deviation of frequency domain signals of body linear acceleration on the Z axis

	frequencyBodyAcceleration-Mean_Frequency-X:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration on the X axis

	frequencyBodyAcceleration-Mean_Frequency-Y:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration on the Y axis

	frequencyBodyAcceleration-Mean_Frequency-Z:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration on the Z axis

	frequencyBodyAccelerationJerk-Mean-X:
		Mean of frequency domain signals of body linear acceleration jerk on the X axis

	frequencyBodyAccelerationJerk-Mean-Y:
		Mean of frequency domain signals of body linear acceleration jerk on the Y axis

	frequencyBodyAccelerationJerk-Mean-Z:
		Mean of frequency domain signals of body linear acceleration jerk on the Z axis

	frequencyBodyAccelerationJerk-StandardDeviation-X:
		Standard deviation of frequency domain signals of body linear acceleration jerk on the X axis

	frequencyBodyAccelerationJerk-StandardDeviation-Y:
		Standard deviation of frequency domain signals of body linear acceleration jerk on the Y axis

	frequencyBodyAccelerationJerk-StandardDeviation-Z:
		Standard deviation of frequency domain signals of body linear acceleration jerk on the Z axis

	frequencyBodyAccelerationJerk-Mean_Frequency-X:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration jerk on the X axis

	frequencyBodyAccelerationJerk-Mean_Frequency-Y:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration jerk on the Y axis

	frequencyBodyAccelerationJerk-Mean_Frequency-Z:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration jerk on the Z axis

	frequencyBodyGyroscope-Mean-X:
		Mean of frequency domain signals of body angular velocity on the X axis

	frequencyBodyGyroscope-Mean-Y:
		Mean of frequency domain signals of body angular velocity on the Y axis

	frequencyBodyGyroscope-Mean-Z:
		Mean of frequency domain signals of body angular velocity on the Z axis

	frequencyBodyGyroscope-StandardDeviation-X:
		Standard deviation of frequency domain signals of body angular velocity on the X axis

	frequencyBodyGyroscope-StandardDeviation-Y:
		Standard deviation of frequency domain signals of body angular velocity on the Y axis

	frequencyBodyGyroscope-StandardDeviation-Z:
		Standard deviation of frequency domain signals of body angular velocity on the Z axis

	frequencyBodyGyroscope-Mean_Frequency-X:
		Weighted average of the frequency components on frequency domain signals of body angular velocity on the X axis

	frequencyBodyGyroscope-Mean_Frequency-Y:
		Weighted average of the frequency components on frequency domain signals of body angular velocity on the Y axis

	frequencyBodyGyroscope-Mean_Frequency-Z:
		Weighted average of the frequency components on frequency domain signals of body angular velocity on the Z axis

	frequencyBodyAccelerationMagnitude-Mean:
		Mean of frequency domain signals of body linear acceleration magnitude

	frequencyBodyAccelerationMagnitude-StandardDeviation:
		Standard deviation of frequency domain signals of body linear acceleration magnitude

	frequencyBodyAccelerationMagnitude-Mean_Frequency:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration magnitude

	frequencyBodyBodyAccelerationJerkMagnitude-Mean:
		Mean of frequency domain signals of body linear acceleration jerk magnitude

	frequencyBodyBodyAccelerationJerkMagnitude-StandardDeviation:
		Standard deviation of frequency domain signals of body linear acceleration jerk magnitude

	frequencyBodyBodyAccelerationJerkMagnitude-Mean_Frequency:
		Weighted average of the frequency components on frequency domain signals of body linear acceleration jerk magnitude

	frequencyBodyBodyGyroscopeMagnitude-Mean:
		Mean of frequency domain signals of body angular velocity magnitude

	frequencyBodyBodyGyroscopeMagnitude-StandardDeviation:
		Standard deviation of frequency domain signals of body angular velocity magnitude

	frequencyBodyBodyGyroscopeMagnitude-Mean_Frequency:
		Weighted average of the frequency components on frequency domain signals of body angular velocity magnitude

	frequencyBodyBodyGyroscopeJerkMagnitude-Mean:
		Mean of frequency domain signals of body angular velocity jerk magnitude

	frequencyBodyBodyGyroscopeJerkMagnitude-StandardDeviation:
		Standard deviation of frequency domain signals of body angular velocity jerk magnitude

	frequencyBodyBodyGyroscopeJerkMagnitude-Mean_Frequency:
		Weighted average of the frequency components on frequency domain signals of body angular velocity jerk magnitude

	Activity:
		Activity
