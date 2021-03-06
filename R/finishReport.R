#' @title Creates the main Report with childs
#'
#' @description
#' The function writes the MainReport rmd file and write the child rmd files and
#' organize them together in one report
#'
#' @param ...
#'   Report objects
#' @param sub.dir [\code{path}]\cr
#'   The path where the child rmd files will be created
#' @param save.mode [\code{logical(1)}]\cr
#'   In Save mode its not possible to use an existing folder.
#'   To ensure no data is lost, a new folder will be created (if possible).
#' @param theme [\code{character()}]\cr
#'   This param is the theme of the YAML-header. If set to NULL no theme will
#'   be used
#' @param df.print [\code{character()}]\cr
#'   This param sets the YAML header for how Dataframed should be printed.
#'   If set to NULL df.print param will not be used.
#' @param override [\code{logical(1)}]\cr
#'   override controls if the function is allowed to override
#'   an existing rmd-file
#' @return creates rmd Files, returns NULL
#'
#' @examples
#'
#' data("airquality")
#' basic.report.task = makeBasicReportTask(id = "AirqualityTask", data = airquality, target = "Wind")
#' basic.report = makeReport(basic.report.task)
#'
#' data("Boston", package = "MASS")
#' num.sum.task = makeNumSumTask(id = "BostonTask", data = Boston, target = NULL)
#' num.sum.result = makeNumSum(num.sum.task)
#' num.sum.report = makeReport(num.sum.result)
#'
#' corr.task = makeCorrTask(id = "test", data = cars)
#' corr.result = makeCorr(corr.task)
#' corr.report = makeReport(corr.result)
#
#' data(diamonds, package = "ggplot2")
#' corr.task2 = makeCorrTask(id = "test2", data = diamonds)
#' corr.result2 = makeCorr(corr.task2)
#' corr.report2 = makeReport(corr.result2)
#'
#' data("Arthritis", package = "vcd")
#' cat.sum.task = makeCatSumTask(id = "Arthritis.Task", data = Arthritis,
#'   target = "Improved", na.rm = TRUE)
#' cat.sum.result = makeCatSum(cat.sum.task)
#' cat.sum.report = makeReport(cat.sum.result)
#'
#' #combine all reports
#' finishReport(basic.report, num.sum.report, corr.report, corr.report2,
#'   cat.sum.report, save.mode = FALSE, override = TRUE)
#'
#' @import checkmate
#' @import BBmisc
#' @export
finishReport = function(..., sub.dir = "Data_Report", save.mode = TRUE,
  theme = "cosmo", df.print = "paged", override = FALSE){
  x = list(...)
  assertList(x, types = c("CorrReport", "NumSumReport", "BasicReport", "CatSumReport",
    "ClusterAnalysisReport", "MDSAnalysisReport", "FAReport", "PCAReport"))
  assertLogical(save.mode)
  assert_path_for_output(sub.dir, overwrite = !save.mode)

  n = length(x)
  child.names = vector(mode = "character", length = n)
  # Genrate Reports
  for (i in seq.int(n)) {
    ### writeReport is the S3 Method which should pick the correct write function for each object
    child.names[i] = writeReport(x[[i]], sub.dir, save.mode = FALSE, override = override)
  }
  # Organize Childs
  report.con = file("MainReport.rmd", "w", encoding = rmdEncoding())
  writeHeader("AEDA Report", report.con, theme = theme, df.print = df.print)

  #Write Abstract
  writeLines("## Abstract\n", con = report.con)
  writeLines("This exploratory data analysis report was created by the R package
<a href='https://github.com/ptl93/AEDA' target='_blank'>AEDA</a>.\n", con = report.con)

  # for now load AEDA in mainReport
  writeLines("```{r, echo=FALSE, warning=FALSE, message=FALSE}", con = report.con)
  writeLines("try(library(AEDA))", con = report.con)
  writeLines("try(devtools::load_all())", con = report.con)
  writeLines("```", con = report.con)

  for (i in seq.int(n)) {
    section.name = paste0(getType(x[[i]]), "_", getId(x[[i]]))
    catf("```{r %s, child = \"%s\"}", section.name, child.names[i], file = report.con)
    writeLines("```", con = report.con)
    writeLines("", con = report.con)
  }
  close(report.con)
}
