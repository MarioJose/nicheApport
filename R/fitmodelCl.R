fitmodelCl <- function(x, model, count, nRand = 999, nCores = 2, ...){
  if(!(model %in%  c("dominanceDecay", "dominancePreemp", "MacArthurFraction", 
                     "powerFraction", "randAssort", "randFraction"))){
    stop(paste("\n'model' must be one of this:", '"dominanceDecay", "dominancePreemp", "MacArthurFraction", "powerFraction", "randAssort", "randFraction"'))
  }
  
  if(!is.matrix(x) & !is.data.frame(x)){
    stop("\n'x' must be a data frame or a matrix")
  }
  
  if(length(x[ ,1]) < 2){
    stop("\nYou must have more than one replicates in lines")
  }
  
  if(is.null(count)){
    stop("\n'count' must be specified")
  }
  
  # Arguments in dots
  dots <- list(...)
  
  # Detect numbers of cores and make a cluster
  nc <- detectCores()
  if(nc < 2) {
    stop("You must have at least 2 cores to use 'fitmodelCl'. Use command 'fitmodel'")
  } else {
    if(nCores > nc){
      stop(paste("You informed more cores than detected.", "Detected", nc, "cores"))
    } else {
      if(nCores != 1){
        nc <- nCores
      }
    }
  }
  cl <- makeCluster(nc)
  
  # Partition randomizations between cores
  randc <- rep(floor(nRand / nc), nc)
  if(sum(randc < nRand)){
    randc[1:(nRand - sum(randc))] <- randc[1:(nRand - sum(randc))] + 1
  }
  
  # Number of replicates and ranks.
  n <- dim(x)[1]
  Rk <- dim(x)[2]
  
  # Total abundance and species of each replicates.
  N <- apply(x, 1, sum)
  S <- apply(x > 0, 1, sum)
  
  # Function to run in each cores
  fn1 <- function(rand, n, N, S, Rk, model, count, ...){
    dots <- list(...)
    clM <- matrix(nrow = rand, ncol = Rk)
    clV <- matrix(nrow = rand, ncol = Rk)
    for(i in 1:rand){
      sim <- matrix(0, nrow = n, ncol = Rk)
      for(j in 1:n){
        sim[j,1:S[j]] <- do.call(model, c(list(N = N[j], S = S[j], count = count), dots))
        # Transform to relative abundance
        sim[j,1:S[j]] <- sim[j,1:S[j]] / sum(sim[j,1:S[j]])
      }
      clM[i, ] = apply(sim, 2, mean)
      clV[i, ] = apply(sim, 2, var)
    }
    return(list(M = clM, V = clV))
  }
  
  # Send function to cluster
  tmp1 <- do.call(clusterApplyLB, c(list(cl = cl, x = randc, fun = fn1, n = n, N = N, S = S, Rk = Rk, model = getFunction(model), count = count), dots))

  # 'nRand' means and variances of 'n' simulations to the model.
  M <- matrix(ncol = Rk)
  V <- matrix(ncol = Rk)
  
  # Create data frame with result of cluster
  M <- tmp1[[1]]$M
  V <- tmp1[[1]]$V
  for(i in 2:length(tmp1)){
    M <- rbind(M, tmp1[[i]]$M)
    V <- rbind(V, tmp1[[i]]$V)
  }
  
  # Clear objects names
  rm(fn1, tmp1)
  
  # Transform each replicate to relative abundance.
  for(i in 1:n){
    x[i, ] <- sort(x[i, ] / sum(x[i, ]), decreasing = TRUE)
  }
  
  # Observed relative abundance mean and variance of replicates.
  M0 <- apply(x, 2, mean)
  V0 <- apply(x, 2, var)
  
  # Probability that the observed mean and variance are predicted by the model.
  pM0 <- c()
  pV0 <- c()
  for(i in 1:Rk){
    # p = (b+1)/(m+1)
    pM0[i] <- 2 * min((sum(M[ ,i] < M0[i]) + 1) / (nRand + 1),
                      (sum(M[ ,i] > M0[i]) + 1) / (nRand + 1))
    pV0[i] <- 2 * min((sum(V[ ,i] < V0[i]) + 1) / (nRand + 1),
                      (sum(V[ ,i] > V0[i]) + 1) / (nRand + 1))
  }
  
  # Global statistic (T observed) to combined p of all ranks.
  TM0 <- -2 * sum(log(pM0))
  TV0 <- -2 * sum(log(pV0))
  
  # Function to run in cluster
  fn2 <- function(core, rand, nRand, M, V, Rk){
    cldTM <- c()
    cldTV <- c()
    
    if(core == 1){
      range <- 1:rand[1]
    } else{
      range <- (sum(rand[1:(core - 1)]) + 1):sum(rand[1:core])
    }
    
    for(i in range){
      clpM <- c()
      clpV <- c()
      for(j in 1:Rk){
        # p = (b+1)/(m+1)
        clpM[j] <- 2 * min(((sum(c(M[-i,j], M0[j]) < M[i,j]) + 1) / (nRand + 1)), 
                           ((sum(c(M[-i,j], M0[j]) > M[i,j]) + 1) / (nRand + 1)))
        clpV[j] <- 2 * min(((sum(c(V[-i,j], V0[j]) < V[i,j]) + 1) / (nRand + 1)), 
                           ((sum(c(V[-i,j], V0[j]) > V[i,j]) + 1) / (nRand + 1)))
      }
      cldTM <- c(cldTM, (-2 * sum(log(clpM))))
      cldTV <- c(cldTV, (-2 * sum(log(clpV))))
    }
    return(list(dTM = cldTM, dTV = cldTV))
  }
  
  # Send function to cluster
  tmp2 <- clusterApplyLB(cl, seq(nc), fn2, rand = randc, nRand = nRand, M = M, V = V, Rk = Rk)
  
  # Distribution of T values.
  dTM <- c()
  dTV <- c()
  
  # Create a vector with results of cluster
  for(i in 1:length(tmp2)){
    dTM <- c(dTM, tmp2[[i]]$dTM)
    dTV <- c(dTV, tmp2[[i]]$dTV)
  }  
  
  # Clear objects names
  rm(fn2, tmp2)
  
  # Probability that T observed is drawn from T values generated by the model.
  pvalueM <- sum(dTM > TM0) / (nRand + 1)
  pvalueV <- sum(dTV > TV0) / (nRand + 1)
  
  # Simulation range for mean and variance.
  rM <- matrix(c(apply(M, 2, min), apply(M, 2, max)), nrow = 2, ncol = Rk, byrow = TRUE,
               dimnames = list(c("min", "max"), paste("rank", 1:Rk, sep = "")))
  rV <- matrix(c(apply(V, 2, min), apply(V, 2, max)), nrow = 2, ncol = Rk, byrow = TRUE,
               dimnames = list(c("min", "max"), paste("rank", 1:Rk, sep = "")))
  
  # Stop Cluster
  stopCluster(cl)
  
  return(new("fitmodel",
             call = list(model = model, nRepl = n, nRank = Rk, nRand = nRand, 
                         count = count),
             Tstats = list(dTmean = dTM, dTvar = dTV, TMobs = TM0, TVobs = TV0,
                           pvalue = matrix(c(pvalueM, pvalueV), nrow = 2, ncol = 1,
                                           dimnames = list(c("mean", "variance"),
                                                           "p-value"))),
             sim.stats = matrix(c(apply(M, 2, mean), apply(V, 2, mean)), nrow = 2,
                                ncol = Rk, byrow = TRUE,
                                dimnames = list(c("mean", "variance"),
                                                paste("rank", 1:Rk, sep = ""))),
             sim.range = list(mean = rM, variance = rV),
             obs.stats = matrix(c(M0, V0), nrow = 2, ncol = Rk, byrow = TRUE,
                                dimnames = list(c("mean", "variance"),
                                                paste("rank", 1:Rk, sep = "")))))
}
