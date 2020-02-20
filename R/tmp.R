library(magrittr)
# Generate annotations for rows and columns
annotation_col = data.frame(
  CellType = factor(rep(c("CT1", "CT2"), 5)),
  Time = 1:5
)
rownames(annotation_col) = paste("Test", 1:10, sep = "")

annotation_row = data.frame(
  GeneClass = factor(rep(c("Path1", "Path2", "Path3"), c(10, 4, 6)))
)
rownames(annotation_row) = paste("Gene", 1:20, sep = "")

ann_colors = list(
  Time = c("white", "firebrick"),
  CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"),
  GeneClass = c(Path1 = "#7570B3", Path2 = "#E7298A", Path3 = "#66A61E")
)


# annotation <- LETTERS[1:4]
# annotation_colors <- 1:4
# border_color <- "black"
grid.newpage()
draw_annotation_legend(annotation = annotation_col, annotation_colors = ann_colors, border_color = "red") %>% grid.draw
grid.newpage()










x = unit(1, "npc")
y = unit(1, "npc")
text_height = unit(1, "grobheight", textGrob("FGH"))
text_width = unit(1, "grobwidth", textGrob("FGH"))
res = gList()

#-------------------------------
annotation <- annotation_col
annotation$Time <- as.factor(annotation$Time)
annotation_colors = ann_colors
i <- names(annotation)[1]
#-------------------------------
for(i in names(annotation)){
res[[i]] = textGrob(i, x = 0, y = y, vjust = 1, hjust = 0, gp = gpar(fontface = "bold"))

  y = y - 1.5 * text_height
  x = x - 1.5 * text_width
  if(is.character(annotation[[i]]) | is.factor(annotation[[i]])){
    n = length(annotation_colors[[i]])
    l = grep(i, names(annotation))
    yy = y - (1:n - 1) * 2 * text_height
    xx = (l - 1) * 2.2 * text_width

    res[[paste(i, "r")]] = rectGrob(x = xx,
                                    y = yy,
                                    hjust = 0,
                                    vjust = 1,
                                    height = 2 * text_height,
                                    width = 2 * text_height,
                                    gp = gpar(col = border_color, fill = annotation_colors[[i]]))
    res[[paste(i, "t")]] = textGrob(names(annotation_colors[[i]]),
                                    x = text_height * 2.4,
                                    y = yy - text_height,
                                    hjust = 0,
                                    vjust = 0.5)

    y = y - n * 2 * text_height

  }  else{
    yy = y - 8 * text_height + seq(0, 1, 0.25)[-1] * 8 * text_height
    h = 8 * text_height * 0.25

    res[[paste(i, "r")]] = rectGrob(x = unit(0, "npc"), y = yy, hjust = 0, vjust = 1, height = h, width = 2 * text_height, gp = gpar(col = NA, fill = colorRampPalette(annotation_colors[[i]])(4)))
    res[[paste(i, "r2")]] = rectGrob(x = unit(0, "npc"), y = y, hjust = 0, vjust = 1, height = 8 * text_height, width = 2 * text_height, gp = gpar(col = border_color, fill = NA))

    txt = rev(range(grid.pretty(range(annotation[[i]], na.rm = TRUE))))
    yy = y - c(1, 7) * text_height
    res[[paste(i, "t")]]  = textGrob(txt, x = text_height * 2.4, y = yy, hjust = 0, vjust = 0.5)
    y = y - 8 * text_height
  }
  y = y - 1.5 * text_height
}
res = gTree(children = res)
grid.newpage()
grid.draw(res)
