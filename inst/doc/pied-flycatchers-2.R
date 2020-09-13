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
# Random component of mean
mymean=list(fixed=list(name="alpha",
                       formula=~ log(IVI) + broodsize + sex,
                       priors=list(c("dnorm",0,.001))),
            random=list(name="epsilon",
                        formula=~-1 + indidx + indidx:log(IVI)))


# Random component of dispersion
mydisp=list(fixed=list(name="psi",
                       formula=~1,
                       priors=list(c("dnorm",0,.001))),
            link="log")

## ---- eval = FALSE------------------------------------------------------------
#  ## Set working directory
#  ## By default uses a system temp directory. You probably want to change this.
#  workingDir <- tempdir()
#  
#  ## Define list of arguments for jags.model()
#  jm.args <- list(file=file.path(workingDir,"pied_flycatcher_3_jags.R"),n.adapt=1000)
#  
#  ## Define list of arguments for coda.samples()
#  cs.args <- list(n.iter=1000)
#  
#  ## Run the model using dalmatian
#  pfmcmc3 <- dalmatian(df=pfdata,
#                       mean.model=mymean,
#                       dispersion.model=mydisp,
#                       jags.model.args=jm.args,
#                       coda.samples.args=cs.args,
#                       rounding=TRUE,
#                       lower="lower",
#                       upper="upper",
#                       debug=FALSE)

## ---- echo = FALSE------------------------------------------------------------
## Load output from previously run chain
load(system.file("pfresults3.RData",package="dalmatian"))

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute convergence diagnostics
#  pfconvergence3 <- convergence(pfmcmc3,raftery=list(r=.01))
#  

## -----------------------------------------------------------------------------
## Gelman-Rubin diagnostics
pfconvergence3$gelman

## Raftery diagnostics
pfconvergence3$raftery

## Effective sample size
pfconvergence3$effectiveSize

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate traceplots
#  pftraceplots3 <- traceplots(pfmcmc3, nthin = 20, show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pftraceplots3$meanFixed

## Fixed effects for dispersion
pftraceplots3$dispersionFixed

## Random effects variances for mean
pftraceplots3$meanRandom

## Random effects variances for dispersion
pftraceplots3$dispersionRandom


## ---- eval = FALSE------------------------------------------------------------
#  ## Compute numerical summaries
#  pfsummary3 <- summary(pfmcmc3)
#  

## -----------------------------------------------------------------------------
## Print numerical summaries
pfsummary3

## ---- eval = FALSE------------------------------------------------------------
#  ## Generate caterpillar
#  pfcaterpillar3 <- caterpillar(pfmcmc3,show = FALSE)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Fixed effects for mean
pfcaterpillar3$meanFixed

## Fixed effects for dispersion
pfcaterpillar3$dispersionFixed

## ---- eval = FALSE------------------------------------------------------------
#  ## Compute summary statistics for random effects
#  pfranef3 <- ranef(pfresults3)
#  

## ----fig.width=6,fig.align="center"-------------------------------------------
## Load ggplot2
library(ggplot2)

## Identify number of individuals
nind <- nlevels(pfdata$indidx)

## Plot predicted random slopes
ggplot(data=as.data.frame(pfranef3$mean[nind+(1:nind),]),aes(x=1:nind,y=Mean)) + 
  geom_point() + 
  geom_errorbar(aes(ymin=`Lower 95%`,ymax=`Upper 95%`)) +
  geom_abline(intercept=0,slope=0)

