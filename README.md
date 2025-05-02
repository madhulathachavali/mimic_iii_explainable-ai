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

1. LLM-Powered Clinical Narrative: GPT-4 or Med42-v2 (as in [arXiv:2411.16818]) to generate clinician-friendly explanations from SHAP outputs.
Example:

python
# Sample code to link SHAP values to clinical guidelines
def generate_clinical_insight(shap_values):
    prompt = f"""
    Explain these ICU mortality risk factors to a clinician:
    SHAP values: {shap_values}
    Context: Patient with avg_creatinine=2.4, avg_platelets=89k.
    Reference KDIGO AKI guidelines and SEP-3 sepsis criteria.
    """
    return llm(prompt)


2. cost-benefit analysis section:
[PMC11328468]
model’s AUC (e.g., 0.85) vs widely used scores like SAPS-II (AUC 0.71-0.78 [PMC9139972])

3. Mitigate Bias 
SHAP interaction values to check for age/gender bias ([PMC11048122]).

4. LLM/Explainability Work:

-Streamlit/Tableau dashboard showing real-time risk scores.


