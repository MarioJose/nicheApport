\name{powerFraction}

\alias{powerFraction}

\title{Power Fraction Model}

\description{
  Simulate a ranked abundance distribution for Power Fraction model. The total niche is sequential and randomly divided and probability \emph{p} of selection of a fraction is positively related with fraction length \emph{x} as a power function (\emph{p*x^w}, where 0 < emph{w} < 1). Fractions length or abundances are weighted by parameter \emph{w} to define probability of selection of fractions. Then, larger fractions will have more probability of being selected, weighted by their abundances by parameter \emph{w}. First, total niche is divided randomly in two fraction. Then, one of this two fraction is selected, with probability of selection of each fraction emph{p*x^w}, and divided again in two fraction. One of this three fraction is selected, again with probability \emph{p*x^w} for each fraction, and divided again in two fraction. This procedures is repeated until all species have a fraction of total niche.
}

\usage{
  powerFraction(N, S, w = 0.2, count = FALSE)
}

\arguments{
  \item{N}{Total abundance. See 'Details' for more information.}
  \item{S}{Number of species.}
  \item{w}{Exponential parameter to weighting fraction selection by abundance. See 'Details' for more information.}
  \item{count}{Specify if measure of abundance is number of individuals. See 'Details' for more information.}
}

\details{
  Abundance is a measure of the amount of each species and can be represented by number of individuals or biomass, dry weight or cover (Pielou 1975). If the argument \code{count} is \code{TRUE}, then each specie will have amount of individual in accordance with model rules. Note that some species may have zero individual if model rules result in hight dominance. If \code{count} is \code{FALSE} (default), then each species will have a fraction of total abundance. The values randomly generated to represent amount of niche to be divided follow uniform distribution.
  
  The Random Fraction and MacArthur Fraction models are special cases of Power fraction model. When \emph{w} = 0, Power Fraction correspond to Random Fraction and when \emph{w} = 1 correspond to MacArthur Fraction. Tokesh (1996) proposed this model as alternative to species-rich communities in face of other model fit well in species-poor communities. The author verified that Power Fraction with \emph{w} = 0.2 fit well to many species-rich communities analysed.
}

\value{
  A vector of ranked species abundance from the most abundant (rank 1) to the least abundant (rank \code{S}).
}

\references{
  Pielou, E. C. 1975. Ecological diversity. Wiley, New York.
  
  Tokeshi, M. 1996. Power fraction: a new explanation of relative abundance patterns in species-rich assemblages. \emph{Oikos} 75: 543-550.
}

\author{
  Mario J. Marques-Azevedo

  Maintainer: Mario J. Marques-Azevedo <mariojmaaz@gmail.com>
}

\seealso{
  For others models see \code{\link{dominanceDecay}}, \code{\link{dominancePreemp}}, \code{\link{MacArthurFraction}}, \code{\link{randFraction}} and \code{\link{randAssort}}.
  
  For fit models see \code{\link{fitmodel}} and \code{\link{fitmodelCl}} to fit using parellel computation. To find best \code{w} parameter to \code{\link{powerFraction}} see \code{\link{findPFw}}.
}

\examples{
  set.seed(42)
  powerFraction(100, 10, w = 0.2)
}
