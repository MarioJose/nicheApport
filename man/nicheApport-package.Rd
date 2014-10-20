\name{nicheApport-package}

\alias{nicheApport-package}
\alias{nicheApport}

\docType{package}

\title{Tokeshi's Niche Apportionment Species Abundance Distributions Models}

\description{
  \pkg{nicheApport} simulate and fit the stochastic niche-oriented species abundance distribution models proposed by Tokeshi (1990, 1996). The package \pkg{nicheApport} simulate species rank abundance distributions (RADs) and use Monte Carlo approach, proposed by Bersier & Sugihara (1997) and improved by Cassey & King (2001) and Mouillot et al. (2003), to fit models to replicated data.
}

\details{
  \tabular{ll}{
    Package: \tab nicheApport\cr
    Type: \tab Package\cr
    Version: \tab 1.0\cr
    Date: \tab 2014-07-17\cr
    License: \tab GPL-3\cr
  }
  
  Species abundance distributions may be described by statistical distribution models or niche partitioning approach. Tokeshi (1990 ,1996) proposed six stochastic niche partition models following some rules for this partition niche. Each of this models propose to explain how total niche can be apportioned among species of a community. Although Tokeshi (1990) proposed a goodness-of-fit to distinguish among models, the Monte Carlo approach proposed by Bersier & Sugihara, and improved by Cassey & King (2001) and Mouillot et al. (2003), correct some misleading of the first proposal. The \pkg{nicheApport} package provides:
  \itemize{
    \item Simulate species abundance models: Dominance Decay, Dominance Preemption, MacArthur Fraction, Random Fraction, Random Assortment and Power Fraction;
    \item Fit simulated rank abundance distribution to observed rank abundance data.
  }

}
\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\references{
  Bersier, L.-F. & Sugihara, G. 1997. Species abundance patterns: the problem of testing stochastic models. \emph{J. Anim. Ecol.} 66: 769-774.
  
  Cassey, P. & King, R. A. R. 2001. The problem of testing the goodness-of-fit of stochastic resource apportionment models. \emph{Environmetrics} 12: 691-698.
  
  Mouillot, D. et al. 2003. How parasites divide resources: a test of the niche apportionment hypothesis. \emph{J. Anim. Ecol.} 72: 757-764.
  
  Tokeshi, M. 1990. Niche apportionment or random assortment: species abundance patterns revisited. \emph{J. Anim. Ecol.} 59: 1129-1146.
  
  Tokeshi, M. 1996. Power fraction: a new explanation of relative abundance patterns in species-rich assemblages. \emph{Oikos} 75: 543-550.
}
