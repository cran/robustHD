% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.R
\name{critPlot}
\alias{critPlot}
\alias{critPlot.rlars}
\alias{critPlot.grplars}
\alias{critPlot.tslarsP}
\alias{critPlot.seqModel}
\alias{critPlot.tslars}
\alias{critPlot.sparseLTS}
\alias{critPlot.perrySeqModel}
\alias{critPlot.perrySparseLTS}
\alias{critPlot.setupCritPlot}
\title{Optimality criterion plot of a sequence of regression models}
\usage{
critPlot(object, ...)

\method{critPlot}{seqModel}(object, which = c("line", "dot"), ...)

\method{critPlot}{tslars}(object, p, which = c("line", "dot"), ...)

\method{critPlot}{sparseLTS}(
  object,
  which = c("line", "dot"),
  fit = c("reweighted", "raw", "both"),
  ...
)

\method{critPlot}{perrySeqModel}(object, which = c("line", "dot", "box", "density"), ...)

\method{critPlot}{perrySparseLTS}(
  object,
  which = c("line", "dot", "box", "density"),
  fit = c("reweighted", "raw", "both"),
  ...
)

\method{critPlot}{setupCritPlot}(object, ...)
}
\arguments{
\item{object}{the model fit to be plotted, , or an object containing
all necessary information for plotting (as generated by
\code{\link{setupCritPlot}}).}

\item{\dots}{additional arguments to be passed down, eventually to
\code{\link[ggplot2]{geom_line}}, \code{\link[ggplot2]{geom_pointrange}},
\code{\link[ggplot2]{geom_boxplot}}, or \code{\link[ggplot2]{geom_density}}.}

\item{which}{a character string specifying the type of plot.  Possible
values are \code{"line"} (the default) to plot the (average) results for
each model as a connected line, \code{"dot"} to create a dot plot,
\code{"box"} to create a box plot, or \code{"density"} to create a smooth
density plot.  Note that the last two plots are only available in case of
prediction error estimation via repeated resampling.}

\item{p}{an integer giving the lag length for which to produce the plot
(the default is to use the optimal lag length).}

\item{fit}{a character string specifying for which estimator to produce the
plot.  Possible values are \code{"reweighted"} (the default) for the
reweighted fits, \code{"raw"} for the raw fits, or \code{"both"} for both
estimators.}
}
\value{
An object of class \code{"ggplot"} (see \code{\link[ggplot2]{ggplot}}).
}
\description{
Produce a plot of the values of the optimality criterion for a sequence of
regression models, such as submodels along a robust or groupwise least angle
regression sequence, or sparse least trimmed squares regression models for
a grid of values for the penalty parameter.
}
\note{
Function \code{\link[perry]{perryPlot}} is used to create the plot,
even if the optimality criterion does not correspond to resampling-based p
rediction error estimation.  While this can be seen as as a misuse of its
functionality, it ensures that all optimality criteria are displayed in the
same way.
}
\examples{
## generate data
# example is not high-dimensional to keep computation time low
library("mvtnorm")
set.seed(1234)  # for reproducibility
n <- 100  # number of observations
p <- 25   # number of variables
beta <- rep.int(c(1, 0), c(5, p-5))  # coefficients
sigma <- 0.5      # controls signal-to-noise ratio
epsilon <- 0.1    # contamination level
Sigma <- 0.5^t(sapply(1:p, function(i, j) abs(i-j), 1:p))
x <- rmvnorm(n, sigma=Sigma)    # predictor matrix
e <- rnorm(n)                   # error terms
i <- 1:ceiling(epsilon*n)       # observations to be contaminated
e[i] <- e[i] + 5                # vertical outliers
y <- c(x \%*\% beta + sigma * e)  # response
x[i,] <- x[i,] + 5              # bad leverage points


## robust LARS
# fit model
fitRlars <- rlars(x, y, sMax = 10)
# create plot
critPlot(fitRlars)


## sparse LTS over a grid of values for lambda
# fit model
frac <- seq(0.2, 0.05, by = -0.05)
fitSparseLTS <- sparseLTS(x, y, lambda = frac, mode = "fraction")
# create plot
critPlot(fitSparseLTS)
critPlot(fitSparseLTS, fit = "both")
}
\seealso{
\code{\link[ggplot2]{ggplot}}, \code{\link[perry]{perryPlot}},
\code{\link{rlars}}, \code{\link{grplars}}, \code{\link{rgrplars}},
\code{\link{tslarsP}}, \code{\link{rtslarsP}}, \code{\link{tslars}},
\code{\link{rtslars}}, \code{\link{sparseLTS}}
}
\author{
Andreas Alfons
}
\keyword{hplot}
