# Created by use_targets().
library(targets)
library(tarchetypes)
library(RSpectra)
library(Rfast)
library(glmnet)
library(tictoc)
library(mgcv)
library(here)

# Set target options:
tar_option_set(packages = c("tibble", "tidyverse") )

tar_source() # tar_source("other_functions.R") # Source other scripts as needed.

## Pipeline
list(
  # data file
  tar_target(name = SNPfile,
             command = here("data/SNP_100k.rds") ,# shortcut: tab (the arrow) and select
             format = "file"),
  # read data
  tar_target(name = SNP,
             command = readRDS(file=SNPfile)  ),
  # scale data
  tar_target(name = SNP_scaled,
             command = scale(SNP,center=TRUE,scale=FALSE)  ),

  # load matrix of PCs: XX = SNP_scaled %*% tmp.rspectra$v
  tar_target(name = XXfile,
             command = here("data/matrixXX.rds") ,
             format = "file"),

  tar_target(name = XX,
             command = readRDS(XXfile)              ),

  tar_target(name = prnt,
             command = print(dim(XX) ) ),

  # process the matrix of PCs
  tar_target(name = XX_processed, # list containing XX_red, tot_PCvar
             command = prepare_PCs(XX, n_PCs)   ),

  # simulate phenotypes

  # returns a list with sim phenotypes yy,
  # fixed effects bb, breeding values aa, enviro effects dd, residuals ee
  tar_target(name = sim_data,
             command = simulate_pheno(pi, sigma, SNP) )


  # # split train-test
  # tar_target(name = ),
  #
  # # fit model
  # tar_target(name = mod,
  #   command = fitLMM() ),
  #

)

  # compute genomic prediction accuracy

  # plot obs-predicted phenotypes



