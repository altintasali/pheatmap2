justify <- function(x, hjust="center", vjust="center", draw=TRUE){
  w <- sum(x$widths)
  h <- sum(x$heights)
  xj <- switch(hjust,
               center = 0.5,
               left = 0.5*w,
               right=unit(1,"npc") - 0.5*w)
  yj <- switch(vjust,
               center = 0.5,
               bottom = 0.5*h,
               top=unit(1,"npc") - 0.5*h)
  x$vp <- viewport(x=xj, y=yj)
  if(draw) grid.draw(x)
  return(x)
}




# heatmap 
mat <- matrix(rnorm(1:100), ncol = 10)
rownames(mat) <- paste0("Test",1:10)
phm <- pheatmap(mat)
# Generate annotations for rows and columns
annotation_col = data.frame(
  CellType = factor(rep(c("CT1", "CT2"), 5)),
  Time = factor(paste0("X", 1:5)),
  time = 1:5,
  Ali2 = factor(rep(c("abdurrahman", "lahavlevelaguvveteillabilla"), 5)),
  Ali = factor(rep(c("ali", "veli"), 5)),
  Time2 = factor(paste0("X", 1:10))
  
)
rownames(annotation_col) = paste("Test", 1:10, sep = "")

annotation_row = data.frame(
  GeneClass = factor(rep(c("Path1", "Path2", "Path3"), c(10, 4, 6)))
)
rownames(annotation_row) = paste("Gene", 1:20, sep = "")

ann_colors = list(
  time =  c("white", "firebrick"),
  Time =  c(X1 = "#7570B3", X2 = "#E7298A", X3 = "#66A61E", X4 = "#1B9E77", X5 = "#D95F02"),
  CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"),
  GeneClass = c(Path1 = "#7570B3", Path2 = "#E7298A", Path3 = "#66A61E"),
  Ali = c(ali = "#1B9E77", veli = "#D95F02"),
  Ali2 = c(abdurrahman = "#1B9E77", lahavlevelaguvveteillabilla = "#D95F02"),
  Time2 =  c(X1 = "#7570B3", X2 = "#E7298A", X3 = "#66A61E", X4 = "#1B9E77", X5 = "#D95F02",
             X6 = "#7570B3", X7 = "#E7298A", X8 = "#66A61E", X9 = "#1B9E77", X10 = "#D95F02")
)


# try ggplot2 legend
library(reshape2)
library(ggplot2)
library(cowplot); library(grid); library(ggpubr); library(patchwork); library(gridExtra)

ann2 <- annotation_col

g <- list()
l <- list()
for(i in colnames(ann2)){
  g[[i]] <- ggplot(ann2, aes(get(i))) + 
    geom_bar(aes(fill = get(i)), color = "black") + 
    scale_fill_manual(values = ann_colors[[(i)]]) + 
    labs(fill = i) +
    theme_bw()
  l[[i]] <- get_legend(g[[i]])
}
lm=rbind(c(1,1,1),
         c(2,2,2),
         c(2,2,2))
lj <- lapply(l, justify, vjust="top", hjust = "left", draw=FALSE)
p <- arrangeGrob(lj[[1]], lj[[2]],lj[[3]], lj[[4]],lj[[5]], nrow = 1)
p <- arrangeGrob(lj[[1]], lj[[2]],lj[[3]], lj[[4]],lj[[5]], lj[[1]], lj[[2]],lj[[3]], lj[[4]],lj[[5]], nrow = 1)
wrap_plots(phm[[4]], p, ncol = 1, heights = c(3,1))
grid.arrange(phm[[4]], p, p)


plot_grid(l[[1]], l[[2]], align = "hv")
grid.newpage()
p <-  grid.arrange(grobs = l, ncol = 5)
grid.draw(gtable_combine(l[[1]], l[[2]], along = 1))
grid.arrange(tgt)
p

ll <- lapply(l, as_ggplot)
patchwork::wrap_ggplot_grob(l[1:2])
nn2$.id <- 1:nrow(annotation_col)


ann3 <- melt(ann2, id.vars = ".id")


ggplot(ann3, aes(variable, value)) + geom_point(aes(colour = value)) + facet_grid(~variable)
