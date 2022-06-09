
#############################################
# Ebola outbreak case study
# Script after part 1 of data cleaning module
# Your NAME here
#############################################


# Load packages -----------------------------------------------------------
pacman::p_load(
     rio,
     here,
     skimr,
     janitor,
     epikit,
     lubridate,
     tidyverse
)




# Import data -------------------------------------------------------------
surv_raw <- import(here("data", "raw", "surveillance_linelist_20141201.csv"))




# Exploratory analysis ----------------------------------------------------
# (contents may vary)

# column names
surv_raw %>% names()

# gender values
surv_raw %>% 
     tabyl(gender)

# check class of certain columns
class(surv_raw$`onset date`)

# compare consistency across two location columns
surv_raw %>% 
     tabyl(adm3_name_res, adm3_name_det)





# Clean surveillance data -------------------------------------------------
surv <- surv_raw %>% 
     
     # automatically clean column names
     clean_names() %>% 
     
     # manually clean column names   
     rename(
          date_onset = onset_date,
          date_report = date_of_report,
          district_res = adm3_name_res,
          district_det = adm3_name_det) %>%
     
     # remove unnecessary column
     select(-row_num) %>% 
     
     # de-duplicate rows  
     distinct() %>% 
     
     # convert date_onset to date class
     mutate(date_onset = mdy(date_onset)) %>% 
     mutate(date_report = mdy(date_report)) %>% 
     
     # convert age to numeric class
     mutate(age = as.numeric(age)) %>% 
     
     # convert "Unknown" gender to NA
     mutate(gender = na_if(gender, "Unknown")) %>% 
     
     # properly record missing values in many character columns
     mutate(across(.cols = where(is.character), .fns = na_if, "")) %>% 
     
     # re-code hospital column
     mutate(hospital = recode(hospital,
                              # for reference: OLD = NEW
                              "Mitilary Hospital"  = "Military Hospital",
                              "Port"               = "Port Hospital",
                              "Port Hopital"       = "Port Hospital",
                              "St. Mark's Maternity Hospital (SMMH)" = "SMMH")) %>% 

     # recode gender
     mutate(gender = recode(gender,
                            "m" = "male",
                            "f" = "female"))

     

# Testing area ------------------------------------------------------------
# (contents may vary)
     

