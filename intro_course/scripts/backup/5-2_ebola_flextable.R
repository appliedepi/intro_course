

# Packages ----------------------------------------------------------------
pacman::p_load(
  rio,            # import/export
  here,           # file pathways
  flextable,      # make HTML tables
  scales,         # helper functions
  officer,        # helper functions for nice tables
  tidyverse)      # data management, summary, and visualization


# Import data -------------------------------------------------------------
surv <- import(here("data", "clean", "backup", "surveillance_linelist_clean_20141201.rds"))


# define border style -----------------------------------------------------
border_style = officer::fp_border(color="black", width=1)


# Create table -----------------------------------------------------------
vom_ftable <- surv %>% 
  group_by(hospital) %>%                                     # get statistics for each hospital
  summarise(
    n_cases   = n(),                                         # number of rows (cases)
    vomit_n   = sum(vomit == "yes", na.rm=T),                # number vomiting
    vomit_pct = percent(vomit_n / n_cases)) %>%              # percent vomiting
 
  # convert to flextable
  qflextable() %>% 

  add_header_row(
    top = TRUE,                             # new header on top of existing header
    colwidths = c(1,1,2),                   # span the 4 columns
    values = c("Hospital",                  # values for new header
               "Total cases", 
               "Cases with vomiting")) %>%  # This will span 2 columns

  # Merge cells and fix alignment
  align(part = "all", align = "center", j = c(2:4)) %>%   # center text in columns 2-4
  merge_at(i = 1:2, j = 1, part = "header") %>%           # merge vertically the 'hospital' title in column 1

  # Re-label secondary headers
  set_header_labels(hospital  = "", 
                    n_cases   = "No.",                                         
                    vomit_n   = "No.",                           
                    vomit_pct = "Percent of total") %>% 


  # Change background for specific columns of interest
  # - for example if we want the reader to focus on percent vomiting
  bg(part = "all", j=4, bg = "gray95") %>%   # Highlight the 4th column

  # Change background conditionally - say we want to highlight when >= 50% of cases have vomiting
  bg(., j= 4, i= ~ vomit_pct >=50, part = "body", bg = "#91c293") %>%  # The squiggle shows that this is conditional, when the row ('i') value within vomit_pct is >=50, and the colouring only affects j=4 (you could remove the j=4 to highlight the whole row)

  # Main headers are bold
  bold(i = 1, bold = TRUE, part = "header") # Header text is bold



# Save
save_as_docx(vom_ftable, path = here("outputs", "hospital_table.docx"))


