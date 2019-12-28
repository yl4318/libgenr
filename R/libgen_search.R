#'  Search the Library Genesis API by text
#'
#'  Search the Library Genesis API by text and return results of specified counts and sorted on specified fields.
#'
#' @param query the string to search for.
#' @param full_fields whether returns with full fields (\code{TRUE}) or selected fields (\code{FALSE}).
#' @param count the number of results to return, defaults to 25. If the results length is less than \code{count}, will return the whole results.
#' @param fields Optional, user specified vector of fields to return.
#' @param search_in restrict your search to one of the following fields:
#'    \itemize{
#'   \item title
#'   \item author
#'   \item series
#'   \item periodical
#'   \item publisher
#'   \item year
#'   \item identifier
#'   \item md5
#'   \item extension
#'   \item def (default:Title, Author, Series, Periodical, Publisher, Year, VolumeInfo)
#'  }
#'
#' @param sort_by The field by which results are sorted:
#'  \itemize{
#'   \item title
#'   \item author
#'   \item publisher
#'   \item year
#'   \item pages
#'   \item language
#'   \item extension
#'   \item filesize
#'   \item extension
#'   \item def (default: Relevance)
#'  }
#'
#' @param reverse Only if sort_by field is specified. Default to \code{FALSE}, if \code{TRUE}, sorts Z-A or 9-0.
#' Notice: if results are sorted by a field and \code{reverse} set to \code{FALSE}, items with no record on that field will come first.
#' @name libgen_search
#' @return A data frame.
#' @examples
#' libgen_search('statistical learning')
#' libgen_search('statistical learning',count=150,search_in='title')
#' libgen_search('statistical learning',sort_by='year',reverse=TRUE)
#' @export

libgen_search <- function(query, count = 25, search_in = "def", sort_by = "def",
                          reverse = FALSE, full_fields = FALSE,fields=c()) {
  url <- "http://gen.lib.rus.ec/search.php?"
  query<-utils::URLencode(query)
  request <- paste(url, "req=", query, "&column=", tolower(search_in), "&sort=",
                   tolower(sort_by), "&sortmode=", ifelse(reverse == FALSE, "ACS", "DESC"),
                   sep = "")
  IDs <- fetch_id(request, count)
  return(libgen_ID_retrieve(IDs, full_fields = full_fields,fields=fields))
}

fetch_id <- function(request, count) {
  xpath <- "//table[3]/tr/td[1]"
  if (count <= 100) {
    contents <- xml2::read_html(paste(request, ifelse(count <= 25, "&res=25",
                                               ifelse(count <= 50, "&res=50", "&res=100")), sep = ""))
    IDs <- rvest::html_text(rvest::html_nodes(contents, xpath = xpath))[-1]
  } else {
    pagen <- count%%100
    IDs <- c()
    for (i in 1:pagen) {
      contents <- xml2::read_html(paste(request, "&res=100&page=", i, sep = ""))
      IDs <- append(IDs, rvest::html_text(rvest::html_nodes(contents, xpath = xpath))[-1])
    }
  }
  count <- ifelse(count > length(IDs), length(IDs), count)
  IDs[1:count]
}
