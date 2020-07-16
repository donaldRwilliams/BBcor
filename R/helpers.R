bb_weights <- function(n){
  wts <- stats::rgamma(n, 1, 1)
  wts <- wts / sum(wts)
  wts
}