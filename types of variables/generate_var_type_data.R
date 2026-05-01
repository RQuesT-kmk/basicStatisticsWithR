rm(list = ls())
library(tidyverse)
id <- sprintf(fmt = "%03d",1:7) ; id
hospital <- c("A","A","A","B","B","C","33") ; hospital
date_of_birth <- as.Date(c("03/12/1929","13/04/1936",
                           "31/10/1931","11/11/1922",
                           "01/05/1946","18/02/1954","03/12/1829"),"%d/%m/%Y")
sex <- c("M","M","F","F","M","M","X")
weight_kg <- c(56.3,73.5,57.6,65.6,81.1,56.8,99)
smear_result <- c("Positive","Positive","Positive",
                  "Uncertain","Negative","Positive","")
culture_result <- c("Negative","Negative","Positive",
                    "Positive","Positive","Negative","")
skin_test_mm <- c(18,15,21,28,6,12,NA)
alive_after_6months <- c("Y","Y","N","Y","Y","Y","YY")
date_of_diagnosis <- as.Date(c("23/08/1998","12/09/1998",
                               "17/06/1999","05/07/1999",
                               "20/08/1999","17/09/1999","23/08/1998"),"%d/%m/%Y")
days_hospital <- c(3,4,5,5,6,7,NA)
TB_data <- tibble(id,hospital,date_of_birth,sex,date_of_diagnosis,weight_kg,smear_result,culture_result, skin_test_mm,alive_after_6months, days_hospital)
haven::write_dta(TB_data,"d:/docs/Burnet Statistics training/data_raw/revise.dta")

TB_data <- TB_data %>% mutate(age_at_diagnosis_year=as.integer((date_of_diagnosis-date_of_birth)/365.25))
TB_data <- TB_data %>% mutate(
  age_group = case_when(age_at_diagnosis_year < 50 ~ "Younger than 50",
                        age_at_diagnosis_year >= 50 & age_at_diagnosis_year < 60 ~ "50 - 60",
                        age_at_diagnosis_year >= 60 & age_at_diagnosis_year < 70 ~ "60 - 70",
                        age_at_diagnosis_year > 70 ~ "70 and elder")
)


haven::write_dta(TB_data,"d:/docs/Burnet Statistics training/data_raw/var_type.dta")
