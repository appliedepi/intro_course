# convert single EVD linelist to multiple

pacman::p_load(rio, here, lubridate, janitor, tidyverse)

linelist_raw <- import(here::here("data", "linelist_raw.xlsx"))

ggplot(data = linelist_cleaned,
       aes(x = date_onset))+
     geom_histogram()




###############################
# Port Hospital mortality surge
linelist_raw %>% tabyl(hospital, outcome) %>% 
     adorn_percentages() %>% 
     adorn_pct_formatting()



linelist_raw <- linelist_raw %>% 
     
     mutate(`hosp date` = ymd(`hosp date`)) %>% 
     filter(`date onset` > as.Date("2013-06-01") | (is.na(`date onset`) & !hospital %in% c("Hospital A", "Hospital B"))) %>% 
     mutate(outcome = ifelse(
          str_detect(hospital, "Port") &
          lubridate::month(`hosp date`) %in% 6:10 &
          lubridate::year(`hosp date`) == 2014 &
          row_number() %% 2 == 1,
          
          "Death",
          outcome)
          )


linelist_raw %>% tabyl(hospital, outcome) %>% 
     adorn_percentages() %>% 
     adorn_pct_formatting()



linelist_raw %>% 
     group_by(hospital, week = floor_date(`hosp date`, unit = "week")) %>% 
     summarise(
          cases = sum(!is.na(outcome)),
          death = sum(outcome == "Death", na.rm=T)) %>% 
     complete(                                  # ensure all days appear even if no cases
          week = seq.Date(                      # re-define date colume as daily sequence of dates
               from = min(week, na.rm=T), 
               to = max(week, na.rm=T),
               by = "week"),
          fill = list(n = 0)) %>% 
     mutate(CFR = death / cases) %>% 
     
     mutate(CFR = ifelse(cases < 3, NA, CFR)) %>% 
     
     ggplot(aes(x = week, y = hospital, fill = CFR))+
          geom_tile()



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