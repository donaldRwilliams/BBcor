bb_weights <- function(n){
  wts <- stats::rgamma(n, 1, 1)
  wts <- wts / sum(wts)
  wts
}

normalize <- function(data, n) {
  x_ranked <- rank(data, ties.method = "random")
  x <- x_ranked / (n + 1)
  
  normalized_data <- qnorm(x)
  
  return(normalized_data)
}
