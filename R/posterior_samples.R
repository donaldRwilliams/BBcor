#' Extract Posterior Samples
#'
#' @param object An object of class \code{bbcor}
#' 
#' @param ... Currently ignored
#'
#' @return A data frame including the posterior samples
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
                              ...){
  
  
  Y <- object$Y
  p <- ncol(Y)
  
  iter <- object$iter 
  
  if(is.null(colnames(Y))){
    id <- 1:p
    cn <- sapply(1:p, function(x) paste0(id, "--", id[x]))
  } else {
    cn <- sapply(1:p, function(x) paste0(colnames(object$Y), "--", colnames(object$Y)[x])) 
  }
  
  cn <- cn[upper.tri(cn)]
  samples <- t(sapply(1:iter, function(s) object$samps[,,s][upper.tri(diag(p))]))
  if (p == 2) samples <- t(samples) # handle case where only two variables 
  samples <- as.data.frame(samples)
  colnames(samples) <- cn    
  
  return(samples)
}
