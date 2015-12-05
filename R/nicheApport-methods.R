setMethod(f = "plot", signature = "fittedmodel", 
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
            dots$xaxt <- "n"
            
            if(!is.null(base)){
              do.call(plot, c(list(x = log(x@obs.stats[stat, ], base), bty = "n", 
                                   yaxt = "n"), dots))
              axis(side = 2, axTicks(2), 
                   labels = parse(text=sprintf(paste(base, "^%d", sep = ""), 
                                               axTicks(2))), las=2)
            }
            else do.call(plot, c(list(x = x@obs.stats[stat, ], bty = "n"), dots))
            
            axis(1, c(1, axisTicks(c(1, dim(x@obs.stats)[2]), log = FALSE, nint = 5)))
          })

setMethod(f = "lines", signature = "fittedmodel", 
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
              lines(sim.range["min", ], lty = 2)
              lines(sim.range["max", ], lty = 2)
            }
          })

setMethod(f = "qqplot", signature = "fittedmodel", 
          definition = function(x, ...){
            
          })

setMethod(f = "summary", signature = "fittedmodel", 
          definition = function(object, ...){
            
          })

