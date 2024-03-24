This repository contains code for creating a predictive model aimed at estimating student performance based on various factors like study hours, quiz scores, forum participation, and previous grades. The model, developed in R, utilizes supervised learning techniques.

Generating Dataset
The dataset is artificially generated to resemble real student performance data. It encompasses attributes such as study hours, quiz scores, forum participation, previous grades, and final grades. To ensure reproducibility, the simulated data is produced with a fixed random seed.

Model Development
Data Division: The dataset is divided into training and testing subsets in an 80:20 ratio, enabling model training on a portion of the data while validating its performance on unseen instances.

Model Selection: Logistic regression is employed as the predictive model owing to its suitability for binary classification tasks. The model is instantiated using the {parsnip} package, with the engine set to a generalized linear model (glm) for logistic regression.

Feature Engineering: A recipe is crafted to preprocess the data prior to model training. It outlines the target variable (FinalGrades) and predictor variables (StudyHours, QuizScores, ForumPosts, PreviousGrades).

Model Training: The model is trained on the training dataset using the designated workflow, which encompasses both the model and recipe.

Model Evaluation: The trained model undergoes evaluation on the testing dataset to gauge its predictive capability. Performance metrics like accuracy and prediction interval are computed to assess the model's effectiveness in forecasting student grades.

How to Use
To execute the code:

Clone this repository onto your local machine.
Open the R script or R Markdown file in your preferred R development environment.
Ensure installation of the required packages listed in the script.
Sequentially run the code to generate simulated data, train the model, and evaluate its performance.
Dependencies
The following R packages are necessary to run the code:

{tidymodels}: For data modeling and preprocessing.
{rsample}: For data splitting and resampling.
{parsnip}: For specifying machine learning models.
{dplyr}: For data manipulation.
{ggplot2}: For data visualization.
Install these packages using the install.packages() function if they are not already installed.
