# The Problem #

We want to look at some of the data and get to know it, using rattle.

So lest start off by examining the weather dataset.

# The Code #
  * **library(rattle)**  _Loads the Rattle package and the associated datasets into the memory._
  * **weatherAUS** _Loads in the weatherAUS dataset_


# The Exercise #

_Lets Start R_

**library(rattle)**

**rattle()**

now you should see this screen.

![http://www.g3n1u5.com/assets/images/db_images/db_RattleStartUp1.jpg](http://www.g3n1u5.com/assets/images/db_images/db_RattleStartUp1.jpg)

Click on the execute button. _(It looks like 2 Cogs)_

![http://www.g3n1u5.com/assets/images/db_images/db_RattleWeather1.jpg](http://www.g3n1u5.com/assets/images/db_images/db_RattleWeather1.jpg)

Now go to the Explore Tab, and then you will see this.

![http://www.g3n1u5.com/assets/images/db_images/db_RattleWeatherExplore1.jpg](http://www.g3n1u5.com/assets/images/db_images/db_RattleWeatherExplore1.jpg)

Now click the Histogram buttons for **Min Temp & MaxTemp & Evaporation & Sunshine**, now go to the Execute Button, and click once. _This will load in the data, and run the code to produce the charts._

![http://www.g3n1u5.com/assets/images/db_images/db_RattleWeatherExploreChart11.jpg](http://www.g3n1u5.com/assets/images/db_images/db_RattleWeatherExploreChart11.jpg)

Finally you can see all the R code that made this happen by clicking on the Log Tab.

```
# The following variable selections have been noted.

crs$input <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation",
     "Sunshine", "WindGustDir", "WindGustSpeed", "WindDir9am",
     "WindDir3pm", "WindSpeed9am", "WindSpeed3pm", "Humidity9am",
     "Humidity3pm", "Pressure9am", "Pressure3pm", "Cloud9am",
     "Cloud3pm", "Temp9am", "Temp3pm", "RainToday")
crs$target <- "RainTomorrow"
crs$risk <- "RISK_MM"
crs$ident <- "Date"
crs$ignore <- "Location"

#============================================================
# Rattle timestamp: 2010-11-21 12:55:38 i386-pc-mingw32 

# Plot a Histogram 

# Generate just the data for a histogram of the variable 'MinTemp'.

ds <- rbind(data.frame(dat=crs$dataset[crs$sample,][,"MinTemp"], grp="All"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="No","MinTemp"], grp="No"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="Yes","MinTemp"], grp="Yes"))

# Plot the data.

hs <- hist(ds[ds$grp=="All",1], main="", xlab="MinTemp", ylab="Frequency", col="grey90", ylim=c(0, 82.997973880099), breaks="fd", border=TRUE)
dens <- density(ds[ds$grp=="All",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[1])
dens <- density(ds[ds$grp=="No",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[2])
dens <- density(ds[ds$grp=="Yes",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[3])

# Add a rug to the plot to highlight density distribution.

rug(ds[ds$grp=="No", 1], col=rainbow_hcl(3)[2])
rug(ds[ds$grp=="Yes", 1], col=rainbow_hcl(3)[3])

# Add a legend to the plot.

legend("topright", c("All", "No", "Yes"), bty="n", fill=rainbow_hcl(3))

# Add a title to the plot.

title(main="Distribution of MinTemp (sample)
by RainTomorrow", sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2010-11-21 12:55:39 i386-pc-mingw32 

# Plot a Histogram 

# Generate just the data for a histogram of the variable 'MaxTemp'.

ds <- rbind(data.frame(dat=crs$dataset[crs$sample,][,"MaxTemp"], grp="All"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="No","MaxTemp"], grp="No"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="Yes","MaxTemp"], grp="Yes"))

# Plot the data.

hs <- hist(ds[ds$grp=="All",1], main="", xlab="MaxTemp", ylab="Frequency", col="grey90", ylim=c(0, 76.173645092428), breaks="fd", border=TRUE)
dens <- density(ds[ds$grp=="All",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[1])
dens <- density(ds[ds$grp=="No",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[2])
dens <- density(ds[ds$grp=="Yes",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[3])

# Add a rug to the plot to highlight density distribution.

rug(ds[ds$grp=="No", 1], col=rainbow_hcl(3)[2])
rug(ds[ds$grp=="Yes", 1], col=rainbow_hcl(3)[3])

# Add a legend to the plot.

legend("topright", c("All", "No", "Yes"), bty="n", fill=rainbow_hcl(3))

# Add a title to the plot.

title(main="Distribution of MaxTemp (sample)
by RainTomorrow", sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2010-11-21 12:55:39 i386-pc-mingw32 

# Plot a Histogram 

# Generate just the data for a histogram of the variable 'Evaporation'.

ds <- rbind(data.frame(dat=crs$dataset[crs$sample,][,"Evaporation"], grp="All"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="No","Evaporation"], grp="No"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="Yes","Evaporation"], grp="Yes"))

# Plot the data.

hs <- hist(ds[ds$grp=="All",1], main="", xlab="Evaporation", ylab="Frequency", col="grey90", ylim=c(0, 58.2043400577867), breaks="fd", border=TRUE)
dens <- density(ds[ds$grp=="All",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[1])
dens <- density(ds[ds$grp=="No",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[2])
dens <- density(ds[ds$grp=="Yes",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[3])

# Add a rug to the plot to highlight density distribution.

rug(ds[ds$grp=="No", 1], col=rainbow_hcl(3)[2])
rug(ds[ds$grp=="Yes", 1], col=rainbow_hcl(3)[3])

# Add a legend to the plot.

legend("topright", c("All", "No", "Yes"), bty="n", fill=rainbow_hcl(3))

# Add a title to the plot.

title(main="Distribution of Evaporation (sample)
by RainTomorrow", sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2010-11-21 12:55:39 i386-pc-mingw32 

# Plot a Histogram 

# Generate just the data for a histogram of the variable 'Sunshine'.

ds <- rbind(data.frame(dat=crs$dataset[crs$sample,][,"Sunshine"], grp="All"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="No","Sunshine"], grp="No"),
            data.frame(dat=crs$dataset[crs$sample,][crs$dataset[crs$sample,]$RainTomorrow=="Yes","Sunshine"], grp="Yes"))

# Plot the data.

hs <- hist(ds[ds$grp=="All",1], main="", xlab="Sunshine", ylab="Frequency", col="grey90", ylim=c(0, 43.0115097689253), breaks="fd", border=TRUE)
dens <- density(ds[ds$grp=="All",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[1])
dens <- density(ds[ds$grp=="No",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[2])
dens <- density(ds[ds$grp=="Yes",1], na.rm=TRUE)
rs <- max(hs$counts)/max(dens$y)
lines(dens$x, dens$y*rs, type="l", col=rainbow_hcl(3)[3])

# Add a rug to the plot to highlight density distribution.

rug(ds[ds$grp=="No", 1], col=rainbow_hcl(3)[2])
rug(ds[ds$grp=="Yes", 1], col=rainbow_hcl(3)[3])

# Add a legend to the plot.

legend("topright", c("All", "No", "Yes"), bty="n", fill=rainbow_hcl(3))

# Add a title to the plot.

title(main="Distribution of Sunshine (sample)
by RainTomorrow", sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))
```


