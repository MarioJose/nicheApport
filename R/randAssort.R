# Random Assortment
randAssort <- function (N, S, count= FALSE){
  k <- runif(n = S, min = 0, max = 1)
  r <- 1
  for(i in 2:S){
    r[i] <- r[i - 1] * k[i]
  }
  if(count){
    # If niche of species are independent, then each species must have at least one individual
    r <- (r / sum(r)) * (N - S)
    r <- floor(r) + 1
  } else {
    r <- (r / sum(r)) * N
  } 
  return(sort(r, decreasing = TRUE))
}
