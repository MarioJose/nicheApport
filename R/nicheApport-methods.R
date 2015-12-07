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
            if(!is.null(base)){
              axis(side = 2, at = yTicks, las = 2, 
                   labels = parse(text=sprintf(paste(base, "^%d", sep = ""), yTicks)))
            }
            else axis(2, at = yTicks, las = 2)
          })

setMethod(f = "lines", signature = "fitmodel", 
          definition = function(x, stat = "mean", base = NULL, range = FALSE, ...){
            dots <- list(...)
            if(!stat %in% c("mean", "variance")) 
              stop("'stat' parameter must be 'mean' or 'variance'")
            
            if("lty" %in% dots) dots <- dots[names(dots) != "lty"]
            if(!"col" %in% names(dots)) dots$col <- "blue"
            if(!is.null(base)){
              sim.stats <- log(x@sim.stats[stat, ], base)
              sim.range <- log(x@sim.range[[stat]], base)
            }
            else{
              sim.stats <- x@sim.stats[stat, ]
              sim.range <- x@sim.range[[stat]]
            }
            
            do.call(lines, c(list(x = sim.stats), dots))
            if(range){
              do.call(lines, c(list(x = sim.range["min", ], lty = 2), dots))
              do.call(lines, c(list(x = sim.range["max", ], lty = 2), dots))
            }
          })

setMethod(f = "qqplot", signature = "fitmodel", 
          definition = function(x, stat = "mean", base = NULL, range = FALSE, ...){
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
            
            if("lty" %in% dots) dots <- dots[names(dots) != "lty"]

            if(!is.null(base)){
              sim.stats <- log(x@sim.stats[stat, ], base)
              sim.range <- log(x@sim.range[[stat]], base)
              obs.stats <- log(x@obs.stats[stat, ], base)
            }
            else{
              sim.stats <- x@sim.stats[stat, ]
              sim.range <- x@sim.range[[stat]]
              obs.stats <- x@obs.stats[stat, ]
            }
            
            dots$ylim <- c(min(c(sim.range["min", ], obs.stats)), 
                           max(c(sim.range["max", ], obs.stats)))
            
            do.call(plot, c(list(x = sim.stats, y = sim.stats, type = "l"), dots))
            
            if(range){
              lines(sim.stats, sim.range["min", ], lty = 2)
              lines(sim.stats, sim.range["max", ], lty = 2)
            }
            
            rank.fit <- rep(0, length(obs.stats))
            rank.fit[obs.stats >= sim.range["min", ] & obs.stats <= sim.range["max", ]] <- 1
            points(sim.stats[rank.fit == 0], obs.stats[rank.fit == 0], col = "#cccccc")
            points(sim.stats[rank.fit == 1], obs.stats[rank.fit == 1])            
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
            
            cat("Observed T:", object@Tstats$TMobs, "\n")
            cat("P-value for Tobs greater than simulated:", 
                object@Tstats$pvalue[1, ], "\n\n")
            
            cat("Fitting for variance\n")
            print(base::summary(object@Tstats$dTvar))
            cat("Observed T:", object@Tstats$TVobs, "\n")
            cat("P-value for Tobs greater than simulated:", 
                object@Tstats$pvalue[2, ], "\n")
          })
