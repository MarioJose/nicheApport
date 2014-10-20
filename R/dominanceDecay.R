# Dominance Decay
dominanceDecay <- function (N, S, count = FALSE){
  k <- runif(n = S, min = 0, max = 1)
  r <- N
  r[1] <- ifelse(count, floor(r[1] * k[1]), r[1] * k[1])
  r[2] <- N - r[1]
  for(i in 3:S){
    r <- sort(r, decreasing = FALSE)
    r[i] <- ifelse(count, floor(r[i - 1] * k[i]), r[i - 1] * k[i])
    r[i - 1] <- abs(r[i - 1] - r[i])
  }
  return(sort(r, decreasing = TRUE))
}
