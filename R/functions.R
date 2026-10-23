

## prepare matrix of PCs --------------------------------------------- -
prepare_PCs <- function(XX, n_PCs) {

  # scale all PCs with the standard deviation of the first PC, and center
  varPC1 <- var(XX[,1]) # 1
  XX <- XX*((1/sqrt(varPC1)))
  XX <- scale(XX, center = TRUE, scale = FALSE)

  # retain n_PCs
  XX_red <- XX[,1:n_PCs]
  PCvar <- colVars(XX_red)
  tot_PCvar <- sum(PCvar)

  # return
  return(list(XX_red, tot_PCvar))
}



## simulate phenotypes ----------------------------------------------- -

simulate_pheno <- function(pi, sigma, SNP_unscaled) {

  Nanimals <- nrow(SNP_unscaled)

  set.seed(788)
  # random sampling integers 0-3, with probabilities set above
  dist_choice <- sample(c(0:3), n_subsample, replace = TRUE, prob = pi)
  effect_sizes <- c(NA)

  # set effect sizes for each SNP
  for (ii in 1:n_subsample) {
    if (dist_choice[ii]==0) {
      effect_sizes[ii] <- rnorm(1,0,sqrt(sigma1))  }
    if (dist_choice[ii]==1) {
      effect_sizes[ii] <- rnorm(1,0,sqrt(sigma2))  }
    if (dist_choice[ii]==2) {
      effect_sizes[ii] <- rnorm(1,0,sqrt(sigma3))  }
    if (dist_choice[ii]==3) {
      effect_sizes[ii] <- rnorm(1,0,sqrt(sigma4))  }  }

  # generate breeding values (bv)
  aa <- SNP_unscaled %*% effect_sizes
  aa <- aa/sd(aa) # scale st var(bv)=1

  ### fixed effects
  # here one binary (sex) and one contin (age)
  set.seed(788)
  sex <- rbinom(Nanimals, size = 1, prob = 0.5)
  age <- rnorm(Nanimals, mean = 0, sd = 1)

  # true coefficients
  beta0 <- 1
  beta_sex <- 0.5
  beta_age <- -0.3

  # contribution to the phenotype
  bb <- beta0 + beta_sex * sex + beta_age * age

  ### environmental random effects
  set.seed(788)
  n_sites <- 30

  # assign each individual to an environmental site
  site <- factor(sample( seq_len(n_sites), size = Nanimals, replace = TRUE ),
                 levels = seq_len(n_sites))
  W <- model.matrix(~ site - 1) # design matrix
  d_site <- rnorm(n_sites, mean = 0, sd = sqrt(0.25))
  dd <- as.numeric(W %*% d_site) # individual contribuition

  ### residuals
  ee <- rnorm(Nanimals,0,sd=sqrt(0.1))

  ### simulated phenotypes
  yy <- bb + aa + dd + ee

  return(list(yy, bb, aa, dd, ee))
}


# ## create train and test set ----------------------------------------- -
#
# split_train_test <- function(yy, W){
#   set.seed(788)
#   t.sample <- sample(1:Nanimals,round(Nanimals/5),replace=FALSE) #FALSE -> each index can only be selected once (unique subset)
#   fold1 <- t.sample # sampled indices, which will be used as training set
#   # individual IDs
#   IDC4 <- c(1:Nanimals)
#   data <- as.data.frame(IDC4)
#   # adding the simulated phenotypes
#   data$yy <- yy
#   data <- as.data.frame(data)
#   # we exclude the first fold from the fitting procedure
#   data$yy_CV <- data$yy
#   # replacing all phenotypes for the individuals in the first fold with NA.
#   fold <- as.vector(fold1)
#   data$yy_CV[data$IDC4 %in% fold] <- NA
#
#   # separate indices
#   test_idx  <- fold
#   train_idx <- setdiff(1:Nanimals, test_idx)
#
#   # train-test resp
#   y_train <- yy[train_idx]
#   y_test <- yy[test_idx]
#
#   # train-test PCs
#   PC_train <- XX_red[train_idx, , drop = FALSE]
#   PC_test  <- XX_red[test_idx, , drop = FALSE]
#
#   # train-test fixed efects (sex, age)
#   sex_train  <- sex[train_idx]
#   age_train  <- age[train_idx]
#
#   sex_test <- sex[test_idx]
#   age_test <- age[test_idx]
#
#   # train-test enviro random effects
#   W_train <- W[train_idx, , drop = FALSE]
#   W_test  <- W[test_idx, , drop = FALSE]
#
#   list()
#
# }
#
# ## fit LMM + custom penalization  ------------------------------------ -
#
#
#
# ## compute genomic prediction accuracy  ------------------------------ -
#
#
# ## plot obs-predicted phenotypes ------------------------------------- -
#
#
#
#
#
#
#
#
#
