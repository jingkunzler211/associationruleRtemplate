# Association Rule Mining R Script
# Also adapted from David Schuff: https://community.mis.temple.edu/mis2502sec002s2019/

# First, clear all previous stuff out of the workspace...
rm(list = ls())

# Install packages for association rule analysis

if (!require("arules")) { install.packages("arules")
  
  require("arules") }

# Fix the random seed - keeps the bubble charts the same with each run.
set.seed(1234)         

# Import dataset
txn = read.transactions(file="Groceries.csv", rm.duplicates=TRUE, format="single",sep=",",cols=c(1,2))

# Read the comma-delimited data file and put them into a variable called "txn." Make sure:
#     1) The first column has the order ID (unique for each order)
#     2) The second column has the "Item" (i.e., product purchased; not unique)

#Read the read.transactions command:
#     1) rm.duplicates=TRUE removes double-counted items in a single basket 
# 		2) format="single" says each component of a transaction is on a separate line
#     3) sep="," tells R to look for a comma to separate data columns
#     4) cols=c(1,2) tells R to only look at the first two columns of the file


# Run the apriori algorithm - this is what computes the association rules.
basket_rules <- apriori(txn,parameter = list(sup=0.01, conf=0.01, target="rules"))

# txn -    the variable representing the transaction data read from the data file
# sup -    the minimum threshold for support; below this the rule won't appear in the output. 
#    Here I define sup=0.01 based on my understanding of the problem. You can choose your own value.
# conf -   the minimum threshold for confidence; below this the rule won't appear in the output
#    Here I define conf=0.01 based on my understanding of the problem. You can choose your own value.
# target - says we want to make some rules!



# This outputs the list of rules to the screen.
inspect(basket_rules)

#It's easier to see the list of rules if you just open the output file in Excel where you can also 
#    sort the rules by confidence, support, and lift.
# This command outputs the list of rules to a csv file.
write.csv(as(basket_rules,"data.frame"), file = "ARulesOutput.csv")
