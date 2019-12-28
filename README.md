README
================

Please find `pkgdown` .html file
[here](https://github.com/QMSS-G5072-2019/Yang_Liu/blob/master/FinalProject/libgenr/docs/index.html).

# libgenr

This is a R package for **Library Genesis** API (here is the
[homepage](https://forum.mhut.org/viewtopic.php?f=17&t=6874 "LibGen API")).

**Library Genesis** (**LibGen**) is a search engine for articles and
books on various topics, which allows free access to content that is
otherwise paywalled or not digitalized elsewhere.

There are two documented ways to use the free public LiGgen API to query
the LibGen database: by text ID, or by date, which means that it does
not support the most common use – searching for texts. The purpose of
this package (*libgenr*) is not only wrapping on top of the two ways of
queries, but also providing search and download functions. Some utility
functions are included for cleaning data.

## Warning

The Library Genesis maintainers very kindly made a public API that
doesn’t require an API key to use, so don’t abuse it or they might
change that.

In any case, if you make too many requests in a short period of time
they’ll temporarily block your IP address, so go slow for your own good
as well.

## Installation

``` r
devtools::install_github("yl4318/libgenr")
library(libgenr)
```

## Usage

### Get books information by IDs

This function gets books information by IDs with user specified or
default fields.

``` r
libgen_ID_retrieve(IDs, fields = c(), full_fields = FALSE)
```

### Search the Library Genesis API by text

Search the Library Genesis API by text and return results of specified
counts and sorted on specified fields.

``` r
libgen_search(query, count = 25, search_in = "def", sort_by = "def",
                          reverse = FALSE, full_fields = FALSE,fields=c())
```

### Download books

This function downloads books using md5 hash code. The download path is
current working directory.

``` r
libgen_download(md5)
```

### Get the latest uploads

This function gets the latest uploads of Library Genesis in specified
time period.

``` r
libgen_new_uploads(timefirst, timelast = Sys.Date(), mode = "last",
                               only_id = FALSE, full_fields = FALSE,fields=c(),count = 1000, first = 1)
```

### Tell if a certain field is contained

This function tells if an object returned from `libgen_retrieve_ID()`,
`libgen_search()`or `libgen_new_uploads()` contains a certain field.

``` r
has_field(field, data)
```

### Clean results by fields

Removes all records in a libgenr object that don’t have specified
field(s) or field(s) values.

``` r
clean_field(data, ...)
```
