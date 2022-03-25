## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo = FALSE------------------------------------------------------------
library(basket)
vw <- vemu_wide
names(vw) <- c("Basket", "Enrolled", "Evauable", "Responders", "Prior Thrpy <= 1", "Prior Thrpy = 2", "Prior Thrpy >= 3")
knitr::kable(vw)

## ---- eval = FALSE------------------------------------------------------------
#  # Load the basket library.
#  library(basket)
#  
#  # Load the vemurafenib data.
#  data(vemu_wide)
#  
#  # Perform the analysis.
#  vemu_basket <- basket(responses = vemu_wide$responders,
#                        size = vemu_wide$evaluable,
#                        name = vemu_wide$baskets,
#                        cluster_analysis = TRUE,
#                        p0 = 0.15)
#  
#  # Show the trial diagnostics.
#  summary(vemu_basket)

## ---- eval = TRUE, echo = FALSE, message = FALSE, warning = FALSE-------------
# Load the basket library.
library(basket)

# vemu_basket$basket$samples <- vemu_basket$basket$samples[1:5000,]
# vemu_basket$cluster$samples[[1]] <- vemu_basket$cluster$samples[[1]][1:2000]
# vemu_basket$cluster$samples[[2]] <- vemu_basket$cluster$samples[[2]][1:4000]
# pryr::object_size(vemu_basket)
# saveRDS(vemu_basket, "vemu-basket.rds")

vemu_basket <- readRDS("vemu-basket.rds")

# Show the trial diagnostics.
summary(vemu_basket)

## ----out.width='90%',fig.width= 8, fig.height=5,fig.align= "center"-----------
plot_density(vemu_basket$basket)

## ----out.width='100%',fig.width= 8, fig.height=5, fig.align= "center"---------
# Move the basket name labels to the left using 
# the basket_name_hoffest option
plot_mem(vemu_basket, text_size = 1.75, expand = c(0.5, 0.5), basket_name_hjust = 0.85)

