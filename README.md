
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
#> [1,]  1.0000000 -0.9112204 -0.9075050 -0.8944635  0.6496021
#> [2,] -0.9112204  1.0000000  0.9285894  0.9016906 -0.6805359
#> [3,] -0.9075050  0.9285894  1.0000000  0.8505965 -0.6837053
#> [4,] -0.8944635  0.9016906  0.8505965  1.0000000 -0.5236966
#> [5,]  0.6496021 -0.6805359 -0.6837053 -0.5236966  1.0000000
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
#> [1,]  1.00000000 -0.09737011 -0.38017150 -0.45663232  0.1816622
#> [2,] -0.09737011  1.00000000  0.46829675  0.49311776 -0.3045046
#> [3,] -0.38017150  0.46829675  1.00000000 -0.04380048 -0.1401563
#> [4,] -0.45663232  0.49311776 -0.04380048  1.00000000  0.3503070
#> [5,]  0.18166217 -0.30450464 -0.14015632  0.35030698  1.0000000
```

Note that the objects `bb_sample` and `pcors` include a 3D array with
the sampled correlation or partial correlation matrices.

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
