# Body Fat Percentage Prediction

This project aims to predict the body fat percentage based on body circumference measurements using machine learning regression models. The dataset contains records of 252 men with various body circumference values and their corresponding body fat percentages measured through underwater weighing.

## Dataset
The dataset used for this project is the "Body Fat Prediction" dataset obtained from Kaggle, provided by Dr. A. Garth Fisher. It contains the following attributes:

* Density
* Body Fat percentage
* Age
* Weight
* Height
* Neck circumference
* Chest circumference
* Abdomen circumference
* Hip circumference
* Thigh circumference
* Knee circumference
* Ankle circumference
* Biceps circumference
* Forearm circumference
* Wrist circumference

The circumference measurements are in centimeters, and the height is in inches.
Methodology

## Steps performed in this project:

1. Exploratory Data Analysis (EDA): Analyzed the dataset to identify issues like missing data, outliers, and inconsistent units.
2. Data Preprocessing: Handled outliers and missing data, performed feature selection using the Boruta library, and split the data into training (80%) and testing (20%) sets.
3. Modeling: Implemented three regression models - Multiple Linear Regression, Support Vector Regression (SVR), and Random Forest Regression.
4. Model Evaluation: Evaluated the performance of each model using metrics like R-squared, Mean Absolute Error (MAE), Root Mean Squared Error (RMSE), and Mean Squared Residuals.
5. Model Comparison: Compared the performance of the three models and selected the best one for predicting body fat percentage.

## Results
The Multiple Linear Regression model exhibited the highest accuracy, with an R-squared value of 0.972, indicating that it could explain 97.2% of the variance in body fat percentage. The Random Forest Regression and Support Vector Regression models also performed well, with R-squared values of 0.9285 and 0.89, respectively.
