#' Tell if a certain field is contained.
#'
#' This function tells if an object returned from \code{libgen_retrieve_ID()}, \code{libgen_search()} or \code{libgen_new_uploads()} contains a certain field.
#' @name has_field
#' @param field the field to look for.
#' @param data a data frame object.
#' @return a logical value.
#' @examples
#' has_field('Title',libgen_ID_retrieve(c(1,2,3)))
#'
#' @export

has_field <- function(field, data) {
  name <- names(data)
  field <- tolower(field)
  return(field %in% name)
}
