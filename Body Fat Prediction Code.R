# Import Dataset
Dataset<-read.csv("bodyfat.csv")

# Dataset Issue
# Zero value
colSums(Dataset <= 0) 

# Outliers
boxplot(Dataset)

# Data Preprocessing
# Handle outliers
# Replace all the outliers to NULL
for (x in c('Density' ,'BodyFat' ,'Age' ,'Weight' ,'Height' ,'Neck' ,'Chest' ,'Abdomen','Hip','Thigh' ,'Knee' ,'Ankle' ,'Biceps' ,'Forearm' ,'Wrist')) {
  value = Dataset[,x][Dataset[,x] %in% boxplot.stats(Dataset[,x])$out]
  Dataset[,x][Dataset[,x] %in% value] = NA
} 

# Handle zero value
library(dplyr) # load required library
Dataset <- Dataset %>%
  mutate(across(everything(), ~ replace(., . == 0|is.na(.), mean(., na.rm = TRUE))))


# As in this dataset all features is in numeric. So it doesn't need to change to category.

# Feature Selection, to remove feature if it is not relevant to the topic.
set.seed(168)
# Load the library
library(Boruta)
vars <- Boruta(BodyFat~., data = Dataset, doTrace = 1)
print(vars)
plot(vars)
attStats(vars)
# No any feature remove needed, as there are no plot in red color.
finalvars = getSelectedAttributes(vars, withTentative = F)
print(finalvars)

# Splitting the Dataset into Training & Testing Dataset
# Load the library
library(caTools)
split = sample.split(Dataset$BodyFat, SplitRatio = 0.8)

training_set = subset(Dataset, split == TRUE)
test_set = subset(Dataset, split == FALSE)
training_set
test_set


# Data mining techniques
# Multiple Linear Regression 
lr_model <- lm(BodyFat ~ ., data = training_set)
summary(lr_model)
plot(lr_model)
lr_prediction <- predict(lr_model, test_set)

# Support Vector Regression 
# install.packages("e1071")# Install the required package for function
library(e1071) # load library
# Feature scaling, as it is compulsory to conduct normalization on SVR
normalized_training_set <- training_set
normalized_test_set <- test_set
normalized_training_set[,2:15] = scale(normalized_training_set[,2:15])
normalized_test_set[,2:15] = scale(normalized_test_set[,2:15])
head(normalized_training_set)
head(normalized_test_set)
# Model building
svr_model = svm(BodyFat ~ ., normalized_training_set)
summary(svr_model)
svr_prediction <- predict(svr_model, normalized_test_set)
x = 1:length(normalized_test_set$BodyFat)
plot(x, normalized_test_set$BodyFat, pch=18, col="red")
lines(x, svr_prediction, lwd="1", col="blue")

# Random Forest Regression
# install.packages("randomForest") # Install the required package for function
library(randomForest) # Load the library
rf_model <- randomForest(BodyFat ~ ., training_set)
rf_model
plot(rf_model)


# Performance Evaluation
# Linear Regression
summary
sigma(lr_model)
sigma(lr_model)/mean(test_set$BodyFat)

# SVR
library(caret)
MAE(normalized_test_set$BodyFat, svr_prediction)
RMSE(normalized_test_set$BodyFat, svr_prediction)
R2(normalized_test_set$BodyFat, svr_prediction, form = "traditional")

# Random Forest
rf_model