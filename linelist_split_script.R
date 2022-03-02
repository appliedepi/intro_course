# convert single EVD linelist to multiple

pacman::p_load(rio, here, lubridate, janitor, tidyverse)

linelist_raw <- import(here::here("data", "linelist_raw.xlsx"))




########################
# plot distribution of dates
ggplot(data = linelist_raw,
       aes(x = ymd(`date onset`)))+
     geom_histogram()

# filter to only the later outbreak
linelist_raw <- linelist_raw %>% 
     filter(`date onset` > as.Date("2013-06-01") | (is.na(`date onset`) & !hospital %in% c("Hospital A", "Hospital B"))) %>% 
     mutate(`hosp date` = ymd(`hosp date`))

# Re-look at the plot
ggplot(data = linelist_raw, aes(x = ymd(`date onset`)))+
     geom_histogram()



# GIS

# Import gis linelist (1000 random from the real linelist that has districts attached)
######################################################################################
ll_adm3 <- import(here("data", "linelist_cleaned_with_adm3.rds")) %>% 
     as.data.frame() %>%  # convert to get rid of geometries
     select(-c(geometry, days_onset_hosp, age_cat, age_cat5, age_years)) %>% 
     
     # remove earlier outbreak
     filter(date_onset < as.Date("2014-12-01") & date_hospitalisation < as.Date("2014-12-01")) %>% 
     
     # Make Port Hospital mortality increase
     mutate(outcome = ifelse(
               str_detect(hospital, "Port") &
                    lubridate::month(date_hospitalisation) %in% 8:12 &
                    lubridate::year(date_hospitalisation) == 2014 &
                    row_number() %% 2 == 1,
               "Death",
               outcome)
     )
     
     
# check dates and epicurve
ggplot(data = ll_adm3, aes(x = ymd(date_onset)))+
     geom_histogram()

# define surveillance linelist
phase1_surv <- ll_adm3 %>%
     select(-c(date_hospitalisation, time_admission, outcome, date_outcome, date_infection, infector, source, generation, ct_blood)) %>%
     mutate(adm3_name_det = ifelse(row_number() %% 20 == 1, "Central II", admin3name)) %>%   # Assign 1/20 with a different district of detection
     mutate(admin3name = ifelse(row_number() %% 60 == 1, NA, admin3name)) %>%                # Assign 1/60 with missing district of detection
     mutate(case_def = ifelse(row_number() %% 100 == 1, "Suspect", "Confirmed")) %>%         # Assign 1/100 as suspect
     
     rename(
          "onset date" = date_onset,        # make column names messy
          "age unit" = age_unit,
          "wt (kg)" = wt_kg,
          "ht (cm)" = ht_cm,
          adm3_name_res = admin3name
          ) 

# define medical linelist
phase1_med <- ll_adm3 %>% 
     select(hospital, case_id, age, age_unit, gender, date_hospitalisation, time_admission, outcome, date_outcome) %>% 
     rename(
          "age unit" = age_unit,
          "hospitalisation date" = date_hospitalisation,
          "admission time" = time_admission,
          "outcome date" = date_outcome)
     
# make case investigation dataset
phase1_source <- ll_adm3 %>% 
     select(case_id, date_infection, infector, source, generation) %>% 
     rename(
          "age unit" = age_unit,
          "infection date" = date_infection)
          
# make lab dataset
phase1_lab <- ll_adm3 %>% 
     select(case_id, ct_blood) %>% 
     rename(
          "Blood CT" = ct_blood)

# EXPORT
########
export(phase1_surv, here("data", "surveillance_linelist_12012014.xlsx"))
export(phase1_med, here("data", "medical_linelist_12012014.xlsx"))
export(phase1_lab, here("data", "lab_results_12012014.xlsx"))
export(phase1_source, here("data", "case_investigations_12012014.xlsx"))
export(phase1_surv, here("data", "district_populations.xlsx"))


# convert medical linelist into split data frames and export

med_list <- phase1_med %>% 
     group_split(hospital)

names(med_list) <- med_list %>%   # Assign to names of listed data frames 
     # Extract the names by doing the following to each data frame: 
     map(.f = ~pull(.x, hospital)) %>%        # Pull out hospital column
     map(.f = ~as.character(.x)) %>%          # Convert to character, just in case
     map(.f = ~unique(.x))                    # Take the unique hospital name

names(med_list) %>%
     map(.f = ~export(med_list[[.x]], file = str_glue("{here('data')}/{.x}.csv")))






# CFR plot
##########
ll_adm3 %>% 
     group_by(hospital, week = floor_date(date_hospitalisation, unit = "week")) %>% 
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




###########
### OLD ###
###########






### Spatial Join
################
# Create sf object
linelist_sf <- linelist_raw %>%
     drop_na(lon, lat) %>% 
     sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)

class(linelist_sf)

# ADM3 level clean
sle_adm3_raw <- sf::read_sf(here("data", "shp", "sle_adm3.shp"))

sle_adm3 <- sle_adm3_raw %>%
     clean_names() %>% # standardize column names
     filter(admin2name %in% c("Western Area Urban", "Western Area Rural")) # filter to keep certain areas

# join the administrative boundary file to the linelist, based on spatial intersection
linelist_adm <- linelist_sf %>% 
     sf::st_join(sle_adm3, join = st_intersects)



###############################
# Port Hospital mortality surge
# pre-edit CFR by week
linelist_raw %>% 
     tabyl(hospital, outcome) %>% 
     adorn_percentages() %>% 
     adorn_pct_formatting()


# Make pot hospital more deadly in certain months of 2014
linelist_raw <- linelist_raw %>% 
        mutate(

          outcome = ifelse(
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
     
     mutate(CFR = ifelse(cases < 5, NA, CFR)) %>% 
     
     ggplot(aes(x = week, y = hospital, fill = CFR))+
          geom_tile()



############################################################
# OUTBREAK PHASE 1
# Cut linelist to cases hospitalised before 1 September 2014
############################################################

linelist1 <- linelist_raw %>% 
     filter(`date onset` < ymd("2014-09-01") &
            `hosp date` < ymd("2014-09-01"))

ggplot(data = linelist1,
       aes(x = ymd(`date onset`)))+
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