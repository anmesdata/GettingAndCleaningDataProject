## Getting and Cleaning Data Project

# Data Source

A detailed description of the dataset used for this project can be read at
[UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The link to the raw data is [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

# Introduction to the data

The group of volunteers included 30 people between the ages 19-48. Each person performed six activities while wearing a smartphone. The technology in the smartphone  captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The recorded dataset has been randomly split into two sets; 70% (i.e. 21 volunteers) of the data contributes towards a training dataset and 30% (i.e 9 volunteers) contributes towards a testing dataset.

# Analysis done to clean the data as required

*The dataset was downloaded and unzipped
*All the training data and testing data was read into R
*The activity labels were also read into R
*Appropriate column names were assigned as need
*All the data was merged into one data frame
*Only mean and std dev data was extracted for each measurement
*An independent data frame was created with the mean of each variable for each subject and for each activity
*The column names were cleaned up
*The tidy dataset was written to a txt file