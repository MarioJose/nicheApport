findPFw <- function(x, count, ws = 0, we = 1, f = 0.01, nRand = 99, cl = TRUE, nCores = 1){
  if(!is.matrix(x) & !is.data.frame(x)){
    stop("\n'x' must be a data frame or a matrix")
  }
  
  if(length(x[ ,1]) < 2){
    stop("\nYou must have more than one replicates in lines")
  }
  
  if(is.null(count)){
    stop("\n'count' must be specified")
  }
  
  out <- data.frame(w = seq(from = ws, to = we, by = f))
  for(i in 1:length(out$w)){
    if(cl){
      m <- fitmodelCl(x, model = "powerFraction", count = count, nRand = nRand, nCores = nCores, w = out$w[i])
    } else {
      m <- fitmodel(x, model = "powerFraction", count = count, nRand = nRand, w = out$w[i])
    }
    out$TMobs[i] <- m@Tstats$TMobs
    out$TVobs[i] <- m@Tstats$TVobs
    out$pvalueM[i] <- m@Tstats$pvalue[1, ]
    out$pvalueV[i] <- m@Tstats$pvalue[2, ]
  }
  return(out)
}
