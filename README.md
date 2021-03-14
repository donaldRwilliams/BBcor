
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

The method is based on Rubin (1981) and described in Rodriguez and
Williams (2021).

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
#> [1,]  1.0000000 -0.9109175 -0.9072289 -0.8939913  0.6487229
#> [2,] -0.9109175  1.0000000  0.9289528  0.9018640 -0.6782076
#> [3,] -0.9072289  0.9289528  1.0000000  0.8506727 -0.6816416
#> [4,] -0.8939913  0.9018640  0.8506727  1.0000000 -0.5216490
#> [5,]  0.6487229 -0.6782076 -0.6816416 -0.5216490  1.0000000
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
#> [1,]  1.00000000 -0.09543648 -0.38062398 -0.45503394  0.1848963
#> [2,] -0.09543648  1.00000000  0.47180153  0.49474761 -0.3010417
#> [3,] -0.38062398  0.47180153  1.00000000 -0.04519412 -0.1383608
#> [4,] -0.45503394  0.49474761 -0.04519412  1.00000000  0.3502683
#> [5,]  0.18489630 -0.30104166 -0.13836078  0.35026827  1.0000000
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
#> 1    mpg--cyl   -0.0954  0.1666 -0.4003  0.2433
#> 2   mpg--disp   -0.3806  0.1587 -0.6605 -0.0505
#> 3   cyl--disp    0.4718  0.1381  0.1740  0.7025
#> 4     mpg--hp   -0.4550  0.1284 -0.6795 -0.1817
#> 5     cyl--hp    0.4947  0.1185  0.2459  0.7086
#> 6    disp--hp   -0.0452  0.1412 -0.3210  0.2333
#> 7   mpg--drat    0.1849  0.1796 -0.1888  0.5103
#> 8   cyl--drat   -0.3010  0.1445 -0.5564 -0.0060
#> 9  disp--drat   -0.1384  0.1444 -0.4139  0.1503
#> 10   hp--drat    0.3503  0.1910 -0.0563  0.6796
```

Note that setting `summary = FALSE` returns the posterior samples in a
data frame.

## Example: Comparing Correlations

Comparisons can then be made using the `compare` function using a string
to specify which comparisons to be made

``` r
comparisons <- c("mpg--cyl > mpg--disp",
                 "mpg--disp - mpg--hp = 0")
post_comparisons <- compare(comparisons,
                            obj = pcors,
                            ci = 0.9)

post_comparisons
#> bayeslincom: Linear Combinations of Posterior Samples
#> ------ 
#> Call:
#> lin_comb.bbcor(lin_comb = lin_comb, obj = obj, ci = ci, rope = rope, 
#>     contrast = contrast)
#> ------ 
#> Combinations:
#>  C1: mpg--cyl > mpg--disp 
#>  C2: mpg--disp - mpg--hp = 0 
#> ------ 
#> Posterior Summary:
#> 
#>    Post.mean Post.sd Cred.lb Cred.ub Pr.less Pr.greater
#> C1      0.29    0.23   -0.09    0.66    0.11       0.89
#> C2      0.07    0.23   -0.30    0.45    0.37       0.63
#> ------ 
#> Note:
#> Pr.less: Posterior probability less than zero
#> Pr.greater: Posterior probability greater than zero

plot(post_comparisons)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

or with a contrast matrix

``` r
contrast_mat <- matrix(c(1, -1, 0, 
                         0, 1, -1), 
                       nrow = 2, 
                       byrow = TRUE)


post_comparisons <- compare(c("mpg--cyl", "mpg--disp", "mpg--hp"),
                            obj = pcors,
                            contrast = contrast_mat,
                            ci = 0.9)

post_comparisons
#> bayeslincom: Linear Combinations of Posterior Samples
#> ------ 
#> Call:
#> lin_comb.bbcor(lin_comb = lin_comb, obj = obj, ci = ci, rope = rope, 
#>     contrast = contrast)
#> ------ 
#> Combinations:
#>  C1: C1 
#>  C2: C2 
#> ------ 
#> Posterior Summary:
#> 
#>    Post.mean Post.sd Cred.lb Cred.ub Pr.less Pr.greater
#> C1      0.29    0.23   -0.09    0.66    0.11       0.89
#> C2      0.07    0.23   -0.30    0.45    0.37       0.63
#> ------ 
#> Note:
#> Pr.less: Posterior probability less than zero
#> Pr.greater: Posterior probability greater than zero
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-rodriguez2021painless" class="csl-entry">

Rodriguez, Josue E, and Donald R Williams. 2021. “Painless Posterior
Sampling: Bayesian Bootstrapped Correlation Coefficients.”

</div>

<div id="ref-rubin1981bayesian" class="csl-entry">

Rubin, Donald B. 1981. “The Bayesian Bootstrap.” *The Annals of
Statistics*, 130–34.

</div>

</div>
