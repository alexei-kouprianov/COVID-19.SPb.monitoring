################################################################
# COVID-19.SPb.monitoring data transformations script;
# nested under : spb.COVID-19.r

# Loading libraries;
library(rmarkdown)
library(rjson)
library(TeachingDemos)

# library(xlsx)

# Reading data;

source("spb.gov.loader.r")

spb.sk <- read.table("../data/SPb.stopkoronavirus_archived.csv", h = TRUE, sep = ",")
spb.gov <- read.table("../data/gov.spb.ru_archived.csv", h = TRUE, sep = ",")
# spb.PCR <- read.table("../data/SPb.PCR_tests.csv", h = TRUE, sep = ",")
spb.ynd <- read.table("../data/SPb.yandex_wordstat.weekly.csv", h = TRUE, sep = ",")
spb.gov.ext <- read.table("../data/spb.gov.v.2021-08-03.csv", h = TRUE, sep = ",")
pop.adj <- read.table("../data/land_units.population.csv", h = TRUE, sep = ",")
spb.adj.c <- read.table("../data/SPb.adjacent_countries.official_deaths.csv", h = TRUE, sep = ",")
spb.adj.r <- read.table("../data/SPb.adjacent_regions.official_deaths.csv", h = TRUE, sep = ",")
spb.adj.deaths <- read.table("../data/SPb.adjacent_regions.all_deaths.2006_.csv", h = TRUE, sep = ",")
SPb.EN.summary <- read.table("../data/SPb.EN.summary.csv", h = TRUE, sep = ",")
