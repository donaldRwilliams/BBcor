
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **BBcor**: Bayesian Bootstrapping Correlations

\[![Build
Status](https://travis-ci.org/donaldRwilliams/BBcor.svg?branch=master)
<!-- badges: start --> <!-- badges: end -->

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
#> [1,]  1.0000000 -0.9115879 -0.9083197 -0.8939832  0.6503929
#> [2,] -0.9115879  1.0000000  0.9284713  0.9020493 -0.6791242
#> [3,] -0.9083197  0.9284713  1.0000000  0.8509681 -0.6823492
#> [4,] -0.8939832  0.9020493  0.8509681  1.0000000 -0.5236734
#> [5,]  0.6503929 -0.6791242 -0.6823492 -0.5236734  1.0000000
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
#> [1,]  1.00000000 -0.09930632 -0.38430829 -0.45218177  0.1829173
#> [2,] -0.09930632  1.00000000  0.46544805  0.49394627 -0.3027594
#> [3,] -0.38430829  0.46544805  1.00000000 -0.04333719 -0.1377783
#> [4,] -0.45218177  0.49394627 -0.04333719  1.00000000  0.3474635
#> [5,]  0.18291727 -0.30275938 -0.13777833  0.34746346  1.0000000
```

## References

<div id="refs" class="references">

<div id="ref-rubin1981bayesian">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
