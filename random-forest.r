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
#install.packages("randomForest")
#install.packages("ggplot2")
#install.packages("caret")

# read the data set merged from the IBM Telco Customer Churn dataset
churn_data = read.csv("Telco_customer_churn_merged.csv")

# uncomment to see summary statistics for each of our columns
#summary(churn_data) 

# load libraries
library(randomForest)

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

# Create a Random Forest and examine feature importance
set.seed(42) # make it repeatable for testing
cat("Building Random Forest...\n")
churn_classification_rf_model <- randomForest(as.factor(Churn.Label) ~ .,
							data=churn_data,
							#ntree=200, # default is 500, uncomment to limit
							#mtry=2, # uncomment to override
							proximity=TRUE)

# output feature importance - already part of the model
cat("Random Forest model built. Selected features:\n")
print(churn_classification_rf_model$variable.importance)

# output the Decision Tree model itself
cat("Random Forest model:\n")
print(churn_classification_rf_model)

# plot the error rates
oob.error.data <- data.frame(
  Trees=rep(1:nrow(churn_classification_rf_model$err.rate), times=3),
  Type=rep(c("OOB", "Yes", "No"), each=nrow(churn_classification_rf_model$err.rate)),
  Error=c(churn_classification_rf_model$err.rate[,"OOB"],
    churn_classification_rf_model$err.rate[,"Yes"],
	churn_classification_rf_model$err.rate[,"No"]))

# load ggplot2 and plot the Random Forest's accuracy as against growth
library(ggplot2)
ggplot(data=oob.error.data, aes(x=Trees, y=Error)) + geom_line(aes(color=Type))

# attempt to output graphical representation of Random Forest model
png("random-forest-model-1.png", width = 800, height = 600)
plot(churn_classification_rf_model)
dev.off()

# step 2 - test classification
cat("Testing classification accuracy...\n")
prediction_result = predict(churn_classification_rf_model, type="class")
table(prediction_result, churn_data$Churn.Label)

# Load the caret package
library(caret)
cat("\n")
confusionMatrix(prediction_result, churn_data$Churn.Label)