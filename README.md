# 🏥 **ICU Mortality Prediction with Explainable AI (XAI) using MIMIC-III**

This project aims to predict **ICU mortality risk** using **XGBoost** and provide **explainability** with **SHAP**. 

🧰 **Tools & Methods**

* **Model**: XGBoost for binary classification (alive vs deceased).
* **Explainability**: SHAP to understand feature contributions to mortality risk.
* **Data**: Clinical data from MIMIC-III (vitals, lab tests, comorbidities).

🔍 **Key Insights**

* 🔬 **Key Features**: age, avg_heart_rate, avg_creatinine, gender, and care unit type 
* 💡 SHAP values help explain model predictions, both globally and for individual cases
  
<img width="797" alt="image" src="https://github.com/user-attachments/assets/a9110f7d-1b1e-4c0c-a369-347f38b55e4b" />

  
📊 **Model Development & Evaluation**

1️⃣ **Data Preparation**:

* Preprocessing features such as age, heart rate, and creatinine.

2️⃣ **Model Development**:

* XGBoost trained on ICU data to predict mortality.
* **Performance metrics**: AUC: 0.85, F1-score: 0.50.
  
<img width="715" alt="image" src="https://github.com/user-attachments/assets/087df097-79e5-468e-967d-638c6c260411" />

📊 **Risk Distribution by ICU Type**
  

| First Care Unit | Total Patients | At-Risk Patients | Risk Percentage (%) |
| --------------- | -------------- | ---------------- | ------------------- |
| MICU            | 3,907          | 352              | 9.01                |
| CCU             | 1,430          | 70               | 4.90                |
| SICU            | 1,671          | 81               | 4.85                |
| TSICU           | 1,174          | 40               | 3.41                |
| CSRU            | 1,755          | 19               | 1.08                |



3️⃣ **Explainability with SHAP**:

* SHAP values reveal which features influence mortality risk and their effect on the model's predictions.

  ```python
  explainer = shap.TreeExplainer(model)
  shap_values = explainer.shap_values(X_test)
  shap.summary_plot(shap_values, X_test)
  ```
<img width="730" alt="image" src="https://github.com/user-attachments/assets/61c0ab53-9b35-4465-9774-0a5e31675c96" />
<img width="733" alt="image" src="https://github.com/user-attachments/assets/bbf058b1-3a0a-4312-8147-323fb8e7a6f1" />

 
4️⃣ **Classification Report and Confusion Matrix**:


🔍 Classification Report

**Best Threshold for F1-score: `0.24`**

 ✅ Classification Report (Best Threshold)

| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| **False** | 0.94 | 0.92 | 0.93 | 8,789 |
| **True**  | 0.46 | 0.53 | 0.49 | 1,148 |

📊 Overall Metrics

| Metric              | Score |
|---------------------|-------|
| **Accuracy**        | 0.87  |
| **Macro Avg F1**    | 0.71  |
| **Weighted Avg F1** | 0.88  |


💬 **LLM Integration**

* **GPT-4** is used to generate clinician-friendly insights based on SHAP values. Example:

  ```python
  def generate_clinical_insight(shap_values):
      prompt = f"Explain ICU mortality risk based on SHAP values: {shap_values}"
      return llm(prompt)
  ```

🔭 **Future Work**

* Real-time dashboards for live mortality risk scores.
* Model calibration to improve F1-score and sensitivity.

✅ **Conclusion**

Explainable AI allows clinicians to understand why a patient is at high risk by providing the top features influencing the risk prediction. 
Below is the detailed table for the 5 patients with SHAP values and top 3 features.

| **Patient** | **Age** | **LOS** (Days) | **Avg. Heart Rate** | **SHAP Value (Age)** | **SHAP Value (LOS)** | **Top 3 Features**                            |
| ----------- | ------- | -------------- | ------------------- | -------------------- | -------------------- | --------------------------------------------- |
| Patient 1   | 47.0    | 10.13          | 82.64               | -0.462578            | 0.703025             | \[LOS, Age, Avg. Platelets]                   |
| Patient 2   | 58.0    | 1.08           | 52.41               | -0.430839            | -1.231928            | \[Avg. Heart Rate, LOS, Avg. SBP]             |
| Patient 3   | 74.0    | 3.33           | 72.99               | 0.005564             | 0.054851             | \[Avg. Heart Rate, Avg. Creatinine, Avg. SBP] |
| Patient 4   | 70.0    | 0.54           | 91.75               | 0.307043             | 0.940206             | \[LOS, Avg. SBP, Avg. Creatinine]             |
| Patient 5   | 61.0    | 2.67           | 77.97               | -0.070650            | -0.388737            | \[Avg. Creatinine, Avg. SBP, LOS]             |

📚 **References**

1. Johnson, A., Bulgarelli, L., Pollard, T., Gow, B., Moody, B., Horng, S., Celi, L. A., & Mark, R. (2024). MIMIC-IV (version 3.1). PhysioNet. https://doi.org/10.13026/kpb9-mt58.
2. Johnson, A.E.W., Bulgarelli, L., Shen, L. et al. MIMIC-IV, a freely accessible electronic health record dataset. Sci Data 10, 1 (2023). https://doi.org/10.1038/s41597-022-01899-x
3. Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220.

