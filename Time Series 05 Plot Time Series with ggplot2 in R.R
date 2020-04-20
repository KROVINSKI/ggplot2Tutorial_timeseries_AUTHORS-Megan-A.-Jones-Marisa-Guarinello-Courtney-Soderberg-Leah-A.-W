

## Hello World
## Author: (Original) Megan A. Jones, Marisa Guarinello, Courtney Soderberg, Leah A. Wasser (Contributor) Michael Patterson
## Notes by: K.Rovinski
## Title:Time Series 05: Plot Time Series with ggplot2 in R
## Date: April 2020


#*********************************
##Libraries
#*********************************
library(lubridate)
library(ggplot2)
library(scales)
library(gridExtra)
library(ggthemes)

#*********************************
##Setting the working directory 
#*********************************

setwd("/Users/katherinerovinski/GIT/ggplot2Tutorial_timeseries_AUTHORS-Megan-A.-Jones-Marisa-Guarinello-Courtney-Soderberg-Leah-A.-W")

#*********************************
## 1.0) Step One Project Start
#*********************************

## NEON learning tutorial narrative: 
# Plotting Time Series Data
#Plotting our data allows us to quickly see general patterns including outlier points and trends. Plots are also a useful way to communicate the results of our research. ggplot2 is a powerful R package that we use to create customized, professional plots.
 
# Load the Data
# We will use the lubridate, ggplot2, scales and gridExtra packages in this tutorial.

# Our data subset will be the daily meteorology data for 2009-2011 for the NEON Harvard Forest field site (NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv). If this subset is not already loaded, please load it now.


#*********************************
## 2.0) Read in Data
#*********************************

# daily HARV met data, 2009-2011
harMetDaily.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv",
  stringsAsFactors = FALSE)