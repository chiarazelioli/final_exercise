

n_subsample = 100000 # or 10000, 50000

# depending on the number of the SNPs, retain x PCs (for optimization, see ...)
if( n_subsample == 100000)
  n_PCs <- 780

## genetic architecture for the simulation and effect sizes
pi1 <- 0.9 # probability for an effect to be 0
pi2 <- 0    # " ~ N(0,10^-4)
pi3 <- 0    # " ~ N(0,10^-3)
pi4 <- 0.1 # " ~ N(0,10^-2)
pi <- c(pi1, pi2, pi3, pi4)

# variances (effect sizes)
sigma1 <- 0
sigma2 <- 1e-4
sigma3 <- 1e-3
sigma4 <- 1e-2
sigma <- c(sigma1, sigma2, sigma3, sigma4)

# comparison with the fixed prior
varA <- 0.33
#u.prior.var <- varA/tot_PCvar





