# Explainable AI for ICU Mortality Prediction using MIMIC-III

## Overview

This project aims to develop an **Explainable AI (XAI)** model to predict **ICU mortality risk** based on patient data from the MIMIC-III database. The project utilizes **XGBoost** for mortality prediction and **SHAP** (SHapley Additive exPlanations) to explain the predictions and identify key features influencing mortality risk.

By using this approach, the goal is to build a reliable, interpretable, and actionable model that can help clinicians make better-informed decisions in the ICU setting.

## Key Features

- **Predictive Model**: XGBoost model for binary classification of ICU mortality (alive vs deceased).
- **Explainability**: SHAP for interpreting model predictions, providing transparency on what drives mortality risk.
- **Data**: Utilizes clinical data from the **MIMIC-III** database, including vital signs, laboratory tests, and comorbidities.

## Structure

The project includes the following components:

- **Data Preparation**: Preprocessing MIMIC-III clinical data.
- **Model Development**: Building and training the mortality prediction model.
- **Model Interpretation**: Using SHAP to interpret model outputs and explain individual predictions.
- **Evaluation**: Performance metrics (accuracy, ROC-AUC, confusion matrix).

## Technologies Used

- **XGBoost**: Machine learning algorithm for mortality prediction.
- **SHAP**: Library for explaining the model's predictions.
- **BigQuery**: Querying MIMIC-III data from Google Cloud.

