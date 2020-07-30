
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **BBcor**: Bayesian Bootstrapping Correlations

[![CRAN
Version](http://www.r-pkg.org/badges/version/BBcor)](https://cran.r-project.org/package=BBcor)
[![Downloads](https://cranlogs.r-pkg.org/badges/BBcor)](https://cran.r-project.org/package=BBcor)
[![Build
Status](https://travis-ci.org/donaldRwilliams/BBcor.svg?branch=master)](https://travis-ci.org/donaldRwilliams/BBcor)

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
#> [1,]  1.0000000 -0.9110503 -0.9074607 -0.8945129  0.6485464
#> [2,] -0.9110503  1.0000000  0.9290431  0.9023094 -0.6778860
#> [3,] -0.9074607  0.9290431  1.0000000  0.8517995 -0.6813720
#> [4,] -0.8945129  0.9023094  0.8517995  1.0000000 -0.5225487
#> [5,]  0.6485464 -0.6778860 -0.6813720 -0.5225487  1.0000000
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
#> [1,]  1.00000000 -0.09707313 -0.37959227 -0.45575557  0.1832972
#> [2,] -0.09707313  1.00000000  0.47010459  0.49238943 -0.3002126
#> [3,] -0.37959227  0.47010459  1.00000000 -0.04267985 -0.1394336
#> [4,] -0.45575557  0.49238943 -0.04267985  1.00000000  0.3478556
#> [5,]  0.18329721 -0.30021256 -0.13943364  0.34785560  1.0000000
```

Note that the objects `bb_sample` and `pcors` include a 3D array with
the sampled correlation or partial correlation matrices.

## Example: Posterior Samples

The posterior samples can be summarized as follows

``` r
post_summary <- posterior_samples(pcors, summary = TRUE, cred = 0.95)

# print
post_summary
#>      Relation Post.mean Post.sd Cred.lb Cred.ub
#> 1    mpg--cyl   -0.0971  0.1703 -0.4132  0.2438
#> 2   mpg--disp   -0.3796  0.1598 -0.6605 -0.0498
#> 3   cyl--disp    0.4701  0.1377  0.1708  0.7050
#> 4     mpg--hp   -0.4558  0.1295 -0.6851 -0.1839
#> 5     cyl--hp    0.4924  0.1203  0.2372  0.7020
#> 6    disp--hp   -0.0427  0.1415 -0.3159  0.2356
#> 7   mpg--drat    0.1833  0.1817 -0.1948  0.5116
#> 8   cyl--drat   -0.3002  0.1443 -0.5640  0.0041
#> 9  disp--drat   -0.1394  0.1437 -0.4128  0.1498
#> 10   hp--drat    0.3479  0.1917 -0.0583  0.6764
```

Note that setting `summary = FALSE` returns the posterior samples in a
data frame.

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
