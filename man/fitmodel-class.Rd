\name{fitmodel-class}

\docType{class}

\alias{fitmodel-class}
\alias{hist,fitmodel-method}
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
      Object of class \code{"matrix"} containing mean and variance of simulated relative abundance of each rank.
    }
    \item{\code{sim.range}:}{
      Object of class \code{"list"} containing:
      \describe{
        \item{mean}{Matrix containing minimum and maximum simulatated relative abundance mean of each rank.}
        \item{variance}{Matrix containing minimum and maximum simulated relative abundance variance of each rank.}
      }
    }
    \item{\code{obs.stats}:}{
      Object of class \code{"matrix"} containing mean and variance observed relative abundance of each rank of all replicates.
    }
  }
}

\section{Methods}{
  \describe{
    \item{hist}{\code{signature(x = "fitmodel")}: Plot histogram of simulated \emph{T} values. Arguments are: \code{stat} and \code{arrow.col}.}
    \item{lines}{\code{signature(x = "fitmodel")}: Plot line of fitted model (mean of the each rank of the simulation for the model). Arguments are: \code{stat}, \code{base}, \code{range}, \code{range.lty} and \code{range.col}.}
    \item{plot}{\code{signature(x = "fitmodel")}: Plot the ranked observed abundance (mean of each rank of the observed data). Arguments are: \code{stat} and \code{base}.}
    \item{qqplot}{\code{signature(x = "fitmodel")}: Quantile-Quantile plot (mean of observed data versus mean of fitted model). Arguments are: \code{stat}, \code{base}, \code{range}, \code{qqline}, \code{range.lty}, \code{range.col}, \code{in.col} and \code{out.col}.}
    \item{show}{\code{signature(object = "fitmodel")}: Display the object summary.}
	}
  
  \subsection{Arguments}{
  \describe{
    \item{arrow.col}{Character informing the arrow color of observed \code{T} value at histogram plot.}
    \item{base}{Numeric informing the base of logarithm. If this value is different of \code{NULL}, then data are transformed to logarithm.}
    \item{in.col}{Character informing the color of observed fitted values (within of simulated range).}
    \item{out.col}{Character informing the color of observed non fitted values (out of simulated range).}
    \item{qqline}{Logical informing if qqline must be plotted.}
    \item{range}{Logical informing if minimum and maximum line must be plotted.}
    \item{range.col}{Character informing the color of range plot. When \code{NULL} (default) is equal to \code{col}.}
    \item{range.lty}{Numerical informing the line type of range plot.}
    \item{stat}{Character informing if line must be plotted using mean (\code{"mean"}) or variance (\code{"variance"}) of model simulation.}
  }}
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
  
  # QQplot
  qqplot(m1, base = 2, range = TRUE)
  
  # Histogram
  hist(m1)

  # List slots of S4 object slots
  getSlots('fitmodel')
  
  # Get slot with simulated stattistics
  m1@sim.stats

  # Get slot with observed data
  m1@obs.stats
}

\keyword{classes}
