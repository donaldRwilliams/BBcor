
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **BBcor**: Bayesian Bootstrapping Correlations

[![Build
Status](https://travis-ci.org/donaldRwilliams/BBcor.svg?branch=master)](https://travis-ci.org/donaldRwilliams/BBcor)

<!-- badges: start -->

<!-- badges: end -->

The goal of BBcor is to provide an efficient way to obtain samples from
the posterior distribution of various correlation coefficients:

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
#> [1,]  1.0000000 -0.9115418 -0.9076418 -0.8945875  0.6467696
#> [2,] -0.9115418  1.0000000  0.9288391  0.9023407 -0.6769017
#> [3,] -0.9076418  0.9288391  1.0000000  0.8512829 -0.6800903
#> [4,] -0.8945875  0.9023407  0.8512829  1.0000000 -0.5198904
#> [5,]  0.6467696 -0.6769017 -0.6800903 -0.5198904  1.0000000
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
#> [1,]  1.00000000 -0.09792834 -0.37958360 -0.45415177  0.1830085
#> [2,] -0.09792834  1.00000000  0.46887590  0.49478363 -0.3047108
#> [3,] -0.37958360  0.46887590  1.00000000 -0.04270034 -0.1378666
#> [4,] -0.45415177  0.49478363 -0.04270034  1.00000000  0.3528652
#> [5,]  0.18300848 -0.30471075 -0.13786664  0.35286522  1.0000000
```

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
