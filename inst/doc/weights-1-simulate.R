## ---- echo = FALSE------------------------------------------------------------
## Setup
options(scipen=1, digits=2)

## -----------------------------------------------------------------------------
## Load library
library(dalmatian)

## Load simulated data
data(weights_data_1)
head(weights_data_1)

## -----------------------------------------------------------------------------
## Mean model
mymean=list(fixed=list(name="alpha",formula=~ x,
            priors=list(c("dnorm",0,.001))))

## Variance model
mydisp=list(fixed=list(name="psi",
                       formula=~ x,
                       priors=list(c("dnorm",0,.001))),
            link="log")

## Set working directory
## By default uses a system temp directory. You probably want to change this.
workingDir <- tempdir()

## Define list of arguments for jags.model()
jm.args = list(file=file.path(workingDir,"weights_1_jags.R"),n.adapt=1000)

## Define list of arguments for coda.samples()
cs.args = list(n.iter = 5000, n.thin = 20)

## Run the model using dalmatian
results1 <- dalmatian(
  df = weights_data_1,
  mean.model = mymean,
  dispersion.model = mydisp,
  jags.model.args = jm.args,
  coda.samples.args = cs.args,
  response = "y",
  overwrite = TRUE,
  debug = FALSE)

## Numerical summary statistics
summary1 <- summary(results1)
summary1

## Graphical summaries
caterpillar1 <- caterpillar(results1, show = TRUE)

## ----echo = FALSE-------------------------------------------------------------
## Extract results
mean1 <- summary1$dispFixed[1,"Mean"]
lower1 <- summary1$dispFixed[1,"Lower 95%"]
upper1 <- summary1$dispFixed[1,"Upper 95%"]

## -----------------------------------------------------------------------------
## Specify column containing weights
mydisp$weights = "n"

## Run model
jm.args = list(file=file.path(workingDir,"weights_2_jags.R"),n.adapt=1000)

results2 = dalmatian(df=weights_data_1,
                     mean.model=mymean,
                     dispersion.model=mydisp,
                     jags.model.args=jm.args,
                     coda.samples.args=cs.args,
                     response="y",
                     overwrite = TRUE,
                     debug=FALSE)

## Numerical summary statistics
summary2 <- summary(results2)
summary2

## Graphical summaries
caterpillar2 <- caterpillar(results2, show = TRUE)


## ----echo = FALSE-------------------------------------------------------------
## Extract results
mean2 <- summary2$dispFixed[1,"Mean"]
lower2 <- summary2$dispFixed[1,"Lower 95%"]
upper2 <- summary2$dispFixed[1,"Upper 95%"]

