# Group Case Study
# Francis Ogunlaja (2024092880)
# Giulia Moliterno Santos (2025015348)
# Ramandeep Kaur (2024093666)
# Rukmal Mahinda Hettiyakandage Fernando (2025014919)
# Taiwo Ernestina Jivoh (2025016367)
# 
# International Business University
#  MBAC1022025: Business Analytics
#       Prof. Foad Aghamiri
#         August 16, 2025
#
# See README.md for more information about this file.
#
# Prerequisites - uncomment and run once
#install.packages("rpart")
#install.packages("rpart.plot")
#install.packages("caret")

# read the data set merged from the IBM Telco Customer Churn dataset
churn_data = read.csv("Telco_customer_churn_merged.csv")

# uncomment to see summary statistics for each of our columns
#summary(churn_data)

# convert columns into factors
churn_data$Gender <- as.factor(churn_data$Gender)
churn_data$Country <- as.factor(churn_data$Country)
churn_data$State <- as.factor(churn_data$State)
churn_data$Gender <- as.factor(churn_data$Gender)
churn_data$Senior.Citizen <- as.factor(churn_data$Senior.Citizen)
churn_data$Partner <- as.factor(churn_data$Partner)
churn_data$Dependents <- as.factor(churn_data$Dependents)
churn_data$Phone.Service <- as.factor(churn_data$Phone.Service)
churn_data$Multiple.Lines <- as.factor(churn_data$Multiple.Lines)
churn_data$Internet.Service <- as.factor(churn_data$Internet.Service)
churn_data$Online.Security <- as.factor(churn_data$Online.Security)
churn_data$Online.Backup <- as.factor(churn_data$Online.Backup)
churn_data$Device.Protection <- as.factor(churn_data$Device.Protection)
churn_data$Tech.Support <- as.factor(churn_data$Tech.Support)
churn_data$Streaming.TV <- as.factor(churn_data$Streaming.TV)
churn_data$Streaming.Movies <- as.factor(churn_data$Streaming.Movies)
churn_data$Paperless.Billing <- as.factor(churn_data$Paperless.Billing)
churn_data$Churn.Label <- as.factor(churn_data$Churn.Label)
churn_data$Under.30 <- as.factor(churn_data$Under.30)
churn_data$Referred.a.Friend <- as.factor(churn_data$Referred.a.Friend)
churn_data$Offer <- as.factor(churn_data$Offer)
churn_data$Internet.Type <- as.factor(churn_data$Internet.Type)
churn_data$Streaming.Music <- as.factor(churn_data$Streaming.Music)
churn_data$Unlimited.Data <- as.factor(churn_data$Unlimited.Data)

# load libraries
library(rpart)
library(rpart.plot)

# step 1 - try a simple Decision Tree and examine feature importance
# we need to exclude CustomerID to prevent the Decision Tree from greedily classify based on CustomerID values
cat("Building Decision Tree...\n")
decision_tree_model1 <- rpart(Churn.Label ~ . -CustomerID, data = churn_data, method = "class")

# output feature importance to see the features selected
cat("Decision Tree built. Selected features:\n")
print(decision_tree_model1$variable.importance)

# output the Decision Tree model itself
cat("Decision Tree:\n")
print(decision_tree_model1)

# attempt to output graphical representation of Decision Tree model
png("decision-tree-model-1.png", width = 800, height = 600)
rpart.plot(decision_tree_model1)
dev.off()

# step 2 - test classification with model
cat("Testing classification accuracy...\n")
prediction_result = predict(decision_tree_model1, type="class")

# Load the caret package and output a formatted confusion matrix, accuracy measures etc.
library(caret)
cat("\n")
confusionMatrix(prediction_result, churn_data$Churn.Label)