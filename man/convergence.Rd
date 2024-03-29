% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/post_processing.R
\name{convergence}
\alias{convergence}
\title{Convergence Diagnostics (S3 Generic)}
\usage{
convergence(object, ...)
}
\arguments{
\item{object}{Object to asses.}

\item{...}{Ignored}
}
\value{
List containing Gelman-Rubin and Raftery convergence diagnostics and effective sample sizes for the selected parameters. This information is used to diagnose convergence of the MCMC sampling algorithms.
}
\description{
Generic function for computing convergence diagnostics.
}
\references{
Bonner, S., Kim, H., Westneat, D., Mutzel, A.,
Wright, J., and Schofield, M.. (2021). \code{dalmatian}: A Package
for Fitting Double Hierarchical Linear Models in \code{R} via \code{JAGS} and
\code{nimble}. \emph{Journal of Statistical Software}, 100, 10, 1--25.
\doi{10.18637/jss.v100.i10}.
}
