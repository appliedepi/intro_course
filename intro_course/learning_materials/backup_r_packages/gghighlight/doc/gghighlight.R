## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  fig.width = 6, fig.height = 4, fig.align = "center",
  collapse = TRUE,
  comment = "#>"
)

## ----data---------------------------------------------------------------------
set.seed(2)
d <- purrr::map_dfr(
  letters,
  ~ data.frame(
      idx = 1:400,
      value = cumsum(runif(400, -1, 1)),
      type = .,
      flag = sample(c(TRUE, FALSE), size = 400, replace = TRUE),
      stringsAsFactors = FALSE
    )
)

## ----ggplot2-simple-----------------------------------------------------------
library(ggplot2)

ggplot(d) +
  geom_line(aes(idx, value, colour = type))

## ----ggplot2-filter-----------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)

d_filtered <- d %>%
  group_by(type) %>% 
  filter(max(value) > 20) %>%
  ungroup()

ggplot(d_filtered) +
  geom_line(aes(idx, value, colour = type))

## ----gghighlight-simple-------------------------------------------------------
library(gghighlight)

ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 20)

## ----gghighlight-two-conds----------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 15, mean(flag) > 0.55)

## ----gghighlight-theme--------------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 19) +
  theme_minimal()

## ----gghighlight-facet--------------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 19) +
  theme_minimal() +
  facet_wrap(~ type)

## ----bar----------------------------------------------------------------------
p <- ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_histogram() +
  gghighlight()

p

## ----bar-wrap-----------------------------------------------------------------
p + facet_wrap(~ Species)

## ----point--------------------------------------------------------------------
set.seed(10)
d2 <- dplyr::slice_sample(d, n = 20)

ggplot(d2, aes(idx, value)) +
  geom_point() +
  gghighlight(value > 0, label_key = type)

## ----predicate-example, eval=FALSE--------------------------------------------
#  max(value) > 20

## ----numeric-highlight--------------------------------------------------------
ggplot(d, aes(idx, value, colour = type)) +
  geom_line() +
  gghighlight(max(value), max_highlight = 5L)

## ----labels-------------------------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 20, use_direct_label = FALSE)

## ----labels2------------------------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 20, label_params = list(size = 10))

## ----labels3------------------------------------------------------------------
p <- ggplot(d2, aes(idx, value)) +
  geom_point(size = 4) +
  gghighlight(value > 0, use_direct_label = FALSE)

# the filtered data
p$data

p + geom_label(aes(label = type),
               hjust = 1, vjust = 1, fill = "purple", colour = "white", alpha= 0.5)

## ----gghighlight-params-------------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type), size = 5) +
  gghighlight(max(value) > 19,
              unhighlighted_params = list(size = 1, colour = alpha("pink", 0.4)))

## ----gghighlight-params-null--------------------------------------------------
ggplot(d) +
  geom_line(aes(idx, value, colour = type)) +
  gghighlight(max(value) > 19,
              # preserve colour and modify alpha instead
              unhighlighted_params = list(colour = NULL, alpha = 0.3))

## ----keep_scales, fig.show='hold'---------------------------------------------
p <- ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point()

p + gghighlight(cyl == 6)

p + gghighlight(cyl == 6, keep_scales = TRUE) + ggtitle("keep_scales = TRUE")

## ----calculate_per_facet, fig.show='hold'-------------------------------------
d <- data.frame(
  idx =   c(1, 2, 3, 4, 1, 2, 3, 4),
  value = c(10, 11, 12, 13, 4, 8, 16, 32),
  cat1 =  rep(c("a", "b"), each = 4),
  cat2 =  rep(rep(c("1-2", "3-4"), each = 2), 2),
  stringsAsFactors = FALSE
)

p <- ggplot(d, aes(idx, value, colour = cat1)) +
  geom_line() +
  facet_wrap(vars(cat2))

p +
  gghighlight(max(value) > 10)

p +
  gghighlight(max(value) > 10, calculate_per_facet = TRUE) +
  ggtitle("calculate_per_facet = TRUE")

