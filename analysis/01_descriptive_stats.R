# ============================================================
# Script 1: Descriptive Statistics — Baseline Analysis
# CKM Physical Activity Study
# PI: Dr. Navin Kaushal | Indiana University Indianapolis
# Analyst: Poojitha Garlapati
# ============================================================

library(dplyr)
library(ggplot2)

# Load REDCap exported data
# Export from REDCap as CSV before running
ckm_data <- read.csv("data/ckm_baseline.csv", stringsAsFactors = FALSE)

cat("Participants enrolled:", nrow(ckm_data), "\n")
cat("Variables collected:", ncol(ckm_data), "\n")

# ── Step 1: Demographics ────────────────────────────────────
cat("\n── Demographic Summary ────────────────────────────\n")

demographics <- ckm_data %>%
  summarise(
    Total_N        = n(),
    Mean_Age       = round(mean(age, na.rm = TRUE), 1),
    SD_Age         = round(sd(age, na.rm = TRUE), 1),
    Min_Age        = min(age, na.rm = TRUE),
    Max_Age        = max(age, na.rm = TRUE),
    Pct_Female     = round(mean(gender == "Female", na.rm = TRUE) * 100, 1),
    Pct_Male       = round(mean(gender == "Male", na.rm = TRUE) * 100, 1)
  )

print(demographics)

# ── Step 2: CKM Condition Distribution ─────────────────────
cat("\n── CKM Conditions Distribution ───────────────────\n")

conditions <- ckm_data %>%
  summarise(
    Pct_Hypertension    = round(mean(hypertension == 1, na.rm = TRUE) * 100, 1),
    Pct_Diabetes        = round(mean(diabetes == 1, na.rm = TRUE) * 100, 1),
    Pct_CKD             = round(mean(ckd == 1, na.rm = TRUE) * 100, 1),
    Pct_MetabolicSyndrome = round(mean(metabolic_syndrome == 1, na.rm = TRUE) * 100, 1),
    Pct_Overweight      = round(mean(overweight == 1, na.rm = TRUE) * 100, 1)
  )

print(conditions)

# ── Step 3: Baseline Physical Activity ─────────────────────
cat("\n── Baseline Physical Activity (Accelerometer) ─────\n")

activity_summary <- ckm_data %>%
  summarise(
    Mean_Daily_Steps     = round(mean(baseline_steps, na.rm = TRUE), 0),
    SD_Daily_Steps       = round(sd(baseline_steps, na.rm = TRUE), 0),
    Mean_Active_Minutes  = round(mean(baseline_active_min, na.rm = TRUE), 1),
    Mean_Sedentary_Hours = round(mean(baseline_sedentary_hrs, na.rm = TRUE), 1),
    Pct_Meeting_Guidelines = round(
      mean(baseline_active_min >= 150, na.rm = TRUE) * 100, 1
    )
  )

print(activity_summary)

cat("\nNote: CDC guidelines recommend 150+ minutes of moderate",
    "activity per week\n")

# ── Step 4: Survey Response Summary ────────────────────────
cat("\n── Survey Completion ──────────────────────────────\n")

survey_completion <- ckm_data %>%
  summarise(
    Baseline_Survey_Complete = sum(!is.na(survey1_complete)),
    Followup_Survey_Complete = sum(!is.na(survey2_complete)),
    Completion_Rate = round(
      mean(!is.na(survey2_complete), na.rm = TRUE) * 100, 1
    )
  )

print(survey_completion)

# ── Step 5: Visualization — Age Distribution ───────────────
p1 <- ggplot(ckm_data, aes(x = age)) +
  geom_histogram(
    bins = 15,
    fill = "#4A90D9",
    color = "white",
    linewidth = 0.3
  ) +
  labs(
    title = "Participant Age Distribution",
    subtitle = paste0("CKM Study — N = ", nrow(ckm_data)),
    x = "Age (years)",
    y = "Count"
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"))

ggsave("outputs/age_distribution.png", p1, width = 8, height = 5, dpi = 150)
cat("\nAge distribution plot saved.\n")

# ── Step 6: Save Baseline Summary ──────────────────────────
baseline_summary <- bind_cols(demographics, conditions, activity_summary)
write.csv(baseline_summary, "outputs/baseline_summary.csv", row.names = FALSE)
cat("Baseline summary saved to outputs/baseline_summary.csv\n")
