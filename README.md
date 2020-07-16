
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **BBcor**: Bayesian Bootstrapping Correlations

[![Build
Status](https://travis-ci.org/donaldRwilliams/BBcor.svg?branch=master)](https://travis-ci.org/donaldRwilliams/BBcor)

<!-- badges: start -->

<!-- badges: end -->

The goal of BBcor is to provide an efficient way to obtain samples from
the posterior distribution for various correlation coefficients:

  - Pearson (`method = "pearson"`)

  - Spearman (`method = "spearman"`)

  - Kendall (`method = "kendall"`)

  - Blomqvist (`method = "blomqvist"`; median correlation)

  - Polychoric (`method = "polychoric"`)

The method is based on Rubin (1981).

## Installation

<!-- You can install the released version of BBcor from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("BBcor") -->

<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("donaldRwilliams/BBcor")
```

## Example: Correlations

This is a basic example which shows you how to solve a common problem,
i.e., estimating correlations:

``` r
library(BBcor)
## basic example code

# data
Y <- mtcars[,1:5]

# sample posterior
bb_sample <- bbcor(Y, method = "spearman")


# correlation matrix
bb_sample$cor_mean
#>            [,1]       [,2]       [,3]       [,4]       [,5]
#> [1,]  1.0000000 -0.9115314 -0.9079284 -0.8942292  0.6489635
#> [2,] -0.9115314  1.0000000  0.9285016  0.9023032 -0.6788982
#> [3,] -0.9079284  0.9285016  1.0000000  0.8508914 -0.6817982
#> [4,] -0.8942292  0.9023032  0.8508914  1.0000000 -0.5223453
#> [5,]  0.6489635 -0.6788982 -0.6817982 -0.5223453  1.0000000
```

## Example: Partial Correlations

It is also possible to obtain partial correlations from the object
`bb_sample`:

``` r
# convert
pcors <- cor_2_pcor(bb_sample)

# partial correlation matrix
pcors$pcor_mean
#>             [,1]        [,2]        [,3]        [,4]       [,5]
#> [1,]  1.00000000 -0.09843109 -0.38392034 -0.45326836  0.1828504
#> [2,] -0.09843109  1.00000000  0.46606619  0.49694905 -0.3052741
#> [3,] -0.38392034  0.46606619  1.00000000 -0.04618027 -0.1364325
#> [4,] -0.45326836  0.49694905 -0.04618027  1.00000000  0.3512345
#> [5,]  0.18285037 -0.30527407 -0.13643255  0.35123455  1.0000000
```

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
