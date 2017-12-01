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
    >  [1] 22 21 17 13 11  7  5  2  1  1

    # Dominance Preemption model with 10 species and 100 kg,
    # for instance, as total abundance.
    # ('count = FALSE' define that data is continuous - default value)
    dominancePreemp(N = 100, S = 10, count = FALSE)
    >  [1] 8.861619e+01 7.084883e+00 3.125765e+00 8.971742e-01 2.551420e-01
    >  [6] 1.446771e-02 3.393429e-03 1.761890e-03 1.164150e-03 5.799162e-05

    # Power Fraction model with 10 species, 100 individuals and
    # 'w' parameter iqual 0.2
    powerFraction(N = 100, S = 10, w = 0.2, TRUE)
    >  [1] 71 12 11  2  2  1  1  0  0  0

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
    >   16.94   46.24   65.25   75.45   94.80  270.24 
    > Observed T: 70.65 
    > P-value for Tobs greater than simulated: 0.45 
    > 
    > Fitting for variance
    >    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    >   19.07   53.77   69.83   75.46   84.08  189.11 
    > Observed T: 69.08 
    > P-value for Tobs greater than simulated: 0.5

    # Get simulated data statistics
    m_rf@sim.stats
    >              rank1       rank2       rank3        rank4        rank5
    > mean     0.3532786 0.175613993 0.106818224 0.0749665872 0.0548358308
    > variance 0.0248254 0.004429653 0.001630069 0.0009301754 0.0005779578
    >                 rank6        rank7        rank8        rank9       rank10
    > mean     0.0421304441 0.0331702079 0.0263412601 0.0216182437 0.0176704283
    > variance 0.0003835257 0.0002776158 0.0001944418 0.0001506497 0.0001150552
    >                rank11       rank12       rank13       rank14       rank15
    > mean     1.462695e-02 1.211101e-02 0.0102752446 8.720522e-03 7.359538e-03
    > variance 8.608417e-05 6.652657e-05 0.0000534786 4.211843e-05 3.286876e-05
    >                rank16       rank17       rank18       rank19       rank20
    > mean     6.266746e-03 5.304002e-03 4.583175e-03 0.0038955928 3.363364e-03
    > variance 2.586693e-05 1.911249e-05 1.544908e-05 0.0000118524 9.495572e-06
    >                rank21       rank22       rank23       rank24       rank25
    > mean     2.844915e-03 2.422898e-03 2.068458e-03 1.767202e-03 1.481594e-03
    > variance 7.189085e-06 5.706368e-06 4.425798e-06 3.474574e-06 2.637814e-06
    >                rank26       rank27       rank28       rank29       rank30
    > mean     1.249436e-03 1.046576e-03 8.691352e-04 7.271212e-04 5.942907e-04
    > variance 1.980325e-06 1.487428e-06 1.117287e-06 8.598730e-07 6.446693e-07
    >                rank31       rank32       rank33       rank34       rank35
    > mean     4.835376e-04 3.938593e-04 3.108361e-04 2.442684e-04 1.878104e-04
    > variance 4.563575e-07 3.292669e-07 2.319184e-07 1.638432e-07 1.069888e-07
    >                rank36       rank37       rank38       rank39       rank40
    > mean     1.405871e-04 9.824123e-05 6.315027e-05 3.725813e-05 1.889382e-05
    > variance 7.141977e-08 3.898452e-08 1.885905e-08 7.676278e-09 2.757864e-09

Contribution and citation
-------------------------

The *nicheApport* project are hosted in
[GitHub](https://github.com/mariojose/nicheApport/) and [issues or bugs
report](https://github.com/mariojose/nicheApport/issues) are welcome.

For citing *nicheApport* use *citation(package = 'nicheApport')*
function in R.
