bb_weights <- function(n){
  wts <- stats::rgamma(n, 1, 1)
  wts <- wts / sum(wts)
  return(wts)
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





#--------------------
extract_list_items <- function(x, item, as_df = FALSE) {
  out <- sapply(x, "[[", item)
  if (as_df) out <- as.data.frame(out)
  return(out)
}

#' Print formatted summary of a \code{bayeslincom} object
#'
#' @param x An object of class \code{bayeslincom}
#' @param decimals The number of decimals points to which estimates should be rounded
#' @param ... Other arguments to be passed to \code{print}
#' @return A formatted summary of posterior samples
#' @export print.bayeslincom
#' @export

print.bayeslincom <- function(x, decimals = 2, ...) {
  res <- x$results
  
  cri_raw <- extract_list_items(res, "ci")
  cri <- round(cri_raw, decimals)
  
  Post.mean_raw <- extract_list_items(res, "mean_samples")
  Post.mean <- round(Post.mean_raw, decimals)
  
  Post.sd_raw <- extract_list_items(res, "sd_samples")
  Post.sd <- round(Post.sd_raw, decimals)
  
  print_df <- data.frame(
    Post.mean = Post.mean,
    Post.sd = Post.sd,
    Cred.lb = cri[1, ],
    Cred.ub = cri[2, ]
  )
  row.names(print_df) <- names(x$results)
  
  # ---- Begin pasting output ----
  cat("------ \n")
  
  cat("Combinations:\n")
  comb_list <- extract_list_items(res, "lin_comb")
  
  for (comb in seq_along(comb_list)) {
    cat(paste0(" C", comb, ":"), comb_list[[comb]], "\n")
  }
  cat("------ \n")
  
  cat("Posterior Summary:\n\n")
  
  if (!is.null(x$rope)) {
    cat("ROPE: [", x$rope[[1]], ",", x$rope[[2]], "] \n\n")
    print_df$Pr.in <- extract_list_items(res, "rope_overlap")
    
    # note for ROPE
    note <- "Pr.in: Posterior probability in ROPE"
  } else {
    prob_greater <- extract_list_items(res, "prob_greater")
    print_df$Pr.less <- round(1 - prob_greater, decimals)
    print_df$Pr.greater<- round(prob_greater, decimals)
    
    note <- paste0("Pr.less: Posterior probability less than zero\n",
                   "Pr.greater: Posterior probability greater than zero")
  }
  
  print(print_df, right = T)
  cat("------ \n")
  cat(paste0("Note:\n", note))
}
