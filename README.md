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

## What is `pheatmap`?
`pheatmap` stands for "Pretty Heatmaps" and it definitely deserves its name. Raivo Kolde, the author of `pheatmap`, did an amazing job on heatmap visualization and I strongly believe that `pheatmap` is one of the best heatmap tools available. Dave Tang has a really blog post about how to exploit the features of pheatmap, so please [check it out](https://davetang.org/muse/2018/05/15/making-a-heatmap-in-r-with-the-pheatmap-package/). 


## What is more on `pheatmap2`
`pheatmap2` adds more features to `pheatmap` while keeping its original source code.

`pheatmap2`
1. Runs faster
    1. *Distance matrix calculation*: 
It uses `parallelDist::parDist` function instead of `base::dist`. `parDist` takes the advantage of all available cores on CPU.
    2. *Hierarchical clustering*:
It uses `fastcluster::hclust` function instead of `base::hclust`. `fastcluster::hclust` is show to perform faster hierarchical clustering than `base::hclust`
1. Supports more distance measures. Here is a list of distance measures (**bold text** below means also supported by `pheatmap`):
    - **correlation**
    - **euclidean**
    - **maximum**
    - **manhattan**
    - **canberra**
    - **binary**
    - **minkowski**
    - geodesic
    - mahalanobis
    - fJaccard
    - bhjattacharyya
    - bray
    - chord
    - divergence
    - dtw
    - hellinger
    - kullback
    - podani
    - soergel
    - wave
    - whittaker

    
    


  
