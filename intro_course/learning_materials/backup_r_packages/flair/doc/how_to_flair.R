## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>"
)

## ----setup, message = FALSE, warning = FALSE----------------------------------
library(flair)
library(dplyr)
library(ggplot2)

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))

## ---- echo = FALSE------------------------------------------------------------

decorate('

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))

') %>%
  flair("%>%")



## ----how_to_pipe, include = FALSE---------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## -----------------------------------------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## ---- echo = FALSE------------------------------------------------------------
decorate("how_to_pipe") %>% 
  flair("%>%") 

## -----------------------------------------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## -----------------------------------------------------------------------------
decorate("how_to_pipe") %>% 
  flair_funs()

## -----------------------------------------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## -----------------------------------------------------------------------------
decorate("how_to_pipe") %>% 
  flair_input_vals()

## ---- eval = FALSE------------------------------------------------------------
#  decorate('
#  
#  iris %>%
#    group_by(Species) %>%
#    summarize(mean(Sepal.Length))
#  
#  ') %>%
#    flair("%>%")

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))

## ---- echo = FALSE------------------------------------------------------------
decorate('

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))

') %>%
  flair("%>%")

## -----------------------------------------------------------------------------
mean(not_an_object)

## ---- error = TRUE------------------------------------------------------------
decorate('mean(not_an_object)',
         error = TRUE) %>%
  flair("not_an_object")

## ---- eval = FALSE------------------------------------------------------------
#  decorate_code('mean(1:10)') %>%
#    flair("(")

## ---- eval = FALSE------------------------------------------------------------
#  decorate_chunk('how_to_pipe') %>%
#    flair("%>%")

## -----------------------------------------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## -----------------------------------------------------------------------------
decorate('how_to_pipe') %>%
  flair("%>%") %>%
  flair("Sepal.Length", background = "pink") %>%
  flair("Species", color = "CornflowerBlue")

## -----------------------------------------------------------------------------

iris %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length))


## -----------------------------------------------------------------------------
decorate('how_to_pipe') %>%
  flair_lines(2:3)

## -----------------------------------------------------------------------------
ggplot(iris, aes(x = Sepal.Length, 
                y = Petal.Length, 
                color = Species)) +
  geom_point()

## ---- fig.width = 7, fig.height = 5-------------------------------------------
decorate('
ggplot(iris, aes(x = Sepal.Length, 
                y = Petal.Length, 
                color = Species)) +
  geom_point()

') %>%
  flair_args(color = "CornflowerBlue") %>%
  flair_funs(color = "Coral", underline = TRUE) %>%
  flair_input_vals(background = "Aquamarine") %>%
  flair_rx("[A-z]*\\.Length", background = "pink")

## -----------------------------------------------------------------------------
foo <- mean(1:10)

## -----------------------------------------------------------------------------

decorate('foo <- mean(1:10)') %>% 
  flair_funs()

foo + 5

## -----------------------------------------------------------------------------
mean(1:10)

## ---- error = TRUE------------------------------------------------------------
foo <- decorate('mean(1:10)') %>% 
  flair_funs()

foo + 5

