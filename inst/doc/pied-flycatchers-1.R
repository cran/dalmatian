## -----------------------------------------------------------------------------
## Load package
library(dalmatian)

## -----------------------------------------------------------------------------
## Load pied flycatcher data
data(pied_flycatchers_1)

## -----------------------------------------------------------------------------
## Create variables bounding the true load
pfdata$lower=ifelse(pfdata$load==0,log(.001),log(pfdata$load-.049))
pfdata$upper=log(pfdata$load+.05)

## -----------------------------------------------------------------------------
## Mean model
mymean <- list(fixed=list(name="alpha",
                          formula=~ log(IVI) + broodsize + sex,
                          priors=list(c("dnorm",0,.001))))

## Dispersion model
mydisp <- list(fixed=list(name="psi",
                          formula=~broodsize + sex,
                          priors=list(c("dnorm",0,.001))),
               link="log")

## ---- eval = FALSE------------------------------------------------------------
#  ## Set working directory
#  ## By default uses a system temp directory. You probably want to change this.
#  workingDir <- tempdir()
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"pied_flycatcher_1_jags.R"),n.adapt=1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=20)
#  
#  ## Run the model using dalmatian
#  pfmcmc1 <- dalmatian(df=pfdata,
#                       mean.model=mymean,
#                       dispersion.model=mydisp,
#                       jags.model.args=jm.args,
#                       coda.samples.args=cs.args,
#                       rounding=TRUE,
#                       lower="lower",
#                       upper="upper",
#                       residuals = FALSE,
#                       debug=FALSE)
#  }

## ---- echo = FALSE------------------------------------------------------------
load(system.file("pfresults1.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  pfconvergence1 <- convergence(pfmcmc)
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
pfconvergence1$gelman

## Raftery diagnostics
pfconvergence1$raftery

## Effective sample size
pfconvergence1$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  pfraceplots1 <- traceplots(pfmcmc1,show=FALSE,nthin=20)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pftraceplots1$meanFixed

## Fixed effects for dispersion
pftraceplots1$dispersionFixed


## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  pfsummary1 <- summary(pfmcmc1)
#  

## -----------------------------------------------------------------------------
## Print numerical summaries
pfsummary1

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  pfcaterpillar1 <- caterpillar(pfmcmc1,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pfcaterpillar1$meanFixed

## Fixed effects for dispersion
pfcaterpillar1$dispersionFixed

## -----------------------------------------------------------------------------
# Random component of mean
mymean$random <- list(name="epsilon",formula=~-1 + indidx)

# Random component of dispersion
mydisp$random <- list(name="xi",formula=~-1 + indidx)

## ---- eval = FALSE------------------------------------------------------------
#  ## Define initial values
#  inits <- lapply(1:3,function(i){
#                  setJAGSInits(mymean,
#                        mydisp,
#                        y = runif(nrow(pfdata),pfdata$lower,pfdata$upper),
#                        fixed.mean = tail(pfmcmc1$coda[[i]],1)[1:4],
#                        fixed.dispersion = tail(pfmcmc1$coda[[i]],1)[5:7],
#                        sd.mean = 1,
#                        sd.dispersion=1)
#    })
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"pied_flycatcher_2_jags.R"),inits=inits,n.adapt=1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=5000,thin=10)
#  
#  ## Run the model using dalmatian
#  pfmcmc2 <- dalmatian(df=pfdata,
#                       mean.model=mymean,
#                       dispersion.model=mydisp,
#                       jags.model.args=jm.args,
#                       coda.samples.args=cs.args,
#                       rounding=TRUE,
#                       lower="lower",
#                       upper="upper",
#                       residuals=FALSE,
#                       debug=FALSE)

## ---- echo = FALSE------------------------------------------------------------
  load(system.file("pfresults2.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  pfconvergence2 <- convergence(pfmcmc2)
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
pfconvergence2$gelman

## Raftery diagnostics
pfconvergence2$raftery

## Effective sample size
pfconvergence2$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  pftraceplots2 <- traceplots(pfmcmc2, show = FALSE, nthin=20)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pftraceplots2$meanFixed

## Fixed effects for dispersion
pftraceplots2$dispersionFixed

## Random effects variances for mean
pftraceplots2$meanRandom

## Random effects variances for dispersion
pftraceplots2$dispersionRandom

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  pfsummary2 <- summary(pfmcmc2)
#  

## -----------------------------------------------------------------------------
## Print numerical summaries
pfsummary2

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  pfcaterpillar2 <- caterpillar(pfmcmc2,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pfcaterpillar2$meanFixed

## Fixed effects for dispersion
pfcaterpillar2$dispersionFixed

## -----------------------------------------------------------------------------
## Add 'log(IVI)' variable in pfdata
pfdata$'log(IVI)' <- log(pfdata$IVI)

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute predictions for model 1
#  pffitted1 <- predict(pfmcmc,
#                       newdata = pfdata[1:5,])
#  

## -----------------------------------------------------------------------------
pffitted1$mean
pffitted1$dispersion


## ---- eval = FALSE------------------------------------------------------------
#  ## Compute predictions for model 2
#  pffitted2 <- predict(pfmcmc2,
#                       newdata = pfdata[1:5,]))
#  

## -----------------------------------------------------------------------------
pffitted2$mean
pffitted2$dispersion

