# pheatmap2
`pheatmap2` runs faster than `pheatmap` and supports many more distance measures. 
It takes the advantage of parallel distance calculation via `parallelDist` and `fastcluster` packages.

## Install
Please install `devtools` if you haven't yet.
```r
install.packages("devtools")
```
Then, you basically install the `pheatmap2` package by using:
```r
library(devtools)
install_github("altintasali/pheatmap2")
```
