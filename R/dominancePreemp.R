# Dominance Preemption
dominancePreemp <- function (N, S, count = FALSE){
  k <- runif(n = (S - 1), min = 0.5, max = 1)
  r <- N
  if(count){
    for(i in 1:(S-1)){
      r[i + 1] <- floor(r[i] * (1 - k[i]))
      r[i] <- floor(r[i] * k[i])
    }
  }
  else{
    for(i in 1:(S-1)){
      r[i + 1] <- r[i] * (1 - k[i])
      r[i] <- r[i] * k[i]
    }
  }
  return(sort(r, decreasing = TRUE))
}
