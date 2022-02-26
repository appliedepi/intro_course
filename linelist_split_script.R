# convert single EVD linelist to multiple

pacman::p_load(rio, here, lubriate, tidyverse)

linelist_cleaned <- import(here::here("data", "linelist_cleaned.rds"))

ggplot(data = linelist_cleaned,
       aes(x = date_onset))+
     geom_histogram()



############################################################
# OUTBREAK PHASE 1
# Cut linelist to cases hospitalised before 1 September 2014
############################################################

linelist1 <- linelist_raw %>% 
     filter(date_onset < ymd("2014-09-01") &
            date_hospitalisation < ymd("2014-09-01"))

ggplot(data = linelist1,
       aes(x = date_onset))+
     geom_histogram()

# Make Phase 1 linelists
##################################

surveillance <- linelist1 %>% 
     select(case_id, date_onset, gender, age, age_unit,
            fever, chills, cough, aches, vomit,
            lat, lon)


hospital <- linelist1 %>% 
     select(case_id, hospital, gender, age_years,
            date_hospitalisation, time_admission,
            date_outcome, outcome,
            wt_kg, ht_cm, bmi, temp)

lab <- linelist1 %>% 
     select(case_id, gender, age_years, ct_blood)

contact_tracing <- linelist1 %>% 
     select(case_id, gender, age_years, infector, date_infection, generation, source)


############################################################
# OUTBREAK PHASE 2
# Cut linelist to cases hospitalised before 1 September 2014
############################################################

linelist1 <- linelist_raw %>% 
     filter(date_onset < ymd("2014-09-01") &
                 date_hospitalisation < ymd("2014-09-01"))

ggplot(data = linelist1,
       aes(x = date_onset))+
     geom_histogram()

# Make Phase 1 linelists
##################################

surveillance <- linelist1 %>% 
     select(case_id, date_onset, gender, age, age_unit,
            fever, chills, cough, aches, vomit,
            lat, lon)


hospital <- linelist1 %>% 
     select(case_id, hospital, gender, age_years,
            date_hospitalisation, time_admission,
            date_outcome, outcome,
            wt_kg, ht_cm, bmi, temp)

lab <- linelist1 %>% 
     select(case_id, gender, age_years, ct_blood)

contact_tracing <- linelist1 %>% 
     select(case_id, gender, age_years, infector, date_infection, generation, source)





# Make Phase 2 linelists
##################################