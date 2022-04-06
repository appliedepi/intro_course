
# This is a demonstration of how to fix pivoting longer of columns of multiple classes.

# load packages
pacman::p_load(tidyverse)

data.frame(
  age = c(12, 35, 45, 100, 8),
  name = c("Paula", "Neale", "Amy")
)

# create data for demonstration
followup <- tribble(
  ~id, ~day1_date, ~day1_status, ~day2_date,   ~day2_status, ~day3_date,   ~day3_status,
  "A", "2022-04-01", "Healthy",  "2022-04-02", "Healthy",    "2022-04-03", "Sick",
  "B", "2022-04-01", "Healthy",  "2022-04-02", "Sick",       "2022-04-03", "Sick",
  "C", "2022-04-01", "Healthy",  "2022-04-02", "Healthy",    "2022-04-03", "Sick",
)

# review the dataset
View(followup)

# initial pivot (note dates and status values are combined into one column)
pivot_longer(
  followup,
  cols = -id,
  names_to = "Day",
  values_to = "Status")


# correct pivot
# .value is a special term. Pivoted columns are split based on a character in their name. 
pivot_longer(followup,
             cols = -id,
             names_to = c("Day", ".value"), 
             names_sep = "_")


# Now fix the column classes, and send to ggplot
pivot_longer(followup,
             cols = -id,
             names_to = c("Day", ".value"), 
             names_sep = "_") %>% 

    mutate(date = ymd(date)) %>% 
  
    ggplot(mapping = aes(x = date, y = id, color = status, shape = status, group = id))+
      geom_line()+
      geom_point()+
      scale_color_manual(
        values = c("Healthy" = "darkgreen",
                   "Sick" = "red"))+
      labs(title = "Follow-up of patients over time",
           y = "Patient ID",
           x = "Date",
           color = "Status",
           shape = "Status")

    