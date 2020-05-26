### post data into eHRAF data and get the result

library(rvest)
library(httr)
url <- "https://ehrafworldcultures.yale.edu/ehrafe/booleanSearch.do?method=booleanSearch&searchType=advanced"
url <- 'https://httpbin.org/get'

head = c('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:76.0) Gecko/20100101 Firefox/76.0')

response <- httr::POST(url, add_headers(head),)
response
response$headers
response$request
