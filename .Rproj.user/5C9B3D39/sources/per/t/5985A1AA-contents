#' Get books information by IDs.
#'
#' This function gets books information by IDs with user specified or default fields.
#' @name libgen_ID_retrieve
#' @param IDs One book ID or a vector of book IDs.
#' @param full_fields Whether returns with full fields (\code{TRUE}) or selected fields (\code{FALSE}).
#' @param fields Optional, user specified vector of fields to return. Below is available fields (case sensitive):
#' ID, Title, VolumeInfo, Series, Periodical, Author,Year, Edition, Publisher,
#' City, Pages, Language, Topic,Library, Issue, Identifier, ISSN, ASIN, UDC, LBC, DDC,
#' LCC, Doi, Googlebookid, OpenLibraryID, Commentary, DPI,
#' Color, Cleaned, Orientation, Paginated, Scanned,
#' Bookmarked, Searchable,Filesize,  Extension, MD5, CRC32,
#' eDonkey, AICH, SHA1, TTH, Generic,  Visible, Locator,
#' Local, TimeAdded, TimeLastModified, Coverurl, identifierwodash,
#' tags, pagesinfile, descr, toc, tth, sha1, aich, btih, torrent, crc32
#' @return A data frame with results or FALSE if error occurs.
#' @examples
#' libgen_ID_retrieve(c(1,2,3))
#' libgen_ID_retrieve(c(1,2,3),full_fields=FALSE)
#' libgen_ID_retrieve(c(1,2,3),fields=c('ID','Title','Author'))
#' @export


libgen_ID_retrieve <- function(IDs, fields = c(), full_fields = FALSE) {
  id<-''
  ua <- httr::user_agent("https://github.com/yl4318")
  endpoint <- "http://gen.lib.rus.ec/json.php?"
  full_fields <- "ID, Title, VolumeInfo, Series, Periodical, Author, Year, Edition, Publisher, City, Pages, Language, Topic, Library, Issue, Identifier, ISSN, ASIN, UDC, LBC, DDC, LCC, Doi, Googlebookid, OpenLibraryID, Commentary, DPI, Color, Cleaned, Orientation, Paginated, Scanned, Bookmarked, Searchable,Filesize,  Extension, MD5, CRC32, eDonkey, AICH, SHA1, TTH, Generic,  Visible, Locator, Local, TimeAdded, TimeLastModified, Coverurl, identifierwodash, tags, pagesinfile, descr, toc, tth, sha1, aich, btih, torrent, crc32"
  partial_fields <- "ID, Title, VolumeInfo, Series, Periodical, Author, Year, Edition, Publisher, Pages, Language, Topic, Library, Issue, Identifier, ISSN, Filesize,  Extension, MD5, CRC32, Locator,TimeAdded, TimeLastModified, torrent"
  if (sum(IDs <= 0) > 0) {
    print("ID must start from 1!")
    return(FALSE)
  }
  if (length(fields) > 0) {
    query_fields <- toString(fields)
  } else if (full_fields == TRUE) {
    query_fields <- full_fields
  } else {
    query_fields <- partial_fields
  }
  query_id <- toString(IDs)
  r <- httr::GET(endpoint, query = list(ids = query_id, fields = query_fields),
           ua)
  if (httr::http_status(r)$category != "Success") {
    print(httr::http_status(r)$message)
    return(FALSE)
  } else {
    df <- dplyr::arrange(jsonlite::fromJSON(httr::content(r, "text"), simplifyDataFrame = TRUE),
                  as.numeric(id))
    df <- df[rank(as.numeric(IDs)), ]
    return(df)
  }
}
