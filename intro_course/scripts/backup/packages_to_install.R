
# Essential R packages for the course "Introduction to R for applied epidemiology"
# Offered by Applied Epi

# If you encounter errors when trying to run this script, 
# contact your instructor of point-of-contact.


# Ensures the package "pacman" is installed
if (!require("pacman")) install.packages("pacman")


# Packages available from CRAN
##############################
pacman::p_load(
     
     # learning R
     ############
     learnr,   # interactive tutorials
     
     # project and file management
     #############################
     here,     # file paths relative to R project root folder
     rio,      # import/export of many types of data

     # package install and management
     ################################
     remotes,  # install from github
     
     # general data management
     #########################
     tidyverse,    # includes many packages for tidy data wrangling and presentation
     lubridate,    # dates and times
     stringr,      # handling characters
     epitrix,      # useful epi functions
     
     
     # tables and statistics  
     #######################
     janitor,      # tables and data cleaning
     gtsummary,    # making descriptive and statistical tables

     # plots - general
     #################
     #ggplot2,         # included in tidyverse
     cowplot,          # combining plots  
     RColorBrewer,     # color scales
     gghighlight,      # highlight a subset
     ggrepel,          # smart labels
     ggExtra,          # fancy plots  
     tsibble,          # epiweeks
     viridis,          # colorblind-friendly scales
     scales,           # helper functions
     apyramid,         # age and sex pyramids
     
     # routine reports
     #################
     rmarkdown,        # produce PDFs, Word Documents, Powerpoints, and HTML files

     # tables for presentation
     #########################
     knitr,            # R Markdown report generation and html tables
     flextable)        # HTML tables
     