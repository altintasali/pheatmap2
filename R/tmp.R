# # Create test matrix
# test = matrix(rnorm(200), 20, 10)
# test[1:10, seq(1, 10, 2)] = test[1:10, seq(1, 10, 2)] + 3
# test[11:20, seq(2, 10, 2)] = test[11:20, seq(2, 10, 2)] + 2
# test[15:20, seq(2, 10, 2)] = test[15:20, seq(2, 10, 2)] + 4
# colnames(test) = paste("Test", 1:10, sep = "")
# rownames(test) = paste("Gene", 1:20, sep = "")
#
# # Draw heatmaps
# pheatmap(test)
# pheatmap(test, kmeans_k = 2)
# pheatmap(test, scale = "row", clustering_distance_rows = "correlation")
# pheatmap(test, color = colorRampPalette(c("navy", "white", "firebrick3"))(50))
# pheatmap(test, cluster_row = FALSE)
# pheatmap(test, legend = FALSE)


# Generate annotations for rows and columns
annotation_col = data.frame(
  CellType = factor(rep(c("CT1", "CT2"), 5)),
  Time = factor(paste0("X", 1:5)),
  time = 1:5,
  Ali = factor(rep(c("ali", "veli"), 5)),
  Ali2 = factor(rep(c("deli", "veli"), 5)),
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
  Ali2 = c(deli = "#1B9E77", veli = "#D95F02"),
  Time2 =  c(X1 = "#7570B3", X2 = "#E7298A", X3 = "#66A61E", X4 = "#1B9E77", X5 = "#D95F02",
            X6 = "#7570B3", X7 = "#E7298A", X8 = "#66A61E", X9 = "#1B9E77", X10 = "#D95F02")
)


# annotation <- LETTERS[1:4]
# annotation_colors <- 1:4
# border_color <- "black"
grid.newpage()
grid.draw(draw_annotation_legend(annotation = annotation_col, annotation_colors = ann_colors, border_color = "red"))
grid.newpage()







# annotation$Time <- as.factor(annotation$Time)
border_color <- "black"

x = unit(1, "npc")
y = unit(1, "npc")
text_height = unit(1, "grobheight", textGrob("FGH"))
text_width = unit(1, "grobwidth", textGrob("FGH"))
res = gList()

#-------------------------------
annotation <- annotation_col
annotation$Time <- as.factor(annotation$Time)
annotation_colors = ann_colors
i <- names(annotation)[3]
#-------------------------------
for(i in names(annotation)){
  l = grep(i, names(annotation))
  x0 = (l - 1) * 2.1 * text_width
  y = unit(1, "npc")
  y = y

  res[[i]] = textGrob(i, x = x0, y = y, vjust = 1, hjust = 0, gp = gpar(fontface = "bold"))

  y = y - 1.5 * text_height
  x = x - 1.5 * text_width
  if(is.character(annotation[[i]]) | is.factor(annotation[[i]])){
    n = length(unique(annotation[[i]])) #length(annotation_colors[[i]])
    l = grep(i, names(annotation))
    yy = y - (1:n - 1) * 2 * text_height
    xx = (l - 1) * 2.1 * text_width

    res[[paste(i, "r")]] = rectGrob(x = xx,
                                    y = yy,
                                    hjust = 0,
                                    vjust = 1,
                                    height = 2 * text_height,
                                    width = 2 * text_height,
                                    gp = gpar(col = border_color, fill = annotation_colors[[i]]))
    res[[paste(i, "t")]] = textGrob(names(annotation_colors[[i]]),
                                    x = xx + text_height * 2.4,
                                    y = yy - text_height,
                                    hjust = 0,
                                    vjust = 0.5)

    y = y - n * 2 * text_height

  }  else{
    n = length(unique(annotation[[i]])) #length(annotation_colors[[i]])
    l = grep(i, names(annotation))

    yy = y - 8 * text_height + seq(0, 1, 0.25)[-1] * 8 * text_height
    xx = (l - 1) * 2.1 * text_width
    h = 8 * text_height * 0.25

    res[[paste(i, "r")]] = rectGrob(x = xx, #x = unit(0, "npc"),
                                    y = yy,
                                    hjust = 0,
                                    vjust = 1,
                                    height = h,
                                    width = 2 * text_height,
                                    gp = gpar(col = NA, fill = colorRampPalette(annotation_colors[[i]])(4)))
    res[[paste(i, "r2")]] = rectGrob(x = xx, #x = unit(0, "npc"),
                                     y = y,
                                     hjust = 0,
                                     vjust = 1,
                                     height = 8 * text_height,
                                     width = 2 * text_height,
                                     gp = gpar(col = border_color, fill = NA))

    txt = rev(range(grid.pretty(range(annotation[[i]], na.rm = TRUE))))
    yy = y - c(1, 7) * text_height
    res[[paste(i, "t")]]  = textGrob(txt,
                                     x = xx + text_height * 2.4,
                                     y = yy - text_height * 0.5,
                                     hjust = 0,
                                     vjust = 0)
    y = y - 8 * text_height
  }
  y = y - 1.5 * text_height
}
res = gTree(children = res)
grid.newpage()
grid.draw(res)
