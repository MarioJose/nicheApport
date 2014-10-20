\name{MacArthurFraction}

\alias{MacArthurFraction}

\title{MacArthur Fraction Model}

\description{
  Simulate ranked abundance distribution for MacArthur Fraction model. The total niche is sequential and randomly divided and probability of selection of a fraction is positively related with fraction length. First, total niche is divided randomly in two fraction. Then, one of this two fraction is selected, with larger fraction having more probability of selection than smaller one, and divided again in two fraction. One of this three fraction is selected, again with probability related with fraction length, and divided again in two fraction. This procedures is repeated until all species have a fraction of total niche.
}

\usage{
  MacArthurFraction(N, S, count = FALSE)
}

\arguments{
  \item{N}{Total abundance. See 'Details' for more information.}
  \item{S}{Number of species.}
  \item{count}{Specify if measure of abundance is number of individuals. See 'Details' for more information.}
}

\details{
  Abundance is a measure of the amount of each species and can be represented by number of individuals or biomass, dry weight or cover (Pielou 1975). If the argument \code{count} is \code{TRUE}, then each specie will have amount of individual in accordance with model rules. Note that some species may have zero individual if model rules result in hight dominance. If \code{count} is \code{FALSE} (default), then each species will have a fraction of total abundance. The values randomly generated to represent amount of niche to be divided follow uniform distribution.
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
  For other models see \code{\link{dominanceDecay}}, \code{\link{dominancePreemp}}, \code{\link{randFraction}}, \code{\link{randAssort}} and \code{\link{powerFraction}}.
  
  For fit models see \code{\link{fitmodel}} and \code{\link{fitmodelCl}} to fit using parellel computation. To find best \code{w} parameter to \code{\link{powerFraction}} see \code{\link{findPFw}}.
}

\examples{
  set.seed(42)
  MacArthurFraction(100, 10)
}
