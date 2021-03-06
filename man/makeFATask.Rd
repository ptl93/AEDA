% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/makeFATask.R
\name{makeFATask}
\alias{makeFATask}
\title{Creates a Factor Analysis Task Object for numeric data}
\usage{
makeFATask(id, data, nfactors = NULL, rotate = "oblimin",
  par.vals = list(), par.vals.parallel = list(plot = FALSE),
  show.NA.msg = FALSE)
}
\arguments{
\item{id}{[\code{character(1)}]\cr
ID of the Task Object}

\item{data}{[\code{data.frame}]\cr
A Dataframe with different variables}

\item{nfactors}{[\code{integer(1)}]\cr
Number of factors to extract. If nothing is inserted the optimal \cr
number of factors will be calculated according to parallel analysis.\cr
For more information @seealso \code{\link[psych]{fa.parallel}}.\cr
Default is \code{nfactors = NULL}}

\item{rotate}{[\code{character(1)}]\cr
Defines the rotation method. Possible values are: \cr
"none", "varimax", "quartimax", "bentlerT", "equamax", \cr
"varimin", "geominT" and "bifactor",\cr
"Promax", "promax", "oblimin", "simplimax",\cr
"bentlerQ, "geominQ","biquartimin" and "cluster".\cr
Default is \code{rotate = "oblimin"}.
For more information @seealso \code{\link[psych]{fa}}}

\item{par.vals}{[\code{list}]\cr
Additional arguments handled over to @seealso \code{\link[psych]{fa}}.\cr
Default is empty list \code{par.vals = list()}}

\item{par.vals.parallel}{[\code{list}]\cr
Additional arguments handed over to @seealso \code{\link[psych]{fa.parallel}}.\cr
Default is \code{par.vals.parallel = list(plot = FALSE)}}

\item{show.NA.msg}{[\code{logical(1)}]\cr
Logical whether to show missing values message\cr
Default is \code{show.NA.msg = FALSE)}}
}
\value{
FATask Object
}
\description{
A Task encapsulates the Data with some additional information.\cr
}
\examples{
 library(psych)
 data(bfi)
 #take small sample of size 200L:
 bfi_small = bfi[sample(seq_len(nrow(bfi)), size = 200L), ]
 FA.task = makeFATask(id = "bfi", data = bfi_small)
}
