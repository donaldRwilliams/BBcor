bb_weights <- function(n){
  wts <- stats::rgamma(n, 1, 1)
  wts <- wts / sum(wts)
  wts
}

normalize <- function(data, n) {
  x_ranked <- rank(data, ties.method = "random")
  
  x <- x_ranked / (n + 1)
  
  normalized_data <- stats::qnorm(x)
  
  return(normalized_data)
}


#' Compare Bayesian bootstrapped correlations
#' 
#' See \link[bayeslincom]{lin_comb}
#' 
#' @param lin_comb A string specifying a linear combination of variables, or a list of variable names if using \code{contrast}.
#'
#' @param obj An object of class \code{BGGM}, \code{bbcor}, or a \code{data.frame} of posterior samples.
#'
#' @param cred The level for which a credible interval should be computed.
#'
#' @param rope Specify a ROPE. Optional.
#'
#' @param contrast A contrast matrix specifying which combinations to test. Optional.
#'
#' @return An object of class \code{bayeslincom}
#' 
#' 
#' @examples 
#'Y <- mtcars[, 1:3]
#'bb <- bbcor(Y)
#'bb_compare <- compare("mpg--cyl > mpg--disp",
#'                      obj = bb,
#'                      cred = 0.90,
#'                      rope = c(-0.1, 0.1))
#'bb_compare
#' @importFrom bayeslincom lin_comb
#' @export
#' @export compare

compare <- function(lin_comb, obj, cred = 0.9, rope = NULL, contrast = NULL) {
  
    out <- bayeslincom::lin_comb(
      lin_comb = lin_comb,
      obj = obj,
      ci = cred,
      rope = rope,
      contrast = contrast      
    )
    return(out)
  }


#' Plot comparisons from \code{compare}
#' 
#' See \link[bayeslincom]{plot.bayeslincom}
#' 
#' @param x An object of class \code{bayeslincom}
#' @param bins Number of bins
#' @param point_col Color for point indicating mean of posterior
#' @param hist_col Color for histogram edges
#' @param hist_fill Color for histogram bars
#' @param bar_col Color of bar for credible interval
#' @param display_comb_strings If \code{TRUE}, displays full strings for
#'                             combinations in \code{ggplot} facets  when there
#'                             is more than one combination in \code{x}
#' @param ... Currently ignored
#' @return An object of class \code{ggplot}
#' 
#' @examples 
#'Y <- mtcars[, 1:3]
#'bb <- bbcor(Y)
#'bb_compare <- compare("mpg--cyl > mpg--disp",
#'                      obj = bb,
#'                      cred = 0.90,
#'                      rope = c(-0.1, 0.1))
#'plot(bb_compare)
#'
#' @importFrom bayeslincom plot.bayeslincom
#' @export
#' @export plot.bayeslincom

plot.bayeslincom <- bayeslincom::plot.bayeslincom


