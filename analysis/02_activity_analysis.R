# ============================================================
# Script 2: Physical Activity Analysis — Pre vs Post
# CKM Physical Activity Study
# PI: Dr. Navin Kaushal | Indiana University Indianapolis
# Analyst: Poojitha Garlapati
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

# Load data
ckm_data <- read.csv("data/ckm_baseline.csv", stringsAsFactors = FALSE)

cat("Participants with complete data:", nrow(ckm_data), "\n")

# ── Step 1: Pre vs Post Activity Comparison ─────────────────
cat("\n── Pre vs Post Physical Activity ──────────────────\n")

activity_comparison <- ckm_data %>%
  filter(
    !is.na(baseline_steps) &
    !is.na(followup_steps)
  ) %>%
  summarise(
    N = n(),
    Mean_Baseline_Steps  = round(mean(baseline_steps), 0),
    Mean_Followup_Steps  = round(mean(followup_steps), 0),
    Mean_Change_Steps    = round(mean(followup_steps - baseline_steps), 0),
    Mean_Baseline_Active = round(mean(baseline_active_min), 1),
    Mean_Followup_Active = round(mean(followup_active_min), 1),
    Mean_Change_Active   = round(
      mean(followup_active_min - baseline_active_min), 1
    )
  )

print(activity_comparison)

# ── Step 2: Paired T-Test ───────────────────────────────────
cat("\n── Statistical Testing ────────────────────────────\n")

complete_data <- ckm_data %>%
  filter(!is.na(baseline_steps) & !is.na(followup_steps))

# Steps comparison
steps_test <- t.test(
  complete_data$followup_steps,
  complete_data$baseline_steps,
  paired = TRUE
)

cat("Daily Steps — Paired T-Test:\n")
cat("  Mean difference:", round(steps_test$estimate, 0), "steps\n")
cat("  t-statistic:", round(steps_test$statistic, 3), "\n")
cat("  p-value:", round(steps_test$p.value, 4), "\n")
cat("  Significant:", ifelse(steps_test$p.value < 0.05, "Yes", "No"), "\n")

# Active minutes comparison
active_test <- t.test(
  complete_data$followup_active_min,
  complete_data$baseline_active_min,
  paired = TRUE
)

cat("\nActive Minutes — Paired T-Test:\n")
cat("  Mean difference:", round(active_test$estimate, 1), "minutes\n")
cat("  t-statistic:", round(active_test$statistic, 3), "\n")
cat("  p-value:", round(active_test$p.value, 4), "\n")
cat("  Significant:", ifelse(active_test$p.value < 0.05, "Yes", "No"), "\n")

# ── Step 3: Subgroup Analysis by CKM Severity ──────────────
cat("\n── Subgroup Analysis by CKM Severity ─────────────\n")

subgroup_analysis <- ckm_data %>%
  group_by(ckm_severity) %>%
  summarise(
    N = n(),
    Mean_Baseline_Steps = round(mean(baseline_steps, na.rm = TRUE), 0),
    Mean_Followup_Steps = round(mean(followup_steps, na.rm = TRUE), 0),
    Mean_Change         = round(
      mean(followup_steps - baseline_steps, na.rm = TRUE), 0
    ),
    Pct_Improved        = round(
      mean(followup_steps > baseline_steps, na.rm = TRUE) * 100, 1
    )
  )

print(subgroup_analysis)

# ── Step 4: Visualization — Pre vs Post Steps ───────────────
plot_data <- ckm_data %>%
  filter(!is.na(baseline_steps) & !is.na(followup_steps)) %>%
  select(participant_id, baseline_steps, followup_steps) %>%
  pivot_longer(
    cols = c(baseline_steps, followup_steps),
    names_to = "Timepoint",
    values_to = "Steps"
  ) %>%
  mutate(Timepoint = ifelse(
    Timepoint == "baseline_steps", "Baseline", "4-Week Follow-up"
  ))

p2 <- ggplot(plot_data, aes(x = Timepoint, y = Steps, fill = Timepoint)) +
  geom_boxplot(width = 0.5, alpha = 0.8) +
  geom_jitter(width = 0.1, alpha = 0.3, size = 1.5) +
  scale_fill_manual(values = c(
    "Baseline"       = "#B0B0B0",
    "4-Week Follow-up" = "#4A90D9"
  )) +
  labs(
    title = "Daily Steps: Baseline vs 4-Week Follow-up",
    subtitle = paste0("CKM Study — N = ", nrow(complete_data)),
    x = "Timepoint",
    y = "Average Daily Steps",
    caption = paste0(
      "Paired t-test: p = ",
      round(steps_test$p.value, 4)
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "none"
  )

ggsave("outputs/steps_comparison.png", p2, width = 8, height = 6, dpi = 150)
cat("\nSteps comparison plot saved.\n")

# ── Step 5: Save Results ────────────────────────────────────
write.csv(
  subgroup_analysis,
  "outputs/subgroup_analysis.csv",
  row.names = FALSE
)
cat("Subgroup analysis saved to outputs/subgroup_analysis.csv\n")
cat("\nAnalysis complete.\n")
