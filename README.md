The code does the following steps:

-Loads the library "plyr". 
-Reads all the training and test data using "read.table" command. 
-Substitutes the names in "features" with more meaningful names.
-Combines test and training data.
-Selects those columns that include mean and standard deviation data
-Creates a tidy table
-Creates a second tidy table based on the mean value of each subject and activity
-Writes the second data table to a text file