
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
#> [1,]  1.0000000 -0.9120268 -0.9084441 -0.8945658  0.6516626
#> [2,] -0.9120268  1.0000000  0.9285823  0.9022099 -0.6810021
#> [3,] -0.9084441  0.9285823  1.0000000  0.8507521 -0.6843229
#> [4,] -0.8945658  0.9022099  0.8507521  1.0000000 -0.5255842
#> [5,]  0.6516626 -0.6810021 -0.6843229 -0.5255842  1.0000000
```

## Example: Partial Correlations

It is also possible to obtain partial correlations from the object
`bb_sample`:

``` r
# convert
pcors <- cor_2_pcor(bb_sample)

# partial correlation matrix
pcors$pcor_mean
#>            [,1]       [,2]        [,3]        [,4]       [,5]
#> [1,]  1.0000000 -0.1007303 -0.38561256 -0.45298924  0.1821618
#> [2,] -0.1007303  1.0000000  0.46461066  0.49455998 -0.3027317
#> [3,] -0.3856126  0.4646107  1.00000000 -0.04635827 -0.1376748
#> [4,] -0.4529892  0.4945600 -0.04635827  1.00000000  0.3488617
#> [5,]  0.1821618 -0.3027317 -0.13767481  0.34886172  1.0000000
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
#> 1    mpg--cyl   -0.1007  0.1695 -0.4046  0.2552
#> 2   mpg--disp   -0.3856  0.1597 -0.6701 -0.0549
#> 3   cyl--disp    0.4646  0.1404  0.1521  0.7000
#> 4     mpg--hp   -0.4530  0.1306 -0.6801 -0.1728
#> 5     cyl--hp    0.4946  0.1197  0.2423  0.7075
#> 6    disp--hp   -0.0464  0.1416 -0.3241  0.2387
#> 7   mpg--drat    0.1822  0.1789 -0.1857  0.5118
#> 8   cyl--drat   -0.3027  0.1443 -0.5694 -0.0066
#> 9  disp--drat   -0.1377  0.1428 -0.4087  0.1431
#> 10   hp--drat    0.3489  0.1853 -0.0354  0.6788
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
