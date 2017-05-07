# Getting-and-Cleaning-data-Project-1

These are the submission files from the week 4 project of the "Getting-and-Cleaning-data" course.

The R file run_analysis.r does the following:

1: Checks if the dataset is present in the working directory. If not, it is downloaded and unzipped
2: Reads the contents of the data set in as data tables and column name lists
3: Merges the multiple data tables into one combined table and names the columns
4: Subsets the table into only the fields containing "mean" and "standard deviation" data
5: Tidies and prints this summarised table as a text file

The end result is shown as "UCI HAR mean and std tidy.txt"
