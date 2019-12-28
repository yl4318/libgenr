#' Get the latest uploads of Library Genesis.
#'
#' This function gets the latest uploads of Library Genesis in specified time period.
#' @name libgen_new_uploads
#' @param timefirst the beginning time of query, in the format  of 'YYYY-MM-DD'.
#' @param timelast the ending time of query, in the format of 'YYYY-MM-DD', defaults to current day.
#' @param mode \code{last} to return last uploaded results, \code{modified} to return last modified results. Defaults to \code{last}.
#' @param count number of items to return, defaults to 1000.
#' @param first the first row to return, defaults to 1.
#' @param only_id whether returns only id fields so that results can be passed to get_by_ID function. Defaults to \code{FALSE}.
#' @param fields Optional, user specified vector of fields to return.
#' @param full_fields whether returns with full fields (\code{TRUE}) or selected fields (\code{FALSE}).
#' @return A data frame with results or a vector of character if \code{only_id==TRUE}.
#' @examples
#' libgen_new_uploads(Sys.Date(),count=100)
#' libgen_new_uploads('2019-12-01','2019-12-08',count=100,first=100,mode='modified')
#' libgen_new_uploads('2019-01-01','2019-12-08',count=1000,only_id=TRUE,mode='last')
#' @export
#'

libgen_new_uploads <- function(timefirst, timelast = Sys.Date(), mode = "last",
                               only_id = FALSE, full_fields = FALSE,fields=c(),count = 1000, first = 1) {
  ua <- httr::user_agent("https://github.com/yl4318")
  endpoint <- "http://gen.lib.rus.ec/json.php?"
  full_fields <- "ID,Title,VolumeInfo,Series,Periodical,Author,Year,Edition,Publisher,City,Pages,Language,Topic,Library,Issue,Identifier,ISSN,ASIN,UDC,LBC,DDC,LCC,Doi,Googlebookid,OpenLibraryID,Commentary,DPI,Color,Cleaned,Orientation,Paginated,Scanned,Bookmarked,Searchable,Filesize,Extension,MD5,CRC32,eDonkey,AICH,SHA1,TTH,Generic,Visible,Locator,Local,TimeAdded,TimeLastModified,Coverurl,identifierwodash,tags,pagesinfile,descr,toc,tth,sha1,aich,btih,torrent,crc32"
  partial_fields <- "ID,Title,VolumeInfo,Series,Periodical,Author,Year,Edition,Publisher,Pages,Language,Topic,Library,Issue,Identifier,ISSN,Filesize,Extension,MD5,CRC32,Locator,TimeAdded,TimeLastModified,torrent"
  limit2 <- -1
  if (first > 1) {
    limit1 <- first
    limit2 <- count
  } else limit1 <- count
  if (only_id == TRUE)
    qfields <- "ID" else if (full_fields == TRUE)
  qfields <- full_fields else if (length(fields) > 0)
    qfields <- toString(fields) else qfields <- partial_fields
  query_list <- list(timefirst = as.Date.character(timefirst), timelast = as.Date.character(timelast),
                     limit1 = limit1, mode = mode, fields = qfields)
  if (limit2 > 0)
    query_list[["limit2"]] <- limit2
  r <- httr::GET(endpoint, query = query_list, ua)
  if (httr::http_status(r)$category != "Success") {
    print(httr::http_status(r)$message)
    return(FALSE)
  } else if (httr::http_type(r) != "application/json") {
    print("Invalid query")
    return(FALSE)
  } else if (length(httr::content(r)) == 0) {
    print("No records to show")
    return(FALSE)
  } else {
    if (only_id == TRUE) {
      return(as.character(unlist(jsonlite::fromJSON(httr::content(r, "text")))))
    } else {
      return(jsonlite::fromJSON(httr::content(r, "text"), simplifyDataFrame = TRUE))
    }
  }
}
