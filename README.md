# Getting and Cleaning Data - Course Project

This is course project for Getting and Cleaning Data as a Coursera course under Data Science specialization. The main file 'main_analysis.R' does the following:
<ol>
<li>Download the dataset from url, if it does not already exist in the working directory</li>
<li>Load the activity and feature info</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement. </li>
<li>Loads the activity and subject data for each dataset, and merges those columns with the dataset</li>
<li>Merges the training and the test sets to create one data set.</li>
<li>Converts the "activity" and "subject" columns into factors</li>
<li>Creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
</ol>
