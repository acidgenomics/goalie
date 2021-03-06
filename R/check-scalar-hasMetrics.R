#' Does the object contain quality control metrics?
#'
#' @name check-scalar-hasMetrics
#' @note Updated 2021-01-04.
#'
#' @inherit check
#' @inheritParams AcidRoxygen::params
#' @param x `SummarizedExperiment`.
#' @param colData `character`.
#'   Column names in [`colData()`][SummarizedExperiment::colData] containing
#'   expected quality control metrics.
#'
#' @examples
#' if (requireNamespace("SummarizedExperiment", quietly = TRUE)) {
#'     data(RangedSummarizedExperiment, package = "AcidTest")
#'     x <- RangedSummarizedExperiment
#'     hasMetrics(x)
#' }
NULL



#' @rdname check-scalar-hasMetrics
#' @export
hasMetrics <-
    function(
        x,
        colData = c("nCount", "nFeature"),
        .xname = getNameInParent(x)
    ) {
        assert(
            requireNamespace("SummarizedExperiment", quietly = TRUE),
            is(x, "SummarizedExperiment"),
            isCharacter(colData)
        )
        c1 <- colData
        c2 <- colnames(SummarizedExperiment::colData(x))
        ok <- isSubset(c1, c2)
        if (!isTRUE(ok)) {
            return(false(
                "'%s' does not contain metrics in 'colData()': %s.",
                .xname,
                toString(setdiff(c1, c2), width = 100L)
            ))
        }
        TRUE
    }
