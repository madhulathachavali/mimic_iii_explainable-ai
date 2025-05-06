-- Step 1: Aggregate vitals from chartevents
WITH vitals AS (
  SELECT
    icu.subject_id,
    icu.hadm_id,
    icu.icustay_id,
    AVG(CASE WHEN ce.itemid IN (211, 220045) THEN ce.valuenum END) AS avg_heart_rate,
    AVG(CASE WHEN ce.itemid IN (51, 455, 6701, 220179, 220050) THEN ce.valuenum END) AS avg_sbp
  FROM
    `physionet-data.mimiciii_clinical.chartevents` ce
  JOIN
    `physionet-data.mimiciii_clinical.icustays` icu
    ON ce.icustay_id = icu.icustay_id
  WHERE
    ce.valuenum IS NOT NULL
    AND ce.itemid IN (211, 220045, 51, 455, 6701, 220179, 220050)
  GROUP BY
    icu.subject_id, icu.hadm_id, icu.icustay_id
),

-- Step 2: Aggregate labs from labevents
labs AS (
  SELECT
    hadm_id,
    AVG(CASE WHEN itemid = 50912 THEN valuenum END) AS avg_creatinine,
    AVG(CASE WHEN itemid = 51300 THEN valuenum END) AS avg_wbc,
    AVG(CASE WHEN itemid = 51265 THEN valuenum END) AS avg_platelets,
    AVG(CASE WHEN itemid = 51221 THEN valuenum END) AS avg_hematocrit
  FROM
    `physionet-data.mimiciii_clinical.labevents`
  WHERE
    itemid IN (50912, 51300, 51265, 51221)
    AND valuenum IS NOT NULL
  GROUP BY
    hadm_id
),

-- Step 3: ICU admission and patient info
icustay_info AS (
  SELECT
    icu.subject_id,
    icu.hadm_id,
    icu.icustay_id,
    icu.first_careunit,
    ROUND(DATETIME_DIFF(icu.outtime, icu.intime, HOUR)/24.0, 2) AS los,
    ROUND(DATETIME_DIFF(icu.intime, dob, YEAR)) AS age,
    pat.gender,
    adm.deathtime IS NOT NULL AS died_in_hospital
  FROM
    `physionet-data.mimiciii_clinical.icustays` icu
  JOIN
    `physionet-data.mimiciii_clinical.admissions` adm
    ON icu.hadm_id = adm.hadm_id
  JOIN
    `physionet-data.mimiciii_clinical.patients` pat
    ON icu.subject_id = pat.subject_id
  WHERE
    DATETIME_DIFF(icu.intime, pat.dob, YEAR) BETWEEN 18 AND 89
)

-- Final output: join all features
SELECT
  i.subject_id,
  i.hadm_id,
  i.icustay_id,
  i.age,
  i.gender,
  i.first_careunit,
  i.los,
  v.avg_heart_rate,
  v.avg_sbp,
  l.avg_creatinine,
  l.avg_wbc,
  l.avg_platelets,
  l.avg_hematocrit,
  i.died_in_hospital
FROM
  icustay_info i
LEFT JOIN
  vitals v ON i.icustay_id = v.icustay_id
LEFT JOIN
  labs l ON i.hadm_id = l.hadm_id
WHERE
  v.avg_heart_rate IS NOT NULL
  AND v.avg_sbp IS NOT NULL
