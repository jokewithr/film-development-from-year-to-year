library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(plotly)
library(glue)
library(scales)
library(DT)

library(ggplot2)
library(plotly)
library(ggthemes)

library(tidyverse)
library(lubridate)

theme_set(theme_minimal())

library(glue)
library(scales)
library(DT)

film <- read_csv("film_growth.csv")
film$worldwide_gross <- gsub(film$worldwide_gross, pattern = ",", replacement = "")
film$worldwide_gross <- substr(film$worldwide_gross, start = 2, stop = 11)
film$worldwide_gross <- gsub(film$worldwide_gross, pattern = "\\.", replacement = "")

film <- film %>%
  select(Main_Genre, imdb_rating, rank_in_year, rating, studio, title, worldwide_gross, year)

film$Main_Genre <- as.factor(film$Main_Genre)
film$rating <- as.factor(film$rating)
film$studio <- as.factor(film$studio)
film <- film %>%
  mutate(worldwide_gross = as.numeric(worldwide_gross))
