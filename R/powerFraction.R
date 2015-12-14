# Power Fraction
powerFraction <- function (N, S, w = 0.2, count = FALSE){
  k <- runif(n = S, min = 0, max = 1)
  r <- N
  if(count){
    for(i in 2:S){
      j <- sample(x = 1:(i - 1), size = 1, prob = (r ^ w))
      r[i] <- floor(r[j] * k[i])
      r[j] <- abs(r[j] - r[i])
    }
  }
  else{
    for(i in 2:S){
      j <- sample(x = 1:(i - 1), size = 1, prob = (r ^ w))
      r[i] <- r[j] * k[i]
      r[j] <- abs(r[j] - r[i])
    }
  }
  return(sort(r, decreasing = TRUE))
}
