#' Clean results by fields.
#'
#' Removes all records in a libgenr object that don't have specified field(s) or field(s) values.
#' @name clean_field
#' @param data a data frame object.
#' @param ... arguments specifying fields with or without values, in the format of \code{'field'} or \code{'field'='value'}. Separate multiple arguments with comma.
#' @return cleaned data frame or \code{FALSE} if error occurs or cleaned result has 0 row.
#' @examples
#' clean_field(data=libgen_search('statistics'),'year'='2006','author')
#' clean_field(data=libgen_new_uploads(timefirst=Sys.Date()),'language'='English')
#'
#' @export
clean_field <- function(data, ...) {
  result <- data
  f <- list(...)
  for (i in 1:length(f)) {
    if (is.null(names(f[i]))) {
      if (has_field(f[[i]], result)) {
        mask <- result[, f[[i]]] != ""
        result <- result[mask, ]
      } else {
        print("Fields not found in data.")
        return(FALSE)
      }
    } else if (names(f[i]) == "") {
      if (has_field(f[[i]], result)) {
        mask <- result[, f[[i]]] != ""
        result <- result[mask, ]
      } else {
        print("Fields not found in data.")
        return(FALSE)
      }
    } else {
      if (has_field(names(f[i]), result)) {
        mask <- result[, names(f[i])] == f[[i]]
        result <- result[mask, ]
      } else {
        print("Fields not found in data.")
        return(FALSE)
      }
    }
  }
  if (nrow(result) > 0) {
    return(result)
  } else {
    print("No records to show.")
    return(FALSE)
  }

}
