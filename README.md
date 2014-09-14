## Getting and Cleaning Data Course Project 1

The script *run_analysis.R* reads the features from the file *features.txt*, to be used later as column names. For that reason, the character '-' is replaced by '_', and the parentheses removed.

Those columns are filtered to retain only those ending in 'mean', 'std', 'mean_x', 'mean_y' and so on.