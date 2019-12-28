#' Download books.
#'
#' This function downloads books using md5 hash code. The download path is current working directory.
#' @name libgen_download
#' @param md5 The unique md5 hash code of a book from Library Genesis API.
#' @examples
#' libgen_download('30392A7F10E7B1864670820F2390713A')
#' @export
libgen_download <- function(md5) {
  url <- paste("http://93.174.95.29/_ads/", md5, sep = "")
  req <- xml2::read_html(url)
  file <- rvest::html_attr(rvest::html_node(req, xpath = "//*[@id=\"info\"]/h2/a"),
                    name = "href")
  if (!is.na(file)) {
    name<-utils::URLdecode(utils::tail(unlist(stringr::str_split(file, "/")), n = 1))
    utils::download.file(paste("http://93.174.95.29", file, sep = ""), destfile = name,
                  mode = "wb")
  } else {
    print("Not found on server.")
  }
}
