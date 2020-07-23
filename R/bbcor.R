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
#' @importFrom methods is
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
  
  # data matrix
  # (for return)
  Y <- x
  
  # na.omit
  x <- stats::na.omit(x)
  
  # variables
  p <- ncol(x)
  
  # observations
  n <- nrow(x)
  
  # parallel computing
  cl <- parallel::makeCluster(cores)
  
  # redundancy for efficiency
  if ( method == "pearson" ) {
    
    # scale
    x <- scale(x)
    
    # draw from posterior
    samps  <- pbapply::pbreplicate(n = iter,
                                   stats::cov.wt(x,
                                          wt =  bb_weights(n),
                                          cor = TRUE)$cor,
                                   cl = cl)
    
    } else if ( method == "spearman" ) {
      
      # ranks (makes sampling faster)
      x <- sapply(1:p, function(i) rank(x[, i]))
      
      # draw from posterior
      samps  <- pbapply::pbreplicate(n = iter,
                                   stats::cov.wt(x,
                                          wt =  bb_weights(n),
                                          cor = TRUE)$cor,
                                   cl = cl)
    
    } else if ( method == "polychoric" ) {
      
      # draw from posterior
      samps  <- pbapply::pbreplicate(n = iter,
                                     psych::polychoric(x, weight =  bb_weights(n))$rho,
                                     cl = cl)
    } else {
      
      # draw from posterior  
      samps <- pbapply::pbreplicate(n = iter,
                                    wdm::wdm(x, method = method, 
                                             weights = bb_weights(n)), 
                                    cl = cl)
      }
  
  # compute mean
  trash <- utils::capture.output(cor_mean <- pbapply::pbapply(samps, MARGIN = 1:2, 
                                                       cl = 2, FUN = mean))
  # stop cluster
  parallel::stopCluster(cl)
  
  # returned object
  returned_object <- list(cor_mean = cor_mean, 
                          samps = samps, 
                          method = method, 
                          iter = iter, 
                          Y = Y)
  
  class(returned_object) <- c("bbcor", 
                              "default")
  return(returned_object)
}


#' Print \code{bbcor} Objects 
#' 
#' Print the correlation or partial correlation matrix
#' 
#' @param x An object of class \code{bbcor}
#' @param ... Currently ignored
#' @export
print.bbcor <- function(x,...){
  
  if (methods::is(x, "default")) {
    
    mat <- as.data.frame(x$cor_mean)
    
    if (is.null(colnames(x$Y))) {
      
      colnames(mat) <- 1:ncol(x$Y)
      row.names(mat) <- 1:ncol(x$Y)
      
      } else {
      
        colnames(mat) <- colnames(x$Y)
        row.names(mat) <- colnames(x$Y)
      }
    }
  
  if (methods::is(x, "cor_2_pcor")) {
    
    mat <- as.data.frame(x$pcor_mean)
    
    if (is.null(colnames(x$Y))) {
      
      colnames(mat) <- 1:ncol(x$Y)
      row.names(mat) <- 1:ncol(x$Y)
      
      } else {
        
        colnames(mat) <- colnames(x$Y)
        row.names(mat) <- colnames(x$Y)
    }
  }
  print(mat)
}
