# Group Case Study
# Francis (202501????)
# Taiwo (202501????)
# Giulia (202501????)
# Raman (202501????)
# Rukmal Mahinda Hettiyakandage Fernando (2025014919)
# 
# International Business University
#  MBAC1022025: Business Analytics
#       Prof. Foad Aghamiri
#         August 16, 2025


# Prerequisites - uncomment and run once
#install.packages("rpart")
#install.packages("rpart.plot")

# read the data set merged from the IBM Telco Customer Churn dataset
churn_data = read.csv("Telco_customer_churn_merged.csv")
#summary(churn_data) # uncomment to see summary statistics for each of our columns

# load libraries
library(rpart)
library(rpart.plot)

# step 1 - try a simple Decision Tree and examine feature importance
decision_tree_model1 <- rpart(Churn.Label ~ . -CustomerID, data = churn_data, method = "class")

# output feature importance - already part of the model
importance <- decision_tree_model1$variable.importance
print(importance)

# output the Decision Tree model itself
print(decision_tree_model1)

# attempt to output graphical representation of Decision Tree model
png("decision-tree-model-1.png", width = 800, height = 600)
rpart.plot(decision_tree_model1)
dev.off()
