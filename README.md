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

The nicheApport package provides: \* Simulate species abundance models:
Dominance Decay, Dominance Preemption, MacArthur Fraction, Random
Fraction, Random Assortment and Power Fraction; \* Fit simulated rank
abundance distribution to observed rank abundance data.

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

`{r echo=FALSE} knitr::opts_chunk$set(   warning = FALSE,   message = FALSE,   comment = "#>" )`

Installation
------------

### Stable version

`{r, eval = FALSE} library(devtools) install_github(repo = "mariojose/nicheApport", ref = "master", build_vignettes = TRUE)`

### Development version

This version have the last updates waiting to release.

`{r, eval = FALSE} library(devtools) install_github(repo = "mariojose/nicheApport", ref = "dev", build_vignettes = TRUE)`

Note that if you are running Microsoft Windows, you need to install the
[`Rtools`](https://cran.r-project.org/bin/windows/Rtools/index.html)
package to build vignettes locally. If you do not want build vignettes,
remove 'build\_vignettes = TRUE' argument.

Example of usage
----------------

We can simulate one of the six models informing number of species, total
abundance and type of data:

\`\`\`{r models\_examples} \# Load library library(nicheApport)

Dominance Decay model with 10 species and 100 individuals
=========================================================

('count = TRUE' define that data is discrete)
=============================================

dominanceDecay(N = 100, S = 10, count = TRUE)

Dominance Preemption model with 10 species and 100 kg,
======================================================

for instance, as total abundance.
=================================

('count = FALSE' define that data is continuous - default value)
================================================================

dominancePreemp(N = 100, S = 10, count = FALSE)

Power Fraction model with 10 species, 100 individuals and
=========================================================

'w' parameter iqual 0.2
=======================

powerFraction(N = 100, S = 10, w = 0.2, TRUE) \`\`\`

For fitting model to data we can use *fitmodel* function or *fitmodelCl*
function to run simulation in cluster mode.

\`\`\`{r fit\_example} \# Creating an abstract data with 10 replicates
and 40 ranks (species) dt &lt;- matrix(nrow = 10, ncol = 40) for(i in
1:length(dt\[ ,1\])){ dt\[i, \] &lt;- randFraction(N = 100, S = 40,
count = FALSE) }

Fitting model to data
=====================

m\_rf&lt;- fitmodel(x = dt, model = "randFraction", count = FALSE, nRand
= 99)

Printing statistics for fitting
===============================

m\_rf

Get simulated data statistics
=============================

m\_rf@sim.stats \`\`\`

Contribution and citation
-------------------------

The *nicheApport* project are hosted in
[GitHub](https://github.com/mariojose/nicheApport/) and [issues or bugs
report](https://github.com/mariojose/nicheApport/issues) are welcome.

For citing *nicheApport* use *citation(package = 'nicheApport')*
function in R.
