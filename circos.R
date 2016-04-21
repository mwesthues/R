pacman::p_load("circlize")

# Cytoband file
cytoband.file <- paste0(system.file(package = "circlize"), 
                        "/extdata/cytoBand.txt")

# Initialize an "empty" circos plot without an ideogram
circos.initializeWithIdeogram(cytoband = cytoband.file,
                              plotType = c("axis", "labels"))

# Customize the ideogram by using different colors to represent chromosomes and
# to change the style of chromosome names.
par(mar = c(1, 1, 1, 1))
circos.initializeWithIdeogram(cytoband = cytoband.file,
                              plotType = NULL)
circos.trackPlotRegion(ylim = c(0, 1),
                       panel.fun = function(x, y) {
  chr <- get.cell.meta.data("sector.index")
  xlim <- get.cell.meta.data("xlim")
  ylim <- get.cell.meta.data("ylim")
  circos.rect(xlim[1], 0, xlim[2], 0.5, col = rand_color(1))
  circos.text(mean(xlim), 0.9, chr, cex = 0.5, facing = "clockwise",
              niceFacing = TRUE)
  }, bg.border = NA)
circos.clear()

# -- CHAPTER 5.1, POINTS -----------------------------------------------------
# Create plotting regions
opar <- par(no.readonly = TRUE)
par(mar = c(1, 1, 1, 1))
set.seed(999)

circos.par("track.height" = 0.1, 
           start.degree = 90,
           canvas.xlim = c(0, 1),
           canvas.ylim = c(0, 1),
           gap.degree = 270)
# To make plots more clear to look at, we only add graphics in the 1/4 of the
# circle and initialize the plot only with chromosome 1.
circos.initializeWithIdeogram(chromosome.index = "chr1", 
                              plotType = NULL)

# In track A, it is the most simple way to add points
### track A
bed <- generateRandomBed(nr = 300)
circos.genomicTrackPlotRegion(data = bed,
  panel.fun = function(region, value, ...) {
    circos.genomicPoints(region, value, pch = 16, cex = 0.5, ...)
})

# In track B, under stack mode, points are added in one horizontal line (here,
# we additionally add the dashed line) because there is only one numeric column
# in bed.
### track B
bed <- generateRandomBed(nr = 300)
circos.genomicTrackPlotRegion(data = bed,
                              stack = TRUE,
  panel.fun = function(region, value, ...) {
    circos.genomicPoints(region, value, pch = 16, cex = 0.5, ...)
    i <- getI(...)
    cell.xlim <- get.cell.meta.data("cell.xlim")
    circos.lines(cell.xlim, 
                 c(i, i), 
                 lty = 2,
                 col = "#00000040")
})
  
# In track C, the input data is a list of two data frames. In the plot, sizes
# of the points correspond to the values of regions, and colors correspond to
# different data frames.
### track C
bed1 <- generateRandomBed(nr = 300)
bed2 <- generateRandomBed(nr = 300)
bed_list <- list(bed1, bed2)
circos.genomicTrackPlotRegion(bed_list,
  panel.fun = function(region, value, ...) {
    cex <- (value[[1]] - min(value[[1]])) / (max(value[[1]]) - min(value[[1]]))
    i <- getI(...)
    circos.genomicPoints(region, value, cex = cex, pch = 16, col = i, ...)
})

# In track D, plot the data frame list under stack mode
### track D
circos.genomicTrackPlotRegion(data = bed_list, 
                              stack = TRUE,
  panel.fun <- function(region, value, ...) {
    cex <- (value[[1]] - min(value[[1]])) / (max(value[[1]]) - min(value[[1]]))
    i <- getI(...)
    circos.genomicPoints(region, value, cex = cex, pch = 16, col = i, ...)
    cell.xlim <- get.cell.meta.data("cell.xlim")
    circos.lines(cell.xlim, c(i, i), lty = 2, col = "#00000040")
})
circos.clear()
dev.off()
par(opar)




# -- CHAPTER 6, LINKS -----------------------------------------------------
bed1 <- generateRandomBed(nr = 100)
bed1 <- bed1[sample(nrow(bed1), size = 20), ]
bed2 <- generateRandomBed(nr = 100)
bed2 <- bed2[sample(nrow(bed2), size = 20), ]
circos.initializeWithIdeogram(cytoband = cytoband.file,
                              plotType = c("axis", "labels"))
circos.genomicLink(bed1[, -4], bed2[, -4])
circos.clear()


### Draw histogram
#circos.trackHist()
