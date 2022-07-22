
# Essential R packages for the course "Introduction to R for applied epidemiology"
# Offered by Applied Epi (www.appliedepi.org)

# INSTRUCTIONS:
# 1. Ensure you have a good internet connection.  
# 2. Highlight ALL of the text & code in this R script (this entire document).
# 3. Click the "Run" button in the upper-right corner of this pane.
# 4. R will run for some time as it downloads the R packages to your computer.
#    You will see it processing the downloads in the "Console" below.
#    If you see the word "warning" that is generally OK.
#    If you see the word "error", something is wrong.
# 5. After the downloads finish (the ">" appears again in the Console),
#    test it by pasting the below text in the Console and pressing Enter:
#    library(tidyverse)
#    There should be no error message.
# 6. Contact your instructor with questions


# Below are R commands that automatically install the R packages

# Ensures the package "pacman" is installed
if (!require("pacman")) install.packages("pacman")


# Downloads and installs packages (if they are not already installed)
#####################################################################
pacman::p_load(
     
     # learning R
     ############
     learnr,   # interactive tutorials
     
     # project and file management
     #############################
     here,     # file paths relative to R project root folder
     rio,      # import/export of many types of data
     openxlsx, # special functions for handling Excel workbooks

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
     