\name{findPFw}

\alias{findPFw}

\title{Find Power Fraction \code{w} parameter}

\description{
  This function call \code{\link{fitmodel}} or \code{\link{fitmodelCl}} to find the Power Fraction \code{w} parameter that best fit model to data. A sequence of \code{w} value will be created and fit procedures will check fit each of this \code{w} values to data.
}

\usage{
  findPFw(x, count, ws = 0, we = 1, f = 0.01, nRand = 99, cl = TRUE, nCores = 1)
}

\arguments{
  \item{x}{Data frame or matrix with total species rank (from largest abundance to smallest) at columns and replicates at rows. See 'Details' for more information.}
  \item{count}{Specify if measure of abundance is number of individuals. See 'Details' for more information.}
  \item{ws}{Star value of Power Fraction \code{w} parameter.}
  \item{we}{End value of Power Fraction \code{w} parameter.}
  \item{f}{Number of increment to sequence of \code{w} values.}
  \item{nRand}{Number of simulations.}
  \item{cl}{Logical value indicating if parallel computation must be used to find best \code{w}. See 'Details' for more information.}
  \item{nCores}{Number indicating number of processor cores or threads to be used to simulation. See 'Details' for more information.}
}

\details{
  The replicates in data frame or matrix \code{x} must be in rows and ranked by abundance. First rank (column 1) will be species with largest abundance, second column with second largest abundance, and so on until the species with smallest abundance. Note that this protocol do not require species identification. First rank of replicates 1, for instance, may be not the same as first rank of replicates 2. Note too that number of species may be differ among replicates. In this case, zeros must be used to the rank(s).
  
  The fit use the protocol proposed by Cassey & King (2001) and ranked relative abundance recommendations by Mouillot et al. (2003), with some modifications. For more information of procedures consult documentation of \code{\link{fitmodel}} or \code{\link{fitmodelCl}}.
  
  For more details see Bersier & Sugihara (1997), Cassey & King (2001) and Mouillot et al. (2003). Observed abundance fit to the model if p-value to means and variances are not significant at predetermined significance level. The observed T value (TMobs or TVobs, see 'Value' bellow) measure how well model fits to data; better fit had smaller value (Bersier & Sugihara 1997).
  
  If \code{cl} is \code{TRUE} the function fit model to data calling \code{fitmodelCl} for parallel computation to divide the number of simulations among the processor cores or threads that run the procedures simultaneously. If \code{cl} is \code{FALSE} the function call \code{fitmodel} to fit model to data. When \code{nCores = 1} the function detect number of cores or threads automatically. If you inform incorrectly the number of cores or threads, the function will inform you to correct information or will recommend to use \code{fitmodel}. The overall process using parallel computation can be twice as fast, depending on the number of processor cores or threads used.
}

\value{
  Data frame with follow columns:
  \item{w}{Squence of Power Fraction \emph{w} values.}
  \item{TMobs}{Observed value of \emph{T} for mean.}
  \item{TVobs}{Observed value of \emph{T} for variance.}
  \item{pvalueM}{P-value for mean.}
  \item{pvalueV}{P-value for variance.}
  For more information about values consult documentation of \code{\link{fitmodel}} or \code{\link{fitmodelCl}}.
}

\references{
  Bersier, L.-F. & Sugihara, G. 1997. Species abundance patterns: the problem of testing stochastic models. \emph{J. Anim. Ecol.} 66: 769-774.

  Cassey, P. & King, R. A. R. 2001. The problem of testing the goodness-of-fit of stochastic resource apportionment models. \emph{Environmetrics} 12: 691-698.

  Mouillot, D. et al. 2003. How parasites divide resources: a test of the niche apportionment hypothesis. \emph{J. Anim. Ecol.} 72: 757-764.

  Tokeshi, M. 1996. Power fraction: a new explanation of relative abundance patterns in species-rich assemblages. \emph{Oikos} 75: 543-550.
}

\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\seealso{
  For models see \code{\link{dominanceDecay}}, \code{\link{dominancePreemp}}, \code{\link{MacArthurFraction}}, \code{\link{randFraction}}, \code{\link{randAssort}} and \code{\link{powerFraction}}.
  
  For fit models see \code{\link{fitmodel}} and \code{\link{fitmodelCl}} to fit using parellel computation.
}

\examples{
  data <- matrix(nrow = 10, ncol = 40)
  for(i in 1:length(data[ ,1])){
    data[i, ] <- powerFraction(N = 100, S = 40, w = 0.2, count = FALSE)
  }
  findPFw(data, count = FALSE, ws = 0.16, we = 0.22, f = 0.01, nRand = 99, cl = TRUE, nCores = 2)
}
