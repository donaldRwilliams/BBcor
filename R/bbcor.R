#' Bayesian Bootstrapping Correlations
#' 
#' @description Efficiently draws samples from the posterior 
#'              distribution of various correlation coefficients
#' 
#' @param x A matrix of dimensions \emph{n} by \emph{p}
#' 
#' @param method Character string. Which correlation coefficient should be computed. 
#'               One of "pearson" (default), "kendall", "spearman", or "blomqvist"
#'               (i.e., median correlation).
#' 
#' @param iter Numeric. How many posterior samples (defaults to \code{5000}) ?
#' 
#' @param cores Numeric. How many cores for parallel computing (defaults to \code{2})?
#' 
#' @importFrom stats cov2cor na.omit rgamma
#' @importFrom utils capture.output
#' @importFrom psych polychoric
#' @importFrom pbapply pbreplicate 
#' @importFrom wdm wdm 
#' @importFrom parallel stopCluster makeCluster
#' @return 
#' 
#' \itemize{
#' \item \code{cor_mean}: A matrix including the posterior mean
#' 
#' \item \code{samps}: An array of dimensions \code{p} by \code{b} by \code{iter} that includes the 
#' sampled correlation matrices.
#' 
#' }
#' 
#' @note NAs are removed.
#' 
#' @examples
#' 
#' Y <- mtcars[,1:2]
#' 
#' bb_samps <- bbcor(Y, method = "spearman")
#' 
#' @export
bbcor <- function(x, 
                  method = "pearson", 
                  iter = 5000, 
                  cores = 2){
  x <- stats::na.omit(x)
  p <- ncol(x)
  n <- nrow(x)
  
  cl <- parallel::makeCluster(cores)
  
  # redundancy for efficiency
  if ( method == "pearson" ) {
    
    x <- scale(x)
    
    samps  <- pbapply::pbreplicate(n = iter,
                                   stats::cov.wt(x,
                                          wt =  bb_weights(n),
                                          cor = TRUE)$cor,
                                   cl = cl)
    
    } else if ( method == "spearman" ) {
      
      x <- sapply(1:p, function(i) rank(x[, i]))
      
      samps  <- pbapply::pbreplicate(n = iter,
                                   stats::cov.wt(x,
                                          wt =  bb_weights(n),
                                          cor = TRUE)$cor,
                                   cl = cl)
    
    } else if ( method == "polychoric" ) {
      
      samps  <- pbapply::pbreplicate(n = iter,
                                     psych::polychoric(x, weight =  bb_weights(n))$rho,
                                     cl = cl)
    } else {
        
      samps <- pbapply::pbreplicate(n = iter,
                                    wdm::wdm(x, method = method, 
                                             weights = bb_weights(n)), cl = cl)
      
      }
  
  trash <- utils::capture.output(cor_mean <- pbapply::pbapply(samps, MARGIN = 1:2, 
                                                       cl = 2, FUN = mean))
  parallel::stopCluster(cl)
  
  returned_object <- list(cor_mean = cor_mean, 
                          samps = samps, 
                          method = method, 
                          iter = iter)
  return(returned_object)
}
