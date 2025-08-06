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
#install.packages("caret")

# read the data set merged from the IBM Telco Customer Churn dataset
churn_data_frame = read.csv("Telco_customer_churn_merged.csv")

# remove CustomerID column to ease classification
churn_data <- subset(churn_data_frame, select = -c(CustomerID)) 

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

# split this 80%:20% into training:test data frames
set.seed(42) # to get reproducible results during testing
# select 80% of records as sample from total 'n' rows of the data  
sample <- sample.int(n = nrow(churn_data), size = floor(0.8*nrow(churn_data)), replace = F)
train_data <- churn_data[sample, ]
test_data  <- churn_data[-sample, ]

# load libraries
library(rpart)
library(rpart.plot)

# step 1 - build Decision Tree with training partition and examine feature importance
cat("Building Decision Tree with training partition (80%)...\n")
decision_tree_model2 <- rpart(Churn.Label ~ ., data = train_data, method = "class")

# output feature importance to see the features selected
cat("Decision Tree built. Selected features:\n")
print(decision_tree_model2$variable.importance)

# output the Decision Tree model itself
cat("Decision Tree:\n")
print(decision_tree_model2)

# attempt to output graphical representation of Decision Tree model
png("decision-tree-model-2.png", width = 800, height = 600)
rpart.plot(decision_tree_model2)
dev.off()

# step 2 - test classification with test partition
cat("Testing classification accuracy with test partition (20%)...\n")
prediction_result = predict(decision_tree_model2, newdata=test_data, type="class")
table(prediction_result, test_data$Churn.Label)

# Load the caret package
library(caret)
cat("\n")
confusionMatrix(prediction_result, test_data$Churn.Label)