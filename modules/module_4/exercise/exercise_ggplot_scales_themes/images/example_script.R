
# About this script -------------------------------------------------------

# Purpose: Create a daily epidemic curve of confirmed cases
# Author: Neale Batra
# Last updated: 31 March, 2022
# Contact email: contact@appliedepi.org


# Load packages -----------------------------------------------------------
pacman::p_load(
     rio,         
     here,        
     lubridate,
     tidyverse)

# Import linelist data ----------------------------------------------------
linelist_raw <- import(here("data", "case_linelists", "linelist_clean.csv"))


# Clean the linelist ------------------------------------------------------
linelist_clean <- linelist_raw %>% 
   filter(case_def == "Confirmed") %>%        # filter to confirmed cases
   mutate(date_onset = ymd(date_onset)) %>%   # convert column to class date
   

# Plot daily case incidence -----------------------------------------------
ggplot(data = linelist_clean, mapping = aes(x = date_onset))+
     geom_histogram()


# Save epicurve as PNG ----------------------------------------------------
ggsave(here("outputs", "epicurves", "daily_incidence.png"))
