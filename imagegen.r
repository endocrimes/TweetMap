library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution points that mark out the countries.
library(mapproj)

mydata = read.csv("locations.csv")  # read csv file 
latitudes = mydata$lat # extract the latitudes
longitudes = mydata$long # extract the longitudes
count = length(latitudes)

name = paste("out_", count, "_", Sys.time(), sep="")
# svg(paste(name, ".svg", sep="")) # set where to draw to
png(paste(name, ".png", sep=""), width=2560, height=1600, res=362)

map(database="world", fill=FALSE, border=FALSE, col=28, bg=28) # draw the base
# plot.new()

addTransparency <- function(color,transparency)
{
  if (length(color)!=length(transparency)&!any(c(length(color),length(transparency))==1)) stop("Vector lengths not correct")
  if (length(color)==1 & length(transparency)>1) color <- rep(color,length(transparency))
  if (length(transparency)==1 & length(color)>1) transparency <- rep(transparency,length(color))

  num2hex <- function(x)
  {
    hex <- unlist(strsplit("0123456789ABCDEF",split=""))
    return(paste(hex[(x-x%%16)/16+1],hex[x%%16+1],sep=""))
  }
  rgb <- rbind(col2rgb(color),transparency)
  res <- paste("#",apply(apply(rgb,2,num2hex),2,paste,collapse=""),sep="")
  return(res)
}

color = "snow"
max_color = 347
for (i in 1:count) {
  # if (color >= max_color) {
  #   color = 1
  # }
  points(longitudes[i],latitudes[i],col=addTransparency(color, 0.5 * 255),pch=16, cex=.1)
  # color = color + 1
}

dev.off() # save/draw

