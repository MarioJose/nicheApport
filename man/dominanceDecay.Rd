\name{dominanceDecay}

\alias{dominanceDecay}

\title{Dominance Decay Model}

\description{
  Simulate ranked abundance distribution for Dominance Decay model. The total niche is sequential and randomly divided and largest fraction is always selected to be divided. First, total niche is divided randomly in two fraction. Then, the largest of this two fraction is selected and divided again in two fraction. The largest of this three fraction is selected and divided again in two fraction. This procedures is repeated until all species have a fraction of total niche. This model result in most evenness abundance distribution.
}

\usage{
  dominanceDecay(N, S, count = FALSE)
}

\arguments{
  \item{N}{Total abundance. See 'Details' for more information.}
  \item{S}{Number of species.}
  \item{count}{Specify if measure of abundance is number of individuals. See 'Details' for more information.}
}

\details{
  Abundance is a measure of the amount of each species and can be represented by number of individuals or biomass, dry weight or cover (Pielou 1975). If the argument \code{count} is \code{TRUE}, then each specie will have amount of individual in accordance with model rules. Note that some species may have zero individual if model rules result in hight dominance. If \code{count} is \code{FALSE} (default), then each species will have a fraction of total abundance. The values randomly generated to represent amount of niche to be divided follow the uniform distribution.
}

\value{
  A vector of ranked species abundance from the most abundant (rank 1) to the least abundant (rank \code{S}).
}

\references{
  Pielou, E. C. 1975. Ecological diversity. Wiley, New York.
  
  Tokeshi, M. 1990. Niche apportionment or random assortment: species abundance patterns revisited. \emph{J. Anim. Ecol.} 59: 1129-1146.
}

\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\seealso{
  For others models see \code{\link{dominancePreemp}}, \code{\link{MacArthurFraction}}, \code{\link{randFraction}}, \code{\link{randAssort}} and \code{\link{powerFraction}}.
  
  For fit models see \code{\link{fitmodel}} and \code{\link{fitmodelCl}} to fit using parellel computation. To find best \code{w} parameter to \code{\link{powerFraction}} see \code{\link{findPFw}}.
}

\examples{
  set.seed(42)
  dominanceDecay(100, 10)
}
