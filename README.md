
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Introduction to R for Applied Epidemiology

<img src = "https://github.com/appliedepi/epiRhandbook_eng/raw/master/images/Applied_Epi_logo.png" height = "200" align = "right">

[This website](https://appliedepi.github.io/intro_course) hosts training
materials for “Introduction to R for Applied Epidemiologists”. This
course teaches the fundamentals of R for applied epidemiologists and
public health practitioners.

[**Applied Epi**](www.appliedepi.org) is a nonprofit organization
supporting frontline practitioners through open-course analytical tools,
training, and support. Our [Epidemiologist R
Handbook](www.epirhandbook.com) is a free R reference manual which has
been used by 130,000 people around the world.

# Course outline

Click here to download the course outline (PDF)

# Course folder and case study data

[Click
here](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/appliedepi/intro_course/tree/main/intro_course)
to download a zipped folder to use in the course exercises.

**Unzip the folder and save it on your computer (not on a shared
drive).** You will receive further instructions in the course.

# Course exercises

THESE ARE DRAFTS

The course utilizes the R package {learnr} to provide interactive
exercises *within* your RStudio window. To access these custom
exercises, follow these instructions:

1)  Set up R and RStudio (we will provide instructions and
    troubleshooting before the course)

2)  Run these commands in your R console:  
    `install.packges("learnr")`  
    `install.packages("remotes")`

3)  Run this command in your R console:  
    `remotes::install_github("appliedepi/introexercises", dep = TRUE, force = TRUE)`  
    Follow any prompted instructions regarding necessary updates

4)  To open an exercise, Click on the “Tutorial” tab in the upper-right
    RStudio pane (which also contains a tab holding your R
    Environment).  

-   the first time, you may need to restart your R session for the
    tutorials to appear.

5)  Select the exercise for your current course module - look for the
    name “Applied Epi -”.  

-   You can proceed with the exercise in this pane, or click the small
    icon to expand this tutorial into a separate window.  
-   Watch the gif below. The exercise will provide sample code that you
    can run from your R script.  
-   Return to the exercise to answer quiz questions and proceed to the
    next section of the exercise.

<img src="images/README_images/exercise_demo.gif" width="100%" />

# Course slides

<!-- badges: start -->
<!-- badges: end -->

THESE ARE DRAFTS

**Module 1: Introduction to R**  
- [Slides: Welcome, course logistics, RStudio, and basic R
syntax](https://appliedepi.github.io/intro_course/modules/module_1/slides/course_introduction/slides_course_introduction.html)

-   Exercise:

<img src="images/README_images/pointer_tutorial_setup.png" width="50%" />

**Module 2: Data cleaning**  
- [Slides: Tidy data and data
cleaning](https://appliedepi.github.io/intro_course/modules/module_2/slides/slides_cleaning_dplyr/slides_cleaning_dplyr.html)

-   Exercise:

<img src="images/README_images/pointer_tutorial_cleaning.png" width="50%" />

**Module 3: Grouping data and making summary tables**  
- [Slides: Grouping and summarizing
data](https://appliedepi.github.io/intro_course/modules/module_3/slides/slides_summary_tables/slides_grouping_summaries.html)

-   Exercise:

<img src="images/README_images/pointer_tutorial_grouping.png" width="50%" />

**Module 4: Data visualization with {ggplot2}**  
- [Slides: Data visualization with
ggplot2](https://appliedepi.github.io/intro_course/modules/module_4/slides/slides_ggplot_basics/slides_ggplot_basics.html)

-   Exercise:

<img src="images/README_images/pointer_tutorial_ggplot_basics.png" width="50%" />

-   [Slides: Scales, themes, and
    labels](https://appliedepi.github.io/intro_course/modules/module_4/slides/slides_ggplot_scales_labels/slides_ggplot_scales_labels.html)

-   Exercise:

<img src="images/README_images/pointer_tutorial_ggplot_scales.png" width="50%" />

**Module 5: Transforming data**  
- [Slides: Joining
data](https://appliedepi.github.io/intro_course/modules/module_5/slides/slides_joins/slides_joins.html)  
- [Slides: Pivoting
data](https://appliedepi.github.io/intro_course/modules/module_5/slides/slides_pivots/slides_pivots.html)

**Module 6: More data visualization with {ggplot2}**  
- [Slides: Epidemic curves in ggplot2]() TODO  
- [Slides: Heat plots in ggplot2]() TODO  
- [Slides: Age/sex pyramids in ggplot2]() TODO  
- [Slides: GIS
demonstration](https://appliedepi.github.io/intro_course/modules/module_6/slides/slides_gis_demo/slides_gis_demo.html)

**Module 7:**  
- [Slides: R markdown and routine reports]() TODO

**Module 8:**  
- [Slides: COVID case study]() TODO  
- [Slides: Code review]() TODO

Please note that all these training materials use *fake example data* in
which no person is identifiable and the actual values have been
scrambled.

# Acknowledgements

Instructors and authors from **Applied Epi** included:

-   
-   

The Fulton County Board of Health graciously provided example data
(anonymized and scrambled) for a case study.  
The {outbreaks} package formed the basis for the fake dataset in the
Ebola case study.

# Terms of Use and License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This
work is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative
Commons Attribution-NonCommercial-ShareAlike 4.0 International
License</a>.

Please email <contact@appliedepi.org> if you could like to use these
materials for an academic course or epidemiologist training program.

# Contribution

If you would like to make a content contribution, please contact with us
first via Github issues or by email. We are implementing a schedule for
updates and are creating a contributor guide.

Please note that the Epi R Handbook project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
