#install packages
install.packages(pkgs = c("pheatmap", "RColorBrewer"),
                 dependencies = T)

#load packages
library(pheatmap)
library(RColorBrewer)

data <- read.csv ("https://raw.githubusercontent.com/julianademorais/protein-repertoire/main/R/heatmap-staining/CBX3.csv")

#rename rows after attributes
rownames(data) <- data[,1]

#strip attribute column out
data2 <- data[,-1]

#create heatmap 
pheatmap(data2, treeheight_row=0,  treeheight_col=0,legend=FALSE, show_colnames=TRUE, fontsize=20, fontface="bold", border_color="black", 
         width=10, heigth=10, cellwidth=25, color=c("white","lightgray"), cluster_rows=FALSE, cluster_cols=FALSE) 
