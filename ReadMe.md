# Getting and Cleaning Data
 - - - -
This script will per form the following work
	1. download the dataset from this location [Link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
	2. Load all the the required files into memory such as variable data, activity labels, etc.
	3. clean the variable names to make it more legible, and remove extraneous characters  
	4. the data will be subsetting to return only the mean and standard deviations values
	5. it will match the participant numbers and the actions performed, and be mergers with the appropriate datasets
		(test or train)
	6. the datasets will be merged.
	7.  the datasets will be melted, and the regroup to organize into summarized groupings by
		participant id, and action performed.