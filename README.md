
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **BBcor**: Bayesian Bootstrapping Correlations

[![CRAN
Version](http://www.r-pkg.org/badges/version/BBcor)](https://cran.r-project.org/package=BBcor)
[![Downloads](https://cranlogs.r-pkg.org/badges/BBcor)](https://cran.r-project.org/package=BBcor)
[![Build
Status](https://travis-ci.org/donaldRwilliams/BBcor.svg?branch=master)](https://travis-ci.org/donaldRwilliams/BBcor)

The goal of BBcor is to provide an efficient way to obtain samples from
the posterior distribution of various correlation coefficients:

-   Pearson (`method = "pearson"`)

-   Spearman (`method = "spearman"`)

-   Gaussian Rank (`method = "gaussian_rank"`)

-   Kendall (`method = "kendall"`)

-   Blomqvist (`method = "blomqvist"`; median correlation)

-   Polychoric (`method = "polychoric"`)

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
#> [1,]  1.0000000 -0.9113906 -0.9077460 -0.8946015  0.6480759
#> [2,] -0.9113906  1.0000000  0.9284389  0.9024415 -0.6786383
#> [3,] -0.9077460  0.9284389  1.0000000  0.8506681 -0.6821720
#> [4,] -0.8946015  0.9024415  0.8506681  1.0000000 -0.5233418
#> [5,]  0.6480759 -0.6786383 -0.6821720 -0.5233418  1.0000000
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
#> [1,]  1.00000000 -0.09731807 -0.38432175 -0.45493380  0.1778988
#> [2,] -0.09731807  1.00000000  0.46776101  0.49552520 -0.3035051
#> [3,] -0.38432175  0.46776101  1.00000000 -0.04765557 -0.1400437
#> [4,] -0.45493380  0.49552520 -0.04765557  1.00000000  0.3465090
#> [5,]  0.17789883 -0.30350508 -0.14004368  0.34650901  1.0000000
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
#> 1    mpg--cyl   -0.0973  0.1694 -0.4077  0.2481
#> 2   mpg--disp   -0.3843  0.1600 -0.6681 -0.0447
#> 3   cyl--disp    0.4678  0.1369  0.1727  0.6947
#> 4     mpg--hp   -0.4549  0.1293 -0.6806 -0.1764
#> 5     cyl--hp    0.4955  0.1212  0.2352  0.7114
#> 6    disp--hp   -0.0477  0.1429 -0.3271  0.2336
#> 7   mpg--drat    0.1779  0.1824 -0.2005  0.5079
#> 8   cyl--drat   -0.3035  0.1434 -0.5600 -0.0111
#> 9  disp--drat   -0.1400  0.1458 -0.4160  0.1536
#> 10   hp--drat    0.3465  0.1894 -0.0464  0.6764
```

Note that setting `summary = FALSE` returns the posterior samples in a
data frame.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-rubin1981bayesian" class="csl-entry">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
