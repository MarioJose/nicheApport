\name{randAssort}

\alias{randAssort}

\title{Random Assortment Model}

\description{
  Simulate ranked abundance distribution for Random Assortment model. Each fraction size is independent of others fractions, resulting in a random collection of arbitrary fractions sizes. If niches are ordered in rank from largest to the smallest, each rank is more abundant that next one. Then, if the first rank takes value 1, the second rank takes any value less than the first, the thirty takes any value less then the second and so on until all species has a fraction of niche.
}

\usage{
  randAssort(N, S, count = FALSE)
}

\arguments{
  \item{N}{Total abundance. See 'Details' for more information.}
  \item{S}{Number of species.}
  \item{count}{Specify if measure of abundance is number of individuals. See 'Details' for more information.}
}

\details{
  Abundance is a measure of the amount of each species and can be represented by number of individuals or biomass, dry weight or cover (Pielou 1975). If the argument \code{count} is \code{TRUE}, than each specie will have amount of individual in accordance with model rules. Note that some species may have zero individual if model rules result in hight dominance. But, since that premise of Random Assortment is that each specie has independent abundance, than each specie will have at least one individual. If \code{count} is \code{FALSE} (default), than each species will have a fraction of total abundance. The values randomly generated to represent amount of niche to be divided follow uniform distribution. All the fraction totalize more than 1, like described in Description section. Thus, relative abundance is calculated and multiplied to total abundance informed to result a correct abundance for each rank.
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
  For others models see \code{\link{dominanceDecay}}, \code{\link{dominancePreemp}}, \code{\link{MacArthurFraction}}, \code{\link{randFraction}} and \code{\link{powerFraction}}.
  
  For fit models see \code{\link{fitmodel}} and \code{\link{fitmodelCl}} to fit using parellel computation. To find best \code{w} parameter to \code{\link{powerFraction}} see \code{\link{findPFw}}.
}

\examples{
  set.seed(42)
  randAssort(100, 10)
}
