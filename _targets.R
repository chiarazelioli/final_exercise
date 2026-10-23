# Created by use_targets().
library(targets)
library(tarchetypes)
library(RSpectra)
library(Rfast)
library(glmnet)
library(tictoc)
library(mgcv)

# Set target options:
tar_option_set(packages = c("tibble", "mgcv-package", "tidyverse") )

tar_source() # tar_source("other_functions.R") # Source other scripts as needed.

list(
  # data file. we need format = "file"
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
             command = here("data/matrixXX.RData") ,# shortcut: tab (the arrow) and select
             format = "file"),
  tar_target(name = XX,
             command = load(XXfile)   ),

  # prepare matrix of PCs

  # simulate phenotypes

  # split train-test

  # fit model

  # compute genomic prediction accuracy

  # plot obs-predicted phenotypes


)
