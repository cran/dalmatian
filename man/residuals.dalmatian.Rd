% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/residuals.R
\name{residuals.dalmatian}
\alias{residuals.dalmatian}
\title{Residuals method for dalmatian fitted objects}
\usage{
\method{residuals}{dalmatian}(object, ...)
}
\arguments{
\item{object}{Object of class \code{dalmatian} created by \code{dalmatian()}.}

\item{...}{Ignored}
}
\value{
Data frame containing original data augmented with posterior
mean and lower and upper bounds of the 95% credible interval of the
residual for each observation.
}
\description{
Computes posterior summaries of the residuals for each observation.
Summary statistics include the posterior mean and the upper and
lower bounds of the 95% credible interval.
If the response is not rounded then the residuals can either be
sampled as part of the MCMC or computed during post-processing. If
computed as part of the MCMC then \code{residuals()} will simply
summarize the posterior distributions. Otherwise, \code{residuals()}
will compute the residuals and their posterior summaries. If the
response is rounded then the residuals must be sampled
when the MCMC sampler is run.
}
\examples{
\dontrun{
## Here we rerun the first example in
## \code{vignettes(pied-flycatcher-1)} with \code{residuals = TRUE}
## in order to sample the residuals and then use the \code{residuals()}
## function to summarize the posterior distributions. This is necessary
## because the output is too large to store inside the package.

## Load pied flycatcher data
data(pied_flycatchers_1)


## Create variables bounding the true load
pfdata$lower=ifelse(pfdata$load==0,log(.001),log(pfdata$load-.049))
pfdata$upper=log(pfdata$load+.05)

##### Model 1 #####

## Mean model
mymean=list(fixed=list(name="alpha",
       formula=~ log(IVI) + broodsize + sex,
       priors=list(c("dnorm",0,.001))))

## Dispersion model
mydisp=list(fixed=list(name="psi",
      link="log",
      formula=~broodsize + sex,
      priors=list(c("dnorm",0,.001))))


## Set working directory
workingDir <- tempdir()

## Define list of arguments for jags.model()
jm.args <- list(file=file.path(workingDir,"pied_flycatcher_1_jags.R"),n.adapt=1000)

## Define list of arguments for coda.samples()
cs.args <- list(n.iter=5000,thin=20)

## Run the model using dalmatian
pfresults <- dalmatian(df=pfdata,
                       mean.model=mymean,
                       dispersion.model=mydisp,
                       jags.model.args=jm.args,
                       coda.samples.args=cs.args,
                       rounding=TRUE,
                       lower="lower",
                       upper="upper",
                       n.cores = 3,
                       residuals = TRUE,
                       overwrite = TRUE,
                       debug=FALSE)
 
## summarize residuals
res.pfresults <- residuals(object = pfresults)
}
}
\author{
Simon Bonner
}
