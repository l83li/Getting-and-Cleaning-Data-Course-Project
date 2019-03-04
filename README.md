# Getting-and-Cleaning-Data-Course-Project
This repo contains an R scrips (Run_analysis.R) and documentation files for the final project of JHU Data Science Specialization course "Getting and Cleaning Data".

The doctumentation files inclues:                                                                                                         
Codebook.MD----Explain all the variables and summarizes, and other relevent information                                                   
tidy_data_set.txt---The output of Run_analysis.R                                                                                           
README.md----Explain how the Run_analysis.R work and other relevent information

The Run_analysis.R does the followings:
1. Download the target data package if it does not exist in the working directory
2. Load the activity and feature information, determain which column contains the mean or standard deviation base on the feature info
3. Load training and test dataset, merges these two datasets to create one data set
4. Extracts only the measurements on the mean and standard deviation for each measurement
5. Uses the activity labels to name the activities in the data set
6. Group data by activity labels and subject ID, summarize the average of each varibale

