border_style = officer::fp_border(color="black", width=1)


# Packages ----------------------------------------------------------------

pacman::p_load(
  rio,            # import/export
  here,           # file pathways
  flextable,      # make HTML tables 
  officer,        # helper functions for nice tables
  tidyverse)      # data management, summary, and visualization


# Import data# -------------------------------------------------------------


surv <- import(here("data", "clean", "backup", "surveillance_linelist_clean_20141201.rds"))


# Create table -----------------------------------------------------------

vom_table <- surv %>% 
  group_by(hospital) %>%                                     # get statistics for each hospital
  summarise(
    n_cases   = n(),                                         # number of rows (cases)
    vomit_n   = sum(vomit == "yes", na.rm=T),                # number vomiting
    vomit_pct = percent(vomit_n / n_cases)) %>%              # percent vomiting
  flextable::qflextable()

# formatting --------------------------------------------------------------
# Note the flextable object is refreshed throughout (rather than one big pipe) so that you can print the object and check how it looks in stages

# Add extra header
vom_ftable <- vom_table %>% 
  add_header_row(
    top = TRUE,                          # New header goes on top of existing header row
    values = c("Hospital",     
               "Total cases", 
               "Cases with vomiting",    # This will be the top-level header for this and two next columns   
               ""))                      # This can be blank as will be merged with column 3 later anyway

# Merge cells and fix alignment
vom_ftable <- vom_ftable  %>% 
  merge_at(i = 1, j = 3:4, part = "header") %>%                         # Horizontally merge columns 3 to 4 in new header row
  flextable::align(., align = "center", j = c(2:4), part = "all") %>%   # Centre text in columns 2-4
  merge_at(i = 1:2, j = 1, part = "header")                             # Merge vertically the 'hospital' title in column 1

# Re-label secondary headers
vom_ftable <- vom_ftable  %>% 
  set_header_labels(hospital = "", 
                    n_cases   = "No.",                                         
                    vomit_n   = "No.",                # Note that this can be the same label as a different column!           
                    vomit_pct = "Percent of total")


# Change background for specific columns of interest - say we want the reader to focus on % vomiting
vom_ftable <- vom_ftable  %>% 
  bg(., j=4, part = "all", bg = "gray95")  # Highlight the percentage column with j=4 (note it doesn't colour the title header as it is a merged cell and not recognised as 4 )

# Change background conditionally - say we want to highlight when >= 50% of cases have vomiting
vom_ftable <- vom_ftable  %>% 
  bg(., j= 4, i= ~ vomit_pct >=50, part = "body", bg = "#91c293") # The squiggle shows that this is conditional, when the row ('i') value within vomit_pct is >=50, and the colouring only affects j=4 (you could remove the j=4 to highlight the whole row)

# Main headers are bold
vom_ftable <- vom_ftable  %>% 
  bold(i = 1, bold = TRUE, part = "header") # Header text is bold

# Save
save_as_docx(vom_ftable, path = here("outputs", "hospital_table.docx"))







