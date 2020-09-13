## -----------------------------------------------------------------------------
## Load package
library(dalmatian)

## -----------------------------------------------------------------------------
## Load gamma data
data(gamma_data_1)

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
#  jm.args <- list(file=file.path(workingDir,"gamma_test_1.R"),n.chains = 3, n.adapt = 1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=20)
#  
#  ## Run the model using dalmatian
#  gmcmc <- dalmatian(df=gamma_data_1,
#                     family = "gamma",
#                     mean.model=mymean,
#                     dispersion.model=mydisp,
#                     jags.model.args=jm.args,
#                     coda.samples.args=cs.args,
#                     response = "y",
#                     residuals = FALSE,
#                     run.model = TRUE,
#                     engine = "JAGS",
#                     n.cores = 3,
#                     overwrite = TRUE,
#                     saveJAGSinput = workingDir)

## ---- echo = FALSE------------------------------------------------------------
load(system.file("gresults.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  gconvergence <- convergence(gmcmc)
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
gconvergence$gelman

## Raftery diagnostics
gconvergence$raftery

## Effective sample size
gconvergence$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  ## gtraceplots <- traceplots(gmcmc,show=FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
gtraceplots$meanFixed

## Fixed effects for dispersion
gtraceplots$dispersionFixed

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  gsummary <- summary(gmcmc)

## -----------------------------------------------------------------------------
## Print numerical summaries
gsummary

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  gcaterpillar <- caterpillar(gmcmc,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
gcaterpillar$meanFixed

## Fixed effects for dispersion
gcaterpillar$dispersionFixed

