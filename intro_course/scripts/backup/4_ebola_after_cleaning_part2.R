
#############################################
# Ebola outbreak case study
# Script after the second data cleaning exercise
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
                            "f" = "female")) %>% 
     
     # convert negative weight values to NA
     mutate(wt_kg = ifelse(wt_kg < 0, NA, wt_kg))  %>% 
     
     # create case definition
     mutate(case_def = case_when(
          lab_confirmed == TRUE             ~ "Confirmed",
          epilink == "yes" & fever == "yes" ~ "Suspect",
          TRUE                              ~ "To investigate")) %>% 
     
     # create age-in-years
     mutate(age_years = case_when(
          age_unit == "months" ~ age/12,   # if age is given in months
          age_unit == "years"  ~ age,      # if age is given in years
          is.na(age_unit)      ~ age)) %>% # if unit missing assume years, else NA
     
     # create age category column
     mutate(age_cat = age_categories(         # create new column
          age_years,                             # numeric column to make groups from
          lower = 0,
          upper = 70,
          by = 10)) %>% 
     
     # Make date-difference column  
     mutate(diff = date_report - date_onset) %>% 
     
     # create column marking TRUE if district of residence and detection differ
     mutate(moved = district_res != district_det) %>% 
     
     # create new column that prioritizes district of detection
     mutate(district = coalesce(district_det, district_res)) %>% 
     
     # remove suspect cases
     filter(case_def == "Confirmed") %>% 
     
     # re-arrange columns
     select(case_id, starts_with("date"), diff, gender, age, age_unit, age_years, age_cat, hospital, district, district_res, district_det, moved, everything())
     

# Testing area ------------------------------------------------------------
# (contents may vary)



# Export clean surveillance dataset ---------------------------------------
rio::export(surv, here("data", "clean", "surveillance_linelist_clean_20141201.rds"))

