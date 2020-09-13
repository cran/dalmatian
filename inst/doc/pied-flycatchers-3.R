## -----------------------------------------------------------------------------
## Load package
library(dalmatian)

## -----------------------------------------------------------------------------
## Load pied flycatcher data
data(pied_flycatchers_1)

## Create variables bounding the true load
pfdata$lower=ifelse(pfdata$load==0,log(.001),log(pfdata$load-.049))
pfdata$upper=log(pfdata$load+.05)

## -----------------------------------------------------------------------------
## Mean model
mymean <- list(fixed=list(name="alpha",
                          formula=~ log(IVI) + sex,
                          priors=list(c("dnorm",0,.001))))

## Dispersion model
mydisp=list(fixed=list(name="psi",
                       formula=~sex,
                       priors=list(c("dnorm",0,.001))),
            link="log")

## Joint components
myjoint <- list(fixed = list(name = "gamma",
                            formula = ~-1 + broodsize,
                            priors = list(c("dnorm",0,.001))))


## ---- eval = FALSE------------------------------------------------------------
#  
#  ## Set working directory
#  ## By default uses a system temp directory. You probably want to change this.
#  workingDir <- tempdir()
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"pied_flycatcher_joint_1_jags.R"),n.adapt=1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=20)
#  
#  ## Run the model using dalmatian
#  pfmcmc4 <- dalmatian(df=pfdata,
#                       mean.model=mymean,
#                       dispersion.model=mydisp,
#                       joint.model=myjoint,
#                       jags.model.args=jm.args,
#                       coda.samples.args=cs.args,
#                       rounding=TRUE,
#                       lower="lower",
#                       upper="upper",
#                       residuals = FALSE,
#                       debug=FALSE)

## ---- echo = FALSE------------------------------------------------------------
load(system.file("pfresults4.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  pfconvergence4 <- convergence(pfmcmc4)
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
pfconvergence4$gelman

## Raftery diagnostics
pfconvergence4$raftery

## Effective sample size
pfconvergence4$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  pftraceplots4 <- traceplots(pfmcmc4,show=FALSE,nthin=10)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pftraceplots4$meanFixed

## Fixed effects for dispersion
pftraceplots4$dispersionFixed


## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  pfsummary4 <- summary(pfmcmc4)

## -----------------------------------------------------------------------------
## Print numerical summaries
pfsummary4

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  pfcaterpillar4 <- caterpillar(pfmcmc4,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pfcaterpillar4$meanFixed

## Fixed effects for dispersion
pfcaterpillar4$dispersionFixed

