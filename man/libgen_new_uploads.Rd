% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/libgen_new_uploads.R
\name{libgen_new_uploads}
\alias{libgen_new_uploads}
\title{Get the latest uploads of Library Genesis.}
\usage{
libgen_new_uploads(timefirst, timelast = Sys.Date(), mode = "last",
  only_id = FALSE, full_fields = FALSE, fields = c(), count = 1000,
  first = 1)
}
\arguments{
\item{timefirst}{the beginning time of query, in the format  of 'YYYY-MM-DD'.}

\item{timelast}{the ending time of query, in the format of 'YYYY-MM-DD', defaults to current day.}

\item{mode}{\code{last} to return last uploaded results, \code{modified} to return last modified results. Defaults to \code{last}.}

\item{only_id}{whether returns only id fields so that results can be passed to get_by_ID function. Defaults to \code{FALSE}.}

\item{full_fields}{whether returns with full fields (\code{TRUE}) or selected fields (\code{FALSE}).}

\item{fields}{Optional, user specified vector of fields to return.}

\item{count}{number of items to return, defaults to 1000.}

\item{first}{the first row to return, defaults to 1.}
}
\value{
A data frame with results or a vector of character if \code{only_id==TRUE}.
}
\description{
This function gets the latest uploads of Library Genesis in specified time period.
}
\examples{
libgen_new_uploads(Sys.Date(),count=100)
libgen_new_uploads('2019-12-01','2019-12-08',count=100,first=100,mode='modified')
libgen_new_uploads('2019-01-01','2019-12-08',count=1000,only_id=TRUE,mode='last')
}
