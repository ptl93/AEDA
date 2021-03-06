% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/S3_makeClusterAnalysisReport.R
\name{makeReport.ClusterAnalysisObj}
\alias{makeReport.ClusterAnalysisObj}
\title{Creates an Cluster Analysis Report object}
\usage{
\method{makeReport}{ClusterAnalysisObj}(analysis.obj)
}
\arguments{
\item{analysis.obj}{[\code{ClusterAnalysisObj} Object]\cr
A object of the "ClusterAnalysisObj" class}
}
\value{
A ClusterAnalysisReport Object
}
\description{
Creates an Cluster Analysis Report object
}
\examples{
\dontrun{
 cluster.task = makeClusterTask(id = "iris", data = iris,
  method = "cluster.kmeans")
 cluster.analysis.result = makeClusterAnalysis(cluster.task)
 cluster.analysis.report = makeReport(cluster.analysis.result)
}
}
