# nicheApport

#### Tokeshi's Niche Apportionment Species Abundance Distributions Models

**Mario Jose Marques-Azevedo**

### Description
`nicheApport` package simulate and fit the stochastic niche-oriented species abundance distribution models proposed by Tokeshi (1990, 1996). This package simulate species rank abundance distributions (RADs) and use Monte Carlo approach, proposed by Bersier & Sugihara (1997) and improved by Cassey & King (2001) and Mouillot et al. (2003), to fit models to replicated data.

The nicheApport package provides:
 * Simulate species abundance models: Dominance Decay, Dominance Preemption, MacArthur Fraction, Random Fraction, Random Assortment and Power Fraction;
 * Fit simulated rank abundance distribution to observed rank abundance data.

### References
Bersier, L.-F. & Sugihara, G. 1997. Species abundance patterns: the problem of testing stochastic models. *J. Anim. Ecol.* 66: 769-774.

Cassey, P. & King, R. A. R. 2001. The problem of testing the goodness-of-fit of stochastic resource apportionment models. *Environmetrics* 12: 691-698.

Mouillot, D. et al. 2003. How parasites divide resources: a test of the niche apportionment hypothesis. *J. Anim. Ecol.* 72: 757-764.

Tokeshi, M. 1990. Niche apportionment or random assortment: species abundance patterns revisited. *J. Anim. Ecol.* 59: 1129-1146.

Tokeshi, M. 1996. Power fraction: a new explanation of relative abundance patterns in species-rich assemblages. *Oikos* 75: 543-550.

### Installation

```r
library(devtools)
install_github(repo = "mariojose/nicheApport", ref = "master")
```

#### Development version
This version have the last updates waiting to release.
```r
library(devtools)
install_github(repo = "mariojose/nicheApport", ref = "dev")
```
