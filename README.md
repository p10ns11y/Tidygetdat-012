# Tidygetdat-012
Getting and Cleaning  Data Course Project

## How the code works

 * It first merges the training and test data sets into one using 'merge' function
 * To extract only mean and standard deviation, 'grep' function used over features.txt
   and the extracted names used on X (561  features vector)
 * 'gsub' function used to name activities in the data set descriptively 
 
 * using 'names' property , variables are appropirately labled
 * 'cbind' function helps to merge the activity ,subject , extracted features into
   single dataframe
   
 * Finally, using 'melt' and 'dcast' the required tidy data is created


