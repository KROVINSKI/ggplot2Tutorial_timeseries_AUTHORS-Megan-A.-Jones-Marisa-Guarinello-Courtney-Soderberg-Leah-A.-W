

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

# daily HARV metoerological data, 2009-2011
harMetDaily.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv",
  stringsAsFactors = FALSE)

#--# QA Check
#harMetDaily.09.11 1095 variables with 47 observations
dim(harMetDaily.09.11)
#> dim(harMetDaily.09.11)
# [1] 1095   47

names(harMetDaily.09.11)
#> names(harMetDaily.09.11)
#[1] "X"         "date"      "jd"        "airt"      "f.airt"    "airtmax"  
#[7] "f.airtmax" "airtmin"   "f.airtmin" "rh"        "f.rh"      "rhmax"    
#[13] "f.rhmax"   "rhmin"     "f.rhmin"   "dewp"      "f.dewp"    "dewpmax"  
#[19] "f.dewpmax" "dewpmin"   "f.dewpmin" "prec"      "f.prec"    "slrt"     
#[25] "f.slrt"    "part"      "f.part"    "netr"      "f.netr"    "bar"      
#[31] "f.bar"     "wspd"      "f.wspd"    "wres"      "f.wres"    "wdir"     
#[37] "f.wdir"    "wdev"      "f.wdev"    "gspd"      "f.gspd"    "s10t"     
#[43] "f.s10t"    "s10tmax"   "f.s10tmax" "s10tmin"   "f.s10tmin"


#*********************************
## 3.0) Date Objects
#*********************************
## Background on Data Values
#Dates are represented as the number of days since 1970-01-01, 
#  with negative values for earlier dates

## Example:
## use as.Date( ) to convert strings to dates
#  mydates <- as.Date(c("2007-06-22", "2004-02-13"))
# number of days between 6/22/07 and 2/13/04
# days <- mydates[1] - mydates[2]

## Tools/Functions
#  Sys.Date( ) returns today's date.
#  date() returns the current date and time

#Symbol 	#Meaning	              #Example
# %d	    day as a number (0-31)	01-31

# %a      abbreviated weekday     Mon
# %A	    unabbreviated weekday	  Monday

# %m	    month (00-12)	          00-12
# %b      abbreviated month       Jan
# %B	    unabbreviated month     January

# %y      2-digit year            07
# %Y	    4-digit year            2007


## 3.1 Converting to Date Class (managing the correct format)

# covert date to Date class
# date is the second column on the harMetDaily.09.11 dataframe- object are being created based on the values in that column
harMetDaily.09.11$date <- as.Date(harMetDaily.09.11$date)
factor(harMetDaily.09.11$date)
## Results
# 1095 Levels: 2009-01-01 2009-01-02 2009-01-03 2009-01-04 2009-01-05 ... 2011-12-31
class(harMetDaily.09.11$date)

# monthly HARV temperature data, 2009-2011
harTemp.monthly.09.11<-read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Temp_HARV_Monthly_09_11.csv",
  stringsAsFactors=FALSE
)


# datetime field is actually just a date 
#str(harTemp.monthly.09.11) 


## 3.2 Converting to Date Class for temperature data (actually going from chr to date class)

# convert datetime from chr to date class & rename date for clarification
harTemp.monthly.09.11$date <- as.Date(harTemp.monthly.09.11$datetime)
class(harTemp.monthly.09.11$date)
## Results
# > class(harTemp.monthly.09.11$date)
# [1] "Date"


#*********************************
## 4.0) Plotting with qplot
#*********************************
# Plot with qplot
# We can use the qplot() function in the ggplot2 package to quickly plot a variable
# the qplot, example: air temperature (airt) across all three years of daily average time series data

## Examining the qplot function
# function (x, y, ..., data, facets = NULL, margins = FALSE, geom = "auto", 
#          xlim = c(NA, NA), ylim = c(NA, NA), log = "", main = NULL, 
#          xlab = NULL, ylab = NULL, asp = NA, stat = NULL, position = NULL) 
#{


# plot air temp
qplot(x=date, y=airt,
      data=harMetDaily.09.11, na.rm=TRUE,
      main="Air temperature Harvard Forest\n 2009-2011",
      xlab="Date", ylab="Temperature (°C)")


#The resulting plot displays the pattern of air temperature 
# air temp increasing and decreasing over three years. 
# While qplot() is a quick way to plot data, 
# our ability to customize the output is limited.



#*********************************
## 4.0) Plotting with ggplot
#*********************************

##Plot with ggplot
##The ggplot() function within the ggplot2 package gives us more control over plot appearance
## However, to use ggplot we need to learn a slightly different syntax. 
        # Three basic elements are needed for ggplot() to work:

# 1 of 3 Syntax Elements : First the Dataframe
# The data_frame: containing the variables that we wish to plot,

# 2 of 3 Syntax Elements : aesthetics, mapping x & Y.. axes
# aes (aesthetics): which denotes which variables will map to the x-, y- (and other) axes,

# 3 of 3 geometry graphical representation - Points | Bars | Lines
# geom_XXXX (geometry): which defines the data's graphical representation (e.g. points (geom_point), bars (geom_bar), lines (geom_line), etc).


#The syntax begins with the base statement that includes 
  # the data_frame (harMetDaily.09.11) 
  # and associated x (date) and y (airt) variables to be plotted:

# ggplot(harMetDaily.09.11, aes(date, airt))

# To successfully plot, the last piece that is needed is the geometry type. 
  # In this case, we want to create a scatterplot so we can add + geom_point().


# plot Air Temperature Data across 2009-2011 using daily data
ggplot(harMetDaily.09.11, aes(date, airt)) +
  geom_point(na.rm=TRUE)



#*********************************
## 5.0) Customize a Scatterplot
#*********************************
# Customize A Scatterplot
# We can customize our plot in many ways. 
  # For instance, we can change the size and color of the points 
      #using size=, shape pch=, and color= in the geom_point element.
          #example: 
              # geom_point(na.rm=TRUE, color="blue", size=1)

# plot Air Temperature Data across 2009-2011 using daily data
ggplot(harMetDaily.09.11, aes(date, airt)) +
  geom_point(na.rm=TRUE, color="blue", size=3, pch=18)




#*********************************
## 6.0) Plot Objects
#*********************************
# Name Plot Objects
# We can create a ggplot object by assigning our plot to an object name
# When we do this, the plot will not render automatically. 
# To render the plot, we need to call it in the code.

# Assigning plots to an R object allows us to 
#     effectively add on to, and 
#       modify the plot later 

# Let's create a new plot and call it AirTempDaily.
# plot Air Temperature Data across 2009-2011 using daily data
AirTempDaily <- ggplot(harMetDaily.09.11, aes(date, airt)) +
  geom_point(na.rm=TRUE, color="purple", size=1) + 
  ggtitle("Air Temperature\n 2009-2011\n NEON Harvard Forest") +
  xlab("Date") + ylab("Air Temperature (C)")

# render the plot
AirTempDaily


#*********************************
## 7.0) X axis Formating (Date)
#*********************************




