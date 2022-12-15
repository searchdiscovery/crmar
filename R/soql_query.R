#' Query SOQL
#'
#' This function will run a query using SOQL
#'
#' @param query The query, in string format.	Either query or queryString is required, but not both. (not used yet)
#' @param body A query string appending to the body of the api call
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
soql_query <- function(query = NULL,
                       body = FALSE,
                       debug = FALSE,
                       consumer_key = Sys.getenv('CONSUMER_KEY'),
                       consumer_secret = Sys.getenv('CONSUMER_ID')) {

  stopifnot(is.character(.crmar$instanceurl))

  #query endpoint
  endpoint <- 'query/'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}?q={query}")

  dataset <- get_crma(verb = "GET",
                      requrl,
                      consumer_key = consumer_key,
                      consumer_secret = consumer_secret,
                      body = body,
                      debug = debug,
                      token = .crmar$token)

  purrr::map_df(httr::content(dataset)$records, data.frame)
}
