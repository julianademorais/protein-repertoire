#Bubbles plot

install.packages(pkgs = c("ggplot2","plotly"),
                 dependencies = T)

data <- read.csv ("https://raw.githubusercontent.com/julianademorais/protein-repertoire/main/R/top3/melanoma_tumor_top3.csv")


library(ggplot2)
library(plotly)

data <- read.csv(file.choose(), header=T, sep=";") #select file

plot_ly(data, x = data$y, y = data$x , type="scatter", mode="markers" , marker=list(color="lightblue" , size=60 , opacity=0.8) )%>%
  
  layout(title = 'Cancer type',
         xaxis = list(title = 'cc',
                      showgrid = TRUE),
         
         yaxis = list(title = 'log',
                      showgrid = TRUE),
         showlegend = FALSE)

#example of colors= pink, orange, gold, golden rod, magenta, plum, red, turquoise, navy, black
