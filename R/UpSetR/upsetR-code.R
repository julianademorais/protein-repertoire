#install packages
install.packages(pkgs = c("UpSetR", "RColorBrewer"),
                 dependencies = T)

#load packages
library(UpSetR)
library(RColorBrewer)

data <- read.csv("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/all-proteins.csv")

#19 shared proteins

upset(data, nsets =9, nintersects= 4, number.angles = 1, order.by= "degree",  
      sets.bar.color= "#56B4E9",
      keep.order=TRUE,
      point.size = 3.5, line.size = 1.0, 
      mainbar.y.label = "Shared proteins", sets.x.label = "Proteins per cancer type", 
      text.scale = c(5.0, 3.5, 3.0, 3.0, 3.5, 3.5))
