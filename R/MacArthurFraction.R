# MacArthur Fraction
MacArthurFraction <- function (N, S, count = FALSE){
  k <- runif(n = S, min = 0, max = 1)
  r <- N
  for(i in 2:S){
    j <- sample(x = 1:(i - 1), size = 1, prob = (r / sum(r)))
    r[i] <- ifelse(count, floor(r[j] * k[i]), r[j] * k[i])
    r[j] <- abs(r[j] - r[i])
  }
  return(sort(r, decreasing = TRUE))
}
