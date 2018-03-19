#' Creates an Categorical Summary Report object
#'
#' @param cat.sum.obj [\code{CatSumObj} Object]\cr
#'   A object of the "CatSumObj" class
#' @return CatSumReport
#' @import checkmate
#' @import BBmisc
#' @examples
#'  data("Arthritis", package = "vcd")
#'  cat.sum.task = makeCatSumTask(id = "Arthritis.Task", data = Arthritis, target = "Improved")
#'  cat.sum = makeCatSum(cat.sum.task)
#'  #create the numeric summary report
#'  cat.sum.report = makeReport(cat.sum)
#' @export
makeReport.CatSumObj = function(cat.sum.obj){
  assertClass(cat.sum.obj, "CatSumObj")
  #assertCharacter(type, min.chars = 1)

  report.id = reportId()

  makeS3Obj("CatSumReport",
    cat.sum.task = cat.sum.obj$task,
    cat.sum = cat.sum$cat.sum,
    report.id = report.id,
    type = "CategoricalReport")
}

print.CatSumReport = function(x, ...) {
  print(x$cat.sum.task)
}