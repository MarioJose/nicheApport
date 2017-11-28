\name{fitmodel}

\alias{fitmodel}
\alias{fitmodelCl}

\title{Fitting of species rank abundance distribution to data}

\description{
  Fits niche apportionment models, proposed by Tokeshi (1990, 1996), using procedures proposed by Bersier & Sugihara (1997) and modified by Cassey & King (2001) and Mouillot et al. (2003). The protocol use relative abundance to fit simulated species rank abundance of particular model to observed rank abundance using Monte Carlo approach. The \code{fitmodelCl} function use parallel computation for run simulations.
}

\usage{
  fitmodel(x, model, count, nRand = 999, \dots)
  fitmodelCl(x, model, count, nRand = 999, nCores = 2, \dots)
}

\arguments{
  \item{x}{Data frame or matrix with species ranks (ordered from largest abundance to smallest) at columns and replicates at rows. See 'Details' for more information.}
  \item{model}{String containing one of follow values: "dominanceDecay", "dominancePreemp", "MacArthurFraction", "powerFraction", "randAssort", "randFraction".}
  \item{count}{Define if measure of abundance is number of individuals. See 'Details' for more information.}
  \item{nRand}{Number of simulations.}
  \item{nCores}{Number indicating number of processor cores or threads to be used for simulation. See 'Details' for more information.}
  \item{\dots}{Arguments to be passed to functions. This is used when fit Power Fraction model to inform value of parameter \code{w}.}
  \item{}{\code{w}\cr
    Number informing exponential parameter to weighting fraction selection by abundance. See 'Details' of \code{\link{powerFraction}} for more information.
  }
}

\details{
  The replicates in data frame or matrix \code{x} must be in rows and ranked by abundance. First rank (column 1) will be species with largest abundance, second column with second largest abundance, and so on until the species with smallest abundance. Note that this protocol do not require species identification. First rank of replicates 1, for instance, may be not the same as first rank of replicates 2. Note too that number of species may be differ among replicates. In this case, zeros must be used to the rank(s).
  
  The fit use the protocol proposed by Cassey & King (2001) and ranked relative abundance recommendations by Mouillot et al. (2003), with some modifications, as the follow:
  \enumerate{
    \item{Run ranked observed abundance of specified model of each replicates, retaining the total abundance and number of ranks present in each replicate. Transform simulated abundance to relative abundance and calculate mean (\code{M}) and variance (\code{V}) of each rank for all replicates \code{n}. This procedures is repeated \code{nRand} times and result in \code{nRand} \code{M} and \code{V} for all \code{S} ranks.}
    \item{Transform observed abundance of each replicates in relative abundance, retaining the rank.}
    \item{Calculate mean (\code{M0}) and variance (\code{V0}) of each rank for observed replicates.}
    \item{Calculate the estimated p-value for mean of each rank \code{M0[S]} in \code{nRand} simulated rank \code{M[S]}:
    
    \code{p(M)[S] = 2 * min((bl + 1) / (nRand + 1), (bs + 1) / (nRand + 1))},
    
    where \code{bl} is the number of simulated means (\code{M[S]}) larger than \code{M0[S]}, \code{bs} is the number of simulated means (\code{M[S]}) smaller than \code{M0[S]}. This procedures is the same to variances (\code{p(V)[S]}).}
    \item{Summarize estimated p-values for mean (\code{p(M)[S]}) and variances (\code{p(V)[S]}) calculating \code{T0} as follow:
    
    \code{T0(M0) = - 2 sum(log(p[S](M)))} and \code{T0(V0) = - 2 sum(log(p[S](V)))}.}
    
    \item{Calculate the distribution of \emph{T} of each rank as follow: for each \code{M[S]} of all \code{nRand} means simulations calculate \code{T(M)} using steps 4-5. This procedures is the same to variances \code{T(V)}.}
    \item{Calculate the final estimated p-value to fit data for model as follow:
    
    \code{p-value = t / (nRand + 1)},
    
    where \code{t} is the number of \code{T(M)} values greater than \code{T0(M0)}. The same for variance.}
  }
  For more details see Bersier & Sugihara (1997), Cassey & King (2001) and Mouillot et al. (2003). Model fits to the observed abundance if p-value to means and variances are not significant at predetermined significance level (probability of found observed \emph{T} at simulated \emph{T}). The observed \emph{T} value (\code{TMobs} or \code{TVobs}, see 'Value' bellow) measure how well model fits to data; better fit had smaller value (Bersier & Sugihara 1997).
  
  \code{fitmodelCl} use parallel computation to divide the number of simulations among the processor cores or threads and run the procedures simultaneously. When \code{nCores = 1} the function detect number of cores or threads automatically. If you inform incorrectly the number of cores or threads, the function will inform you to correct information or will recommend to use \code{fitmodel}. The overall process using parallel computation can be twice as fast, depending on the number of processor cores or threads used.
}

\value{
  An object of class \code{fitmodel}.
}

\references{
  Bersier, L.-F. & Sugihara, G. 1997. Species abundance patterns: the problem of testing stochastic models. \emph{J. Anim. Ecol.} 66: 769-774.

  Cassey, P. & King, R. A. R. 2001. The problem of testing the goodness-of-fit of stochastic resource apportionment models. \emph{Environmetrics} 12: 691-698.

  Mouillot, D. et al. 2003. How parasites divide resources: a test of the niche apportionment hypothesis. \emph{J. Anim. Ecol.} 72: 757-764.

  Tokeshi, M. 1990. Niche apportionment or random assortment: species abundance patterns revisited. \emph{J. Anim. Ecol.} 59: 1129-1146.

  Tokeshi, M. 1996. Power fraction: a new explanation of relative abundance patterns in species-rich assemblages. \emph{Oikos} 75: 543-550.
}

\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\seealso{
  For models see \code{\link{dominanceDecay}}, \code{\link{dominancePreemp}}, \code{\link{MacArthurFraction}}, \code{\link{randFraction}}, \code{\link{randAssort}} and \code{\link{powerFraction}}.
  
  For fit models see \code{\link{fitmodel}}. To find best \code{w} parameter to \code{\link{powerFraction}} see \code{\link{findPFw}}.
  
  For class see \code{\linkS4class{fitmodel}}.
}
\examples{
  data <- matrix(nrow = 10, ncol = 40)
  for(i in 1:length(data[ ,1])){
    data[i, ] <- randFraction(N = 100, S = 40, count = FALSE)
  }
  m1 <- fitmodelCl(x = data, model = "randFraction", count = FALSE, nRand = 99, nCores = 2)
  m1

  # Get simulated data statistics
  m1@sim.stats
}
