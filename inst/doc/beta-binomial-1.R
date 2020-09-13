## -----------------------------------------------------------------------------
## Load package
library(dalmatian)

## -----------------------------------------------------------------------------
## Load beta-binomial data
data(betabin_data_1)

## -----------------------------------------------------------------------------
## Define mean and variance objects
mymean <- list(fixed = list(name = "alpha",
                            formula = ~x1,
                            priors = list(c("dnorm",0,.001))),
               random = list(name = "epsilon",
                             formula = ~ID - 1),
               link = "logit")

mydisp <- list(fixed = list(name = "psi",
                            formula = ~x2,
                            priors = list(c("dnorm",0,.001))),
               random = list(name = "xi",
                             formula = ~ID - 1),
               link = "logit")

## ---- eval = FALSE------------------------------------------------------------
#  
#  ## Set working directory
#  ## By default uses a system temp directory. You probably want to change this.
#  workingDir <- tempdir()
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"betabin_test_1.R"),n.chains = 3, n.adapt = 1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=20)
#  
#  ## Run the model using dalmatian
#  bbmcmc <- dalmatian(df=betabin_data_1,
#                      family = "betabin",
#                      mean.model=mymean,
#                      dispersion.model=mydisp,
#                      jags.model.args=jm.args,
#                      coda.samples.args=cs.args,
#                      response = "y",
#                      ntrials = "m",
#                      residuals = FALSE,
#                      run.model = TRUE,
#                      engine = "JAGS",
#                      n.cores = 3,
#                      overwrite = TRUE,
#                      saveJAGSinput = workingDir)

## ---- echo = FALSE------------------------------------------------------------
load(system.file("bbresults.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  bbconvergence <- convergence(bbmcmc)

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
bbconvergence$gelman

## Raftery diagnostics
bbconvergence$raftery

## Effective sample size
bbconvergence$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  ## bbtraceplots <- traceplots(bbmcmc,show=FALSE)

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
bbtraceplots$meanFixed

## Fixed effects for dispersion
bbtraceplots$dispersionFixed

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  bbsummary <- summary(bbmcmc)
#  

## -----------------------------------------------------------------------------
## Print numerical summaries
bbsummary


## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  bbcaterpillar <- caterpillar(bbmcmc,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
bbcaterpillar$meanFixed

## Fixed effects for dispersion
bbcaterpillar$dispersionFixed

