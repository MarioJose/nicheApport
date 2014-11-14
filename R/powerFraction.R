# Power Fraction
powerFraction <- function(N, S, k = 0.2, count = FALSE){
  for(i in 1:(S-1)){
    target <- sample(1:length(N), size=1, prob = N^k)
    a <- runif(1, 0, N[target])
    a <- ifelse(count, floor(a), a)
    N <- c(N[-target], a, N[target] - a)
  }
  return(sort(N, decreasing=TRUE))
}
