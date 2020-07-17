#' Extract Posterior Samples
#'
#' @param object An object of class \code{bbcor}
#' 
#' @param summary Logical. Should the posterior samples be summarized (defaults to \code{TRUE})?
#' 
#' @param cred Numeric. If \code{summary = TRUE}, the desired credible interval. 
#' 
#' @param ... Currently ignored
#'
#' @return Either a data frame summarizing the relations (\code{summary = TRUE}) or 
#' a data frame including the posterior samples (\code{summary = FALSE})
#' 
#' @importFrom stats quantile sd 
#' 
#' @export
#' 
#' 
#' @examples
#' 
#' Y <- mtcars[,1:5]
#' 
#' bb_samps <- bbcor(Y, method = "spearman")
#' 
#' # correlations
#' posterior_samples(bb_samps)
#' 
#' 
#' # partial correlations
#' posterior_samples(cor_2_pcor(bb_samps))
posterior_samples <- function(object, 
                              summary = TRUE, 
                              cred =  0.95, 
                              ...){
  
  
  Y <- object$Y
  p <- ncol(Y)
  
  iter <- object$iter 
  lb <- (1 - cred) /2
  ub <-  1 - lb
  
  if(is.null(colnames(Y))){
    id <- 1:p
    cn <- sapply(1:p, function(x) paste0(id, "--", id[x]))
  } else {
    cn <- sapply(1:p, function(x) paste0(colnames(object$Y), "--", colnames(object$Y)[x])) 
  }
  
  cn <- cn[upper.tri(cn)]
  samples <- t(sapply(1:iter, function(s) object$samps[,,s][upper.tri(diag(p))]))
  
  if(summary){
    post_summary <- 
      cbind.data.frame(data.frame( Relation = cn),
                       round(data.frame(
                         Post.mean = colMeans(samples),
                         Post.sd = apply(samples, 2, stats::sd),
                         Cred.lb = apply(samples, 2, stats::quantile, lb),
                         Cred.ub = apply(samples, 2, stats::quantile, ub)
                       ), 4))
    
    return(post_summary)
    
  } else {
    
    samples <- as.data.frame( samples )
    colnames(samples) <- cn    
    return(samples)
    
  }
}