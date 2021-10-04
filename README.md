
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GMM

<!-- badges: start -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![GitHub repo
size](https://img.shields.io/github/repo-size/Prapti-044/linux-dots?color=green&logo=github)
![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/Prapti-044/GMM?color=green)
![GitHub language
count](https://img.shields.io/github/languages/count/Prapti-044/GMM)
![GitHub top
language](https://img.shields.io/github/languages/top/Prapti-044/GMM)
<!-- badges: end -->

The goal of GMM is to learn how to create an R-package by implementing
[Gaussian Mixture
Model](https://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model)
for clustering a dataset.

*Note*: This RMarkdown is created following the guidelines of [this
R-package example](https://github.com/mvuorre/exampleRPackage).

## Installation

You can only install the development version from [this
repository](https://github.com/Prapti-044/GMM) with:

``` r
# install.packages("devtools")
devtools::install_github("Prapti-044/GMM")
```

## Example

This is a basic example which shows you how to cluster the iris dataset:

``` r
library(GMM)
result <- apply.GMM(as.matrix(iris[,-5]), 3)
str(result)
#> List of 2
#>  $ loglik        : num -740
#>  $ classification: int [1:150] 2 2 2 2 2 3 2 2 2 2 ...
#>  - attr(*, "class")= chr [1:2] "list" "result"
```
