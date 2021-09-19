#' Summarize posterior samples from bbcor object
#' 
#' @param object An object of class \code{bbcor}
#' @param ci The desired credible interval
#' @param decimals The number of decimals points to which estimates should be rounded
#' @param ... Currently ignored
#' 
#' @return A \code{data.frame} summarizing the relations
#' 
#' @importFrom stats quantile sd
#' @export 
#' @export summary.bbcor
#' @examples 
#'
#' Y <- mtcars[, 1:5]
#' bb <- bbcor(Y, method = "spearman")
#' 
#' summary(bb)

summary.bbcor <- function(object, ci = 0.9, decimals = 2, ...) {
  samples <- posterior_samples(object)
  
  lb <- (1 - ci) /2
  ub <-  1 - lb
  
  main_df <- data.frame(
    Post.mean = colMeans(samples),
    Post.sd = apply(samples, 2, stats::sd),
    Cred.lb = apply(samples, 2, stats::quantile, lb),
    Cred.ub = apply(samples, 2, stats::quantile, ub)
  )
  
  post_summary <- cbind.data.frame(
    Relation = colnames(samples),
    round(main_df, decimals)
  )
  row.names(post_summary) <- NULL
  
  return(post_summary)
}


#' Plot bbcor point estimates and intervals
#'
#' @param x An object of class \code{bbcor}
#' @param ci Width of credible interval. Defaults to 0.9.
#' @param point_col Color for point indicating mean of posterior
#' @param bar_col Color of bar for credible interval
#' @param ... Currently ignored
#' @return An object of class \code{ggplot}
#'
#' @examples
#'Y <- mtcars[, 1:5]
#'bb <- bbcor(Y)
#'plot(bb)
#'
#' @importFrom  ggplot2 ggplot aes_string geom_errorbar geom_point coord_flip
#' @importFrom stats reorder
#' @export plot.bbcor
#' @export

plot.bbcor <- function(x, ci = 0.9, point_col = "red", bar_col = "black", ...) {
  bb_summary <- summary(x, cred = ci)
  bb_summary$Relation <- reorder(bb_summary$Relation, bb_summary$Post.mean)
  
  p <-
    ggplot(bb_summary, aes_string(x = "Relation", y = "Post.mean")) +
    geom_errorbar(aes_string(ymin = "Cred.lb", ymax = "Cred.ub"), col = bar_col, width = 0.01) +
    geom_point(col = point_col) +
    coord_flip()
  return(p)
}

