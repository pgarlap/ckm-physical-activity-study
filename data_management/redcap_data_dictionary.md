# REDCap Data Dictionary
## CKM Physical Activity Study

This document describes all variables collected in the REDCap
database for the CKM Physical Activity Study.

---

## Participant Information

| Variable | Label | Type | Values |
|---|---|---|---|
| participant_id | Unique Participant ID | Text | CKM_001, CKM_002... |
| enrollment_date | Date of Enrollment | Date | YYYY-MM-DD |
| consent_date | Date of Informed Consent | Date | YYYY-MM-DD |
| study_status | Current Study Status | Dropdown | Active, Completed, Withdrawn |

---

## Demographics

| Variable | Label | Type | Values |
|---|---|---|---|
| age | Age in Years | Integer | 18-100 |
| gender | Gender | Dropdown | Male, Female, Other |
| race | Race/Ethnicity | Dropdown | 1=White, 2=Black, 3=Hispanic, 4=Asian, 5=Other |
| education | Education Level | Dropdown | 1=Less than HS, 2=HS, 3=Some College, 4=Bachelor's, 5=Graduate |
| income | Annual Income | Dropdown | 1=<$25K, 2=$25-50K, 3=$50-75K, 4=>$75K |

---

## CKM Conditions

| Variable | Label | Type | Values |
|---|---|---|---|
| overweight | Overweight/Obese | Binary | 0=No, 1=Yes |
| hypertension | Hypertension | Binary | 0=No, 1=Yes |
| diabetes | Diabetes | Binary | 0=No, 1=Yes |
| ckd | Chronic Kidney Disease | Binary | 0=No, 1=Yes |
| metabolic_syndrome | Metabolic Syndrome | Binary | 0=No, 1=Yes |
| hypertriglyceridemia | Hypertriglyceridemia ≥135 mg/dL | Binary | 0=No, 1=Yes |
| ckm_severity | CKM Severity Score | Integer | 0-4 (count of conditions) |

---

## Accelerometer Data — Baseline (Week 1-2)

| Variable | Label | Type | Unit |
|---|---|---|---|
| baseline_steps | Average Daily Steps | Integer | Steps/day |
| baseline_active_min | Average Daily Active Minutes | Decimal | Minutes/day |
| baseline_sedentary_hrs | Average Daily Sedentary Hours | Decimal | Hours/day |
| baseline_device_worn_days | Days Device Was Worn | Integer | Days (0-14) |
| baseline_device_sent | Device Sent Date | Date | YYYY-MM-DD |
| baseline_device_returned | Device Returned Date | Date | YYYY-MM-DD |

---

## Accelerometer Data — Follow-up (Week 5-6)

| Variable | Label | Type | Unit |
|---|---|---|---|
| followup_steps | Average Daily Steps | Integer | Steps/day |
| followup_active_min | Average Daily Active Minutes | Decimal | Minutes/day |
| followup_sedentary_hrs | Average Daily Sedentary Hours | Decimal | Hours/day |
| followup_device_worn_days | Days Device Was Worn | Integer | Days (0-14) |
| followup_device_sent | Device Sent Date | Date | YYYY-MM-DD |
| followup_device_returned | Device Returned Date | Date | YYYY-MM-DD |

---

## Survey Data

| Variable | Label | Type | Values |
|---|---|---|---|
| survey1_complete | Baseline Survey Complete | Binary | 0=No, 1=Yes |
| survey1_date | Baseline Survey Date | Date | YYYY-MM-DD |
| survey2_complete | Follow-up Survey Complete | Binary | 0=No, 1=Yes |
| survey2_date | Follow-up Survey Date | Date | YYYY-MM-DD |

---

## Notes

- All data collected and managed in REDCap
- HIPAA compliant data handling throughout
- Missing values coded as blank (not -9 or 0)
- Device tracking managed via participant log
- IRB Protocol — Study ID 21855
