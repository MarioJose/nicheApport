\name{fitmodel-class}

\docType{class}

\alias{fitmodel-class}
\alias{lines,fitmodel-method}
\alias{plot,fitmodel-method}
\alias{qqplot,fitmodel-method}
\alias{show,fitmodel-method}

\title{Class \code{"fitmodel"} from Niche Apportionment fitting}

\description{Encapsulate results from Niche Apportionment fitting}

\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("fitmodel", ...)}. Object results mainly from procedures executed from \code{\link{fitmodel}} or \code{\link{fitmodelCl}} call.
}

\section{Slots}{
  \describe{
    \item{\code{call}:}{
      Object of class \code{"list"} containing:
      \describe{
        \item{model}{Character containing model name.}
        \item{nRepl}{Number of replicates.}
        \item{nRank}{Number of ranks.}
        \item{nRand}{Number of randomizations.}
        \item{count}{Logical value informing if observed values are counts (discrete).}
      }
    }
    \item{\code{Tstats}:}{
      Object of class \code{"list"} containing: 
      \describe{
        \item{dTmean}{Vector containing distribution of \emph{T} values for mean.}
        \item{dTvar}{Vector containing distribution of \emph{T} values for variance.}
        \item{TMobs}{Observed value of \emph{T} for mean.}
        \item{TVobs}{Observed value of \emph{T} for variance.}
        \item{pvalue}{Matrix containing p-value for mean and variance.}
      }
    }
    \item{\code{sim.stats}:}{
      Object of class \code{"matrix"} containing mean and variance of simulations to each rank.
    }
    \item{\code{sim.range}:}{
      Object of class \code{"list"} containing:
      \describe{
        \item{mean}{Matrix containing minimum and maximum simulation values for mean of each rank.}
        \item{variance}{Matrix containing minimum and maximum simulation values for variance of each rank.}
      }
    }
    \item{\code{obs.stats}:}{
      Object of class \code{"matrix"} containing mean and variance of replicates observed to each rank.
    }
  }
}

\section{Methods}{
  \describe{
    \item{lines}{\code{signature(x = "fitmodel")}: Plot line of fitted model.}
    \item{plot}{\code{signature(x = "fitmodel")}: Plot ranked abundance.}
    \item{qqplot}{\code{signature(x = "fitmodel")}: Quantile-Quantile plot.}
    \item{show}{\code{signature(object = "fitmodel")}: Display object.}
    
    The methods \code{lines}, \code{plot} and \code{qqplot} accept parameters \code{stat} and \code{base}. Further the methods \code{lines} and \code{qqplot} accept parameter \code{range}. The parameter \code{stat} inform if line must be plotted using mean (\code{"mean"}) or variance (\code{"variance"}) of model simulation. The \code{base} parameter inform the base of logarithm. If this value is different of \code{NULL}, then data are transformed to logarithm. The \code{range} parameter inform if minimum and maximum line must be plotted.
	 }
}

\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\examples{
  data <- matrix(nrow = 10, ncol = 40)
  for(i in 1:length(data[ ,1])){
    data[i, ] <- randFraction(N = 100, S = 40, count = FALSE)
  }
  m1 <- fitmodelCl(x = data, model = "randFraction", count = FALSE, nRand = 99, nCores = 2)
  m1
  plot(m1, base = 2)
  lines(m1, base = 2, range = TRUE)
  
  # For qqplot
  qqplot(m1, base = 2, range = TRUE)
}

\keyword{classes}
