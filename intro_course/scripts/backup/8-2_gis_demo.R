


# Load packages -----------------------------------------------------------
pacman::p_load(
  sf,            ## for working with geospatial data
  ggspatial,     ## for basemaps and north arrows
  tidyverse
)


# Import data -------------------------------------------------------------

# import linelist
combined <- import(here("data", "clean", "backup", "linelist_combined_20141201.rds"))

## import shapefile 
shapefile <- read_sf(here("data", "shp", "sle_adm3.shp"))



# Filter data -------------------------------------------------------------

## districts we are interested in 
districts <- combined %>% 
  distinct(admin3pcod) %>% 
  drop_na() %>% 
  pull()

## filter shapefile for districts of interest 
shapefile <- shapefile %>% 
  filter(admin3Pcod %in% districts)


# Basic plot of the district shapes ---------------------------------------
## open up a ggplot
shape_plot <- ggplot() + 
  
  ## add the shapefile on top
  geom_sf(data = shapefile, 
          fill = NA,         # no fill
          colour = "black")  # black borders
# print
shape_plot



############# POINTS  ##########################################################

combined_sf <- combined %>% 
  drop_na(lat, lon) %>% 
  st_as_sf(                                               
    # define the coordinates based on lat/long variables
    coords = c("lon", "lat"),                             
    # set the coordinate reference system to WGS84
    crs = 4326,                                           
    # do not change string variables to factors 
    stringsAsFactors = FALSE                              
  )

# view the first 10 rows, first 5 columns, and the the geometry column
combined_sf %>% 
  select(1:5, geometry)

## plot points on the district shapes
shape_plot + 
  geom_sf(data = combined_sf)+
  labs(title = "Case locations")


## plot points on the district shapes, colored by outcome
shape_plot + 
     geom_sf(data = combined_sf,
             mapping = aes(color = fct_explicit_na(outcome)))+
     labs(color = "Outcome",
          title = "Case locations, by outcome")

############# CHOROPLETHS ####################################################

## get counts of cases by district
case_counts <- combined %>%
  count(admin3pcod, name = "counts")



## add case counts to the districts shapefile 
shapefile <- left_join(shapefile, case_counts, by = c("admin3Pcod" = "admin3pcod"))

# look at the districts shapefile and see the new column
View(shapefile)

## plot choropleth 
ggplot() + 
  ## add the shapefile on top
  geom_sf(data = shapefile, 
          # fill by case count
          aes(fill = counts),
          # black borders
          colour = "black")



############ BASE MAPS #########################################################



# get the bounding box for the shapefile 
bounding_box <- shapefile %>% 
  st_bbox()


# plot a base map including scale bar 
basemap <- ggplot() +
  # change the bounding box to an sf object
  # this defines the area to download map tiles for
  geom_sf(data = st_as_sfc(bounding_box)) +
  # download map tiles and add to the plot
  annotation_map_tile(
    # define what map tiles to use
    type =  "cartolight",
    # define folder to store tile images 
    cachedir = here::here("data", "map_tiles"),
    # define if should download tiles each time
    forcedownload = FALSE,
    # hide messages about download status and zoom
    progress = "none" )


# show basemap
basemap

# plot cases on top of basemap
basemap + 
  ## add the shapefile on top
  geom_sf(data = shapefile, 
          # no fill
          fill = NA,
          # black borders
          colour = "black") + 
  geom_sf(data = combined_sf,
          mapping = aes(color = fct_explicit_na(outcome)))+
  labs(color = "Outcome",
       title = "Case locations, by outcome")

          
# plot cases on top of basemap
basemap + 
  ## add the shapefile on top
  geom_sf(data = shapefile, 
          # no fill
          fill = NA,
          # black borders
          colour = "black") + 
  geom_sf(data = combined_sf,
          mapping = aes(color = fct_explicit_na(outcome)))+
  labs(color = "Outcome",
       title = "Case locations, by outcome and month")+
  facet_wrap(~month(date_onset, label = TRUE))
