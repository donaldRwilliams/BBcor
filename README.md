
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
#> [1,]  1.0000000 -0.9109279 -0.9076845 -0.8944815  0.6486115
#> [2,] -0.9109279  1.0000000  0.9290157  0.9020555 -0.6788818
#> [3,] -0.9076845  0.9290157  1.0000000  0.8512187 -0.6822785
#> [4,] -0.8944815  0.9020555  0.8512187  1.0000000 -0.5217192
#> [5,]  0.6486115 -0.6788818 -0.6822785 -0.5217192  1.0000000
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
#> [1,]  1.00000000 -0.09481705 -0.38167143 -0.45702083  0.1829026
#> [2,] -0.09481705  1.00000000  0.46918396  0.49435112 -0.3042325
#> [3,] -0.38167143  0.46918396  1.00000000 -0.04457999 -0.1403033
#> [4,] -0.45702083  0.49435112 -0.04457999  1.00000000  0.3532033
#> [5,]  0.18290265 -0.30423251 -0.14030328  0.35320325  1.0000000
```

Note that the objects `bb_sample` and `pcors` include a 3D array that
includes the sampled correlation or partial correlation matrices.

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
