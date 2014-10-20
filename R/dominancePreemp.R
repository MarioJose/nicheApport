# Dominance Preemption
dominancePreemp <- function (N, S, count = FALSE){
  k <- runif(n = (S - 1), min = 0.5, max = 1)
  r <- N
  for(i in 1:(S - 1)){
    r[i] <- ifelse(count, floor(r[i] * k[i]), r[i] * k[i])
    r[i + 1] <- N - sum(r[1:i])
  }
  return(sort(r, decreasing = TRUE))
}
