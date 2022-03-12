

For ggplot slides:
NO need to repeat the slides
https://irene.vrbik.ok.ubc.ca/slides/NHSRxaringan.html?panelset1=tab-12#32

     Chunk 1
{r irisplot, echo=TRUE, fig.show='hide'}
     plot(iris[,1:2], 
          col=iris$Species, 
          pch=as.numeric(iris$Species)+17)
     
     
Chunk 2:
{r, ref.label="irisplot", echo=TRUE}



######

Try to embed shiny app in a slide, that reads Google Froms and makes plot
Alternatively, just have the app open in another tab and show it




---
     # testing a learnr embed
     
     ```{r, echo=F, out.width="100%"}
knitr::include_url("https://nealebatra.shinyapps.io/embed1/", height = "400px")
```
