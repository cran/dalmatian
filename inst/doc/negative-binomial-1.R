## -----------------------------------------------------------------------------
## Load package
library(dalmatian)

## -----------------------------------------------------------------------------
## Load negative binomial data
data(nbinom_data_1)

## -----------------------------------------------------------------------------
## Define mean and variance objects
mymean <- list(fixed = list(name = "alpha",
                            formula = ~x1,
                            priors = list(c("dnorm",0,.001))),
               random = list(name = "epsilon",
                             formula = ~ID - 1),
               link = "log")

mydisp <- list(fixed = list(name = "psi",
                            formula = ~x2,
                            priors = list(c("dnorm",0,.001))),
               random = list(name = "xi",
                             formula = ~ID - 1),
               link = "log")

## ---- eval = FALSE------------------------------------------------------------
#  
#  ## Set working directory
#  ## By default uses a system temp directory. You probably want to change this.
#  workingDir <- tempdir()
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"nbinom_test_1.R"),n.chains = 3, n.adapt = 1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=20)
#  
#  ## Run the model using dalmatian
#  nbmcmc <- dalmatian(df=nbinom_data_1,
#                      family = "nbinom",
#                      mean.model=mymean,
#                      dispersion.model=mydisp,
#                      jags.model.args=jm.args,
#                      coda.samples.args=cs.args,
#                      response = "y",
#                      residuals = FALSE,
#                      run.model = TRUE,
#                      engine = "JAGS",
#                      n.cores = 3,
#                      overwrite = TRUE,
#                      saveJAGSinput = workingDir)

## ---- echo = FALSE------------------------------------------------------------
load(system.file("nbresults.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  ## nbconvergence <- convergence(nbmcmc)
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
nbconvergence$gelman

## Raftery diagnostics
nbconvergence$raftery

## Effective sample size
nbconvergence$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  nbtraceplots <- traceplots(nbmcmc,show=FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
nbtraceplots$meanFixed

## Fixed effects for dispersion
nbtraceplots$dispersionFixed

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  nbsummary <- summary(nbmcmc)
#  

## -----------------------------------------------------------------------------
## Print numerical summaries
nbsummary

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  nbcaterpillar <- caterpillar(nbmcmc,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
nbcaterpillar$meanFixed

## Fixed effects for dispersion
nbcaterpillar$dispersionFixed

