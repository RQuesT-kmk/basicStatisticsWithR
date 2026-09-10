
# About -------------------------------------------------------------------

# Description: This will be use to demonstate one-sample Z test
# Author: Kaung Myat Khant
# Date: 24 Aug 2026
# Data: hypothesis_testing_example_set.csv
# Reference: Biostatistics: Foundation for analysis in health science (10ed)
# Modified: 10 Sep 2026
# =========================================================================


# Research question  ------------------------------------------------------

# Is the mean baseline systolic blood pressure of our data different from
# historical benchmark of 140 mmHg? 
# =========================================================================

# Libraries ---------------------------------------------------------------

rm(list = ls())
library(readr) # to load data
library(ggplot2) # to draw the normal distribution curve
library(dplyr) # to manipulate data
source(here::here("z_curves_for_hypothesis_testing.R")) #load my own function

# Get data ----------------------------------------------------------------

data <- read_csv(here::here("hypothesis_testing_example_set.csv"))
str(data)
sbp <- data |> select(sbp_pre) |> pull(sbp_pre)
length(sbp)
head(sbp, n = 40)
# =========================================================================


# Let do the hypothesis testing step by step ------------------------------


# 1. Data -----------------------------------------------------------------

str(sbp) ; length(sbp)
print("Data is continuous numeric data")
print("Sample size is 40.")
print("Sample size of 30 is rule of thumb for choosing test statistics.")

hist(sbp)
qqnorm(sbp)
xbar <- mean(sbp, na.rm = T) ; xbar
sd <- sd(sbp, na.rm = T) ; sd
n <- length(sbp); n
se <- sd/sqrt(n) ; se

print("Population parameter to be tested is 140 mmHg.")
mu <- 140.00; mu
print("Let our significant level to catch the true difference be 0.05")
alpha <- 0.05; alpha


# 2. Assumptions ----------------------------------------------------------

print("1. The data is normally distributed")
print("2. The patients are independent from each other(e.g., no twins)")

# 3. Hypotheses -----------------------------------------------------------

print("H0: xbar == mu") ; paste("H0: xbar =",mu)
print("HA: xbar != mu") ; paste("HA: xbar !=",mu)

# 4. Test statistics ------------------------------------------------------

print("Z = (xbar - mu)/se")

# 5. Distribution of test statistics --------------------------------------

print("If the null hypothesis is true and assumptions are met, test statistics will follow standard normal distribution.")

# 6. Decision rule --------------------------------------------------------

Z_critical <-  qnorm(1 - alpha/2) ; round(Z_critical,2)
z_curves()
paste0("If Z score < ", -round(Z_critical,2), " or ", "Z score > ", round(Z_critical,2), ", we will reject the null hypothesis.")

# 7. Calculation of test statistics ---------------------------------------

Z <- (xbar-mu)/se ; round(Z,2)

# 8. Statistical decision -------------------------------------------------

ifelse(abs(Z) > Z_critical, 
       "Computed Z score is not equal to critical value, we reject the null hypothesis.",
       "Computed Z score is equal to critical value, we fail to reject the null hypothesis.")

# 9. Conclusion -----------------------------------------------------------

print("We can conclude that the mean baseline systolic blood pressure of our data is different from historical benchmark of 140 mmHg")

# 10. p value -------------------------------------------------------------

p <- 2*pnorm(abs(Z), lower.tail = F)  ; round(p,3)

ifelse(p < alpha,
       "We have strong evidence that the mean baseline systolic blood pressure of our data is significantly different from historical benchmark of 140 mmHg",
       "We have weak evidence that the mean baseline systolic blood pressure of our data is significantly different from historical benchmark of 140 mmHg")

paste0("The smallest value of significant level for which we can reject a null hypothesis when it is true = ",
       round(p,4))

paste0("The probability of rejecting a true null hypothesis is ", round(100*p,2), "%.")


# Extra -------------------------------------------------------------------

upper_CI <- xbar + Z_critical*se; upper_CI
lower_CI <- xbar - Z_critical*se; lower_CI
mu < lower_CI || mu > upper_CI

t.test(sbp, alternative = "two.sided", mu = 140, conf.level = 0.95)
abs(qt(p= 0.05, df = 39))  # critical value of t
t.test(sbp, alternative = "two.sided", mu = 140, conf.level = 0.95)$statistic > abs(qt(p= 0.05, df = 39))  
