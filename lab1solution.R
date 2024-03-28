# Load the libraries
library(tidyverse)
library(tidymodels)
 
# Dataset
student_records <- read_csv("studentInfo.csv")
 
# Transform variables
student_records <- student_records %>%
  mutate(pass_binary_indicator = ifelse(final_result == "Pass", 1, 0)) %>% # Binary indicator for pass/fail
  mutate(pass_status_factor = as.factor(pass_binary_indicator)) %>%  # Convert pass status to factor
  mutate(disability_status_factor = as.factor(disability))  # Convert disability status to factor
 
# Dataset
student_records
 
# Feature engineering
student_records <- student_records %>%
  mutate(imd_band_factor = factor(imd_band, levels = c("0-10%", "10-20%", "20-30%", "30-40%", "40-50%", "50-60%", "60-70%", "70-80%", "80-90%", "90-100%"))) %>%
  mutate(imd_band_integer = as.integer(imd_band_factor)) # Convert IMD band to integer
 
# Dataset has been splitted accordingly
set.seed(20230712)
train_test_partition <- initial_split(student_records, prop = 0.80)
training_set <- training(train_test_partition)
testing_set <- testing(train_test_partition)
 
# Recipe
my_recipe <- recipe(pass_status_factor ~ disability_status_factor + imd_band_integer, data = training_set) # Recipe formulation
 
# Model specification
my_logistic_model <- 
  logistic_reg() %>% 
  set_engine("glm") %>% 
  set_mode("classification")
 
# Workflow is equipped with receipe and model
my_workflow <- 
  workflow() %>% 
  add_model(my_logistic_model) %>% 
  add_recipe(my_recipe)
 
# Model Training
fitted_model <- fit(my_workflow, data = training_set)
 
# Resampling object for testing data
test_data_split <- initial_split(testing_set, prop = 0.8)  # Splitting testing data
 
# Model is tested by testing data
final_results <- last_fit(my_workflow, split = test_data_split)
 
# final fitted model
final_results
 
# Predictions
final_results %>%
  collect_predictions()
 
# Accuracy
final_results %>%
  collect_predictions() %>%
  select(.pred_class, pass_status_factor) %>%
  mutate(correct_prediction = .pred_class == pass_status_factor) %>%
  tabyl(correct_prediction)
