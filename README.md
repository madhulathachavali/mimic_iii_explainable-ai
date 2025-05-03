🏥 **ICU Mortality Prediction with Explainable AI (XAI) using MIMIC-III**

This project aims to predict **ICU mortality risk** using **XGBoost** and provide **explainability** with **SHAP**. 
🧰 **Tools & Methods**

* **Model**: XGBoost for binary classification (alive vs deceased).
* **Explainability**: SHAP to understand feature contributions to mortality risk.
* **Data**: Clinical data from MIMIC-III (vitals, lab tests, comorbidities).

🔍 **Key Insights**

* 🔬 **Key Features**: age, avg_heart_rate, avg_creatinine, gender, and care unit type 
* 💡 SHAP values help explain model predictions, both globally and for individual cases
  
📊 **Model Development & Evaluation**
1️⃣ **Data Preparation**:

* Preprocessing features such as age, heart rate, creatinine.

2️⃣ **Model Development**:

* XGBoost trained on ICU data to predict mortality.
* **Performance metrics**: AUC: 0.85, F1-score: 0.50.

3️⃣ **Explainability with SHAP**:

* SHAP values reveal which features influence mortality risk and their effect on the model's predictions.

  ```python
  explainer = shap.TreeExplainer(model)
  shap_values = explainer.shap_values(X_test)
  shap.summary_plot(shap_values, X_test)
  ```

4️⃣ **Confusion Matrix**:

* \[\[8261  524], \[ 592  560]]

🧩 **Bias Mitigation**

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

📚 **References**

1. Johnson, A., Bulgarelli, L., Pollard, T., Gow, B., Moody, B., Horng, S., Celi, L. A., & Mark, R. (2024). MIMIC-IV (version 3.1). PhysioNet. https://doi.org/10.13026/kpb9-mt58.
2. Johnson, A.E.W., Bulgarelli, L., Shen, L. et al. MIMIC-IV, a freely accessible electronic health record dataset. Sci Data 10, 1 (2023). https://doi.org/10.1038/s41597-022-01899-x
3. Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220.

