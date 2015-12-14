setMethod(f = "plot", signature = "fitmodel", 
          definition = function(x, stat = "mean", base = NULL, ...){
            dots <- list(...)
            if(!stat %in% c("mean", "variance")) 
              stop("'stat' parameter must be 'mean' or 'variance'")
            
            if(!"xlab" %in% names(dots)) dots$xlab <- "Rank abundance"
            if(!"ylab" %in% names(dots)){
              if(is.null(base)) dots$ylab <- "Relative abundance"
              else dots$ylab <- substitute(expression(log[b]("Relative abundance")), 
                                           list(b = base))
            }

            dots$yaxt <- "n"
            dots$xaxt <- "n"
            
            if(!is.null(base)){
              obs.stats <- log(x@obs.stats[stat, ], base)
              yTicks <- axisTicks(range(obs.stats), log = FALSE, nint = 7)
            }
            else{
              obs.stats <- x@obs.stats[stat, ]
              yTicks <- axisTicks(c(0, max(obs.stats)), log = FALSE, nint = 7)
            }
    
            xTicks <- axisTicks(c(1, length(obs.stats)), log = FALSE, nint = 7)
            
            do.call(plot, c(list(x = obs.stats, bty = "n"), dots))
            
            axis(1, c(1, xTicks))
            axis(2, at = yTicks, las = 2)
          })

setMethod(f = "lines", signature = "fitmodel", 
          definition = function(x, stat = "mean", base = NULL, range = FALSE, range.lty = 2, range.col = NULL, ...){
            dots <- list(...)
            if(!stat %in% c("mean", "variance")) 
              stop("'stat' parameter must be 'mean' or 'variance'")
            
            if(!"col" %in% names(dots)) dots$col <- "blue"
            if(is.null(range.col)) range.col <- dots$col
            
            sim.sta <- x@sim.stats[stat, ]
            sim.min <- x@sim.range[[stat]]["min", ]
            sim.max <- x@sim.range[[stat]]["max", ]
            
            if(!is.null(base)){
              sim.sta <- log(sim.sta[sim.sta > 0], base)
              sim.min <- log(sim.min[sim.min > 0], base)
              sim.max <- log(sim.max[sim.max > 0], base)
            }
            
            do.call(lines, c(list(x = sim.sta), dots))
            if(range){
              lines(x = sim.min, lty = range.lty, col = range.col)
              lines(x = sim.max, lty = range.lty, col = range.col)
            }
          })

setMethod(f = "qqplot", signature = "fitmodel", 
          definition = function(x, stat = "mean", base = NULL, range = FALSE, 
                                qqline = TRUE, range.lty = 2, range.col = NULL,
                                in.col = "black", out.col = "grey70", ...){
            dots <- list(...)
            if(!stat %in% c("mean", "variance")) 
              stop("'stat' parameter must be 'mean' or 'variance'")
            
            if(!"xlab" %in% names(dots)){
              if(is.null(base)) dots$xlab <- "Simulated abundance"
              else dots$xlab <- substitute(expression(log[b]("Simulated abundance")), 
                                           list(b = base))
            } 
            if(!"ylab" %in% names(dots)){
              if(is.null(base)) dots$ylab <- "Observed abundance"
              else dots$ylab <- substitute(expression(log[b]("Observed abundance")), 
                                           list(b = base))
            }
            if(!"lty" %in% names(dots)) dots$lty <- 1
            if(!"col" %in% names(dots)) dots$col <- "black"
            if(is.null(range.col)) range.col <- dots$col

            obs.sta <- x@obs.stats[stat, ]
            sim.sta <- x@sim.stats[stat, ]
            sim.min <- x@sim.range[[stat]]["min", ]
            sim.max <- x@sim.range[[stat]]["max", ]
            min.fil <- sim.min > 0
            max.fil <- sim.max > 0
            
            if(!is.null(base)){
              obs.sta <- log(obs.sta, base)
              sim.sta <- log(sim.sta[sim.sta > 0], base)
              sim.min[min.fil] <- log(sim.min[min.fil], base)
              sim.max[max.fil] <- log(sim.max[max.fil], base)
            }
            
            if(range) 
              dots$ylim <- c(min(c(sim.min, obs.sta)), max(c(sim.max, obs.sta)))
            
            do.call(plot, c(list(x = sim.sta, y = sim.sta, type = "n"), dots))
            
            if(qqline) lines(x = sim.sta, y = sim.sta, lty = dots$lty, col = dots$col)
            
            if(range){
              lines(sim.sta[min.fil], sim.min[min.fil], lty = range.lty, col = range.col)
              lines(sim.sta[max.fil], sim.max[max.fil], lty = range.lty, col = range.col)
            }
            
            rank.fit <- vector("numeric", length(obs.sta))
            rank.fit[obs.sta >= sim.min & obs.sta <= sim.max] <- 1
            points(sim.sta[rank.fit == 0], obs.sta[rank.fit == 0], col = out.col)
            points(sim.sta[rank.fit == 1], obs.sta[rank.fit == 1], col = in.col)            
          })

setMethod(f = "hist", signature = "fitmodel", 
          definition = function(x, stat = "mean", arrow.col = "blue", ...){
            dots <- list(...)
            if(!stat %in% c("mean", "variance")) 
              stop("'stat' parameter must be 'mean' or 'variance'")
            
            if(!"xlab" %in% names(dots)) dots$xlab <- "T values"
            if(!"main" %in% names(dots)) dots$main <- ""
            
            if(stat == "mean"){
              sta <- x@Tstats$dTmean
              obs <- x@Tstats$TMobs
            }
            else {
              sta <- x@Tstats$dTvar
              obs <- x@Tstats$TVobs
            }
            
            hs <- do.call(hist, c(list(x = sta, xlim = c(0, max(sta, obs * 1.3))), dots))
            arrows(x0 = obs, x1 = obs, y0 = max(hs$counts) * 0.75, lwd = 2, 
                   y1 = min(hs$counts) * 1.1, length = 0.1, lty = 1.3, col = arrow.col)
            legend("topright", cex = 0.9, bty = "n",
                   legend = paste("TMobs =", round(obs, 2), "\npvalue =", 
                                  round(x@Tstats$pvalue[stat, ], 2)))
})

setMethod(f = "show", signature = "fitmodel", 
          definition = function(object){
            cat("Niche Apportionment fitting\n")
            cat("Data type:", ifelse(object@call$count, "discrete", "continuous"), "\n")
            cat("Model:", object@call$model, "\n")
            cat("\t\tNumber of randomization:", object@call$nRand, "\n")
            cat("\t\tNumber of ranks:", object@call$nRank, "\n")
            cat("\t\tNumber of replicates:", object@call$nRepl, "\n\n")
            
            cat("Fitting for mean\n")
            print(base::summary(object@Tstats$dTmean))
            cat("Observed T:", round(object@Tstats$TMobs, 2), "\n")
            cat("P-value for Tobs greater than simulated:", 
                round(object@Tstats$pvalue[1, ], 4), "\n\n")
            
            cat("Fitting for variance\n")
            print(base::summary(object@Tstats$dTvar))
            cat("Observed T:", round(object@Tstats$TVobs, 2), "\n")
            cat("P-value for Tobs greater than simulated:", 
                round(object@Tstats$pvalue[2, ], 4), "\n")
          })
