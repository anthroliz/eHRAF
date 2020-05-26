
# Load Libraries
library(dplyr)
library(tidyr)
library(stringr)
library(leaflet) # interactive mapping

# read in data
# the data hraf_map.js is taken directly from javascript at https://ehrafworldcultures.yale.edu/ehrafe/mapCultures.do
raw_js = read.delim(
  'hraf_map.js',
  sep = '\t',
  skip = 7,
  stringsAsFactors = F,
  header = F
)

#string manupulation to convert js script into tibble dataframe
raw_js %>%
  as.tbl() %>%
  select(V2) %>%
  filter(str_detect(V2, pattern = 'owc|latitudes|longitudes')) %>%
  separate(
    V2,
    into = c('key', 'index', 'value'),
    sep = "\\[| = ",
    remove = T,
    convert = T,
    fill = "right"
  ) %>%
  mutate_all( ~ gsub("]|;", "", .)) %>%
  pivot_wider(names_from = key, values_from = value) -> clean_hraf


#plot interactive map using leaflet 
leaflet(data = clean_hraf) %>%
  addTiles() %>%
  addMarkers( ~ as.numeric(longitudes),
              ~ as.numeric(latitudes),
              popup = ~ owcTerms)
