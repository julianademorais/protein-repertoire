# library
library(tidyverse)

#data <- read.csv ("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/testzerocom4.csv")

data <- read.csv ("https://raw.githubusercontent.com/julianademorais/protein-repertoire/main/R/cbarplot-staining/CBX3.csv")


# Set a number of 'empty bar' to add at the end of each group
empty_bar <- 4
to_add <- data.frame( matrix(NA, empty_bar*nlevels(data$group), ncol(data)) )
colnames(to_add) <- colnames(data)
to_add$group <- rep(levels(data$group), each=empty_bar)
data <- rbind(data, to_add)
data <- data %>% arrange(group)
data$id <- seq(1, nrow(data))

# Get the name and the y position of each label
label_data <- data
number_of_bar <- nrow(label_data)
angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust <- ifelse( angle < -90, 1, 0)
label_data$angle <- ifelse(angle < -90, angle+180, angle)

# prepare a data frame for base lines
base_data=data %>% 
  group_by(group) %>% 
  summarize(start=min(id), end=max(id) - empty_bar) %>% 
  rowwise() %>% 
  mutate(title=mean(c(start, end)))

# prepare a data frame for grid (scales)
grid_data = base_data
grid_data$end = grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
grid_data$start = grid_data$start - 1
grid_data=grid_data[-1,]

# Make the plot
p <- ggplot(data, aes(x=as.factor(id), y=value, fill=individual)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", alpha=0.8) +
  ylim(-100,120) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(0,4), "cm") 
  ) +
  annotate("text", x = rep(max(data$id),5), y = c(10, 20, 30, 40, 50), label = c("1", "2", "3", "4", "5") , color="grey", size=3.0 , angle=0, fontface="bold", hjust=-2.1) +
  coord_polar() + 
  scale_fill_manual(values = c("white","#800080","#34b6db","navyblue", "#ccecf6"))+
  
  #geom_text(data=base_data, aes(x = title, y = -18, label=group), hjust=c(0.8,  0.8, 0.7,  0.5), colour = "black", alpha=0.8, size=3.0, fontface="bold", inherit.aes = FALSE)
  geom_text(data=label_data, aes(x=id, y=value+5, label=individual, hjust=hjust), color="black", fontface="bold",alpha=1.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) 

p
