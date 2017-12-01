nicheApport
===========

#### Tokeshi's Niche Apportionment Species Abundance Distributions Models

**Mario J. Marques-Azevedo**

Description
-----------

`nicheApport` package simulate and fit the stochastic niche-oriented
species abundance distribution models proposed by Tokeshi (1990, 1996).
This package simulate species rank abundance distributions (RADs) and
use Monte Carlo approach, proposed by Bersier & Sugihara (1997) and
improved by Cassey & King (2001) and Mouillot et al. (2003), to fit
models to replicated data.

The nicheApport package provides:

-   Simulate species abundance models: Dominance Decay, Dominance
    Preemption, MacArthur Fraction, Random Fraction, Random Assortment
    and Power Fraction;

-   Fit simulated rank abundance distribution to observed rank
    abundance data.

### References

Bersier, L.-F. & Sugihara, G. 1997. Species abundance patterns: the
problem of testing stochastic models. *J. Anim. Ecol.* 66: 769-774.

Cassey, P. & King, R. A. R. 2001. The problem of testing the
goodness-of-fit of stochastic resource apportionment models.
*Environmetrics* 12: 691-698.

Mouillot, D. et al. 2003. How parasites divide resources: a test of the
niche apportionment hypothesis. *J. Anim. Ecol.* 72: 757-764.

Tokeshi, M. 1990. Niche apportionment or random assortment: species
abundance patterns revisited. *J. Anim. Ecol.* 59: 1129-1146.

Tokeshi, M. 1996. Power fraction: a new explanation of relative
abundance patterns in species-rich assemblages. *Oikos* 75: 543-550.

Installation
------------

### Stable version

    library(devtools)
    install_github(repo = "mariojose/nicheApport", ref = "master", build_vignettes = TRUE)

### Development version

This version have the last updates waiting to release.

    library(devtools)
    install_github(repo = "mariojose/nicheApport", ref = "dev", build_vignettes = TRUE)

Note that if you are running Microsoft Windows, you need to install the
[`Rtools`](https://cran.r-project.org/bin/windows/Rtools/index.html)
package to build vignettes locally. If you do not want build vignettes,
remove 'build\_vignettes = TRUE' argument.

Example of usage
----------------

We can simulate one of the six models informing number of species, total
abundance and type of data:

    # Load library
    library(nicheApport)

    # Dominance Decay model with 10 species and 100 individuals
    # ('count = TRUE' define that data is discrete)
    dominanceDecay(N = 100, S = 10, count = TRUE)
    >  [1] 17 17 12 12 11  9  7  7  6  2

    # Dominance Preemption model with 10 species and 100 kg,
    # for instance, as total abundance.
    # ('count = FALSE' define that data is continuous - default value)
    dominancePreemp(N = 100, S = 10, count = FALSE)
    >  [1] 7.288709e+01 2.330507e+01 3.683463e+00 7.807442e-02 3.385535e-02
    >  [6] 1.207574e-02 3.693183e-04 2.271262e-06 1.322838e-06 4.708442e-07

    # Power Fraction model with 10 species, 100 individuals and
    # 'w' parameter iqual 0.2
    powerFraction(N = 100, S = 10, w = 0.2, TRUE)
    >  [1] 42 22 16  9  5  4  1  1  0  0

For fitting model to data we can use *fitmodel* function or *fitmodelCl*
function to run simulation in cluster mode.

    # Creating an abstract data with 10 replicates and 40 ranks (species)
    dt <- matrix(nrow = 10, ncol = 40)
    for(i in 1:length(dt[ ,1])){
      dt[i, ] <- randFraction(N = 100, S = 40, count = FALSE)
    }

    # Fitting model to data
    m_rf<- fitmodel(x = dt, model = "randFraction", count = FALSE, nRand = 99)

    # Printing statistics for fitting
    m_rf
    > Niche Apportionment fitting
    > Data type: continuous 
    > Model: randFraction 
    >       Number of randomization: 99 
    >       Number of ranks: 40 
    >       Number of replicates: 10 
    > 
    > Fitting for mean
    >    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    >   18.87   44.58   59.83   75.17   96.92  249.29 
    > Observed T: 98.1 
    > P-value for Tobs greater than simulated: 0.24 
    > 
    > Fitting for variance
    >    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    >   27.82   53.16   68.61   74.21   87.54  182.54 
    > Observed T: 192.93 
    > P-value for Tobs greater than simulated: 0

    # Get simulated data statistics
    m_rf@sim.stats
    >               rank1       rank2       rank3        rank4        rank5
    > mean     0.35346394 0.172064019 0.107631889 0.0746136716 0.0554965529
    > variance 0.02729775 0.004558392 0.001721746 0.0008838744 0.0005735733
    >                 rank6       rank7        rank8        rank9       rank10
    > mean     0.0424598395 0.033592337 0.0269939667 0.0218551241 0.0178165851
    > variance 0.0003837577 0.000271175 0.0002051491 0.0001543256 0.0001167225
    >                rank11       rank12       rank13       rank14       rank15
    > mean     1.488136e-02 1.232765e-02 1.038316e-02 8.910712e-03 7.531478e-03
    > variance 8.745819e-05 6.451295e-05 5.007444e-05 4.061548e-05 3.232488e-05
    >                rank16       rank17       rank18       rank19       rank20
    > mean     6.344476e-03 5.425695e-03 4.641984e-03 3.946289e-03 3.339890e-03
    > variance 2.450332e-05 1.950282e-05 1.577709e-05 1.242384e-05 9.697496e-06
    >                rank21       rank22       rank23       rank24       rank25
    > mean     2.825188e-03 2.376024e-03 1.984426e-03 1.681094e-03 1.409751e-03
    > variance 7.420778e-06 5.485287e-06 4.229102e-06 3.302857e-06 2.467756e-06
    >                rank26       rank27       rank28       rank29       rank30
    > mean     1.172788e-03 9.793651e-04 8.238802e-04 6.752213e-04 5.600907e-04
    > variance 1.752866e-06 1.333184e-06 1.037953e-06 7.532167e-07 5.469703e-07
    >                rank31       rank32       rank33       rank34       rank35
    > mean     4.544333e-04 3.665674e-04 2.881572e-04 2.181292e-04 1.641016e-04
    > variance 3.725015e-07 2.569343e-07 1.701734e-07 1.001785e-07 6.321146e-08
    >                rank36       rank37       rank38       rank39       rank40
    > mean     1.190960e-04 8.155040e-05 5.499667e-05 3.070667e-05 1.380774e-05
    > variance 3.720048e-08 2.038689e-08 1.202986e-08 4.048009e-09 1.383442e-09

Contribution and citation
-------------------------

The *nicheApport* project are hosted in
[GitHub](https://github.com/mariojose/nicheApport/) and [issues or bugs
report](https://github.com/mariojose/nicheApport/issues) are welcome.

For citing *nicheApport* use *citation(package = 'nicheApport')*
function in R.
