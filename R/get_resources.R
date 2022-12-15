#' Get CRMA Resources By Version
#'
#' This function will pull all the available resources
#'
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
get_resources <- function(debug = FALSE,
                                consumer_key = Sys.getenv('CONSUMER_KEY'),
                                consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'wave'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/")
  dataset <- get_crma(requrl,
                      consumer_key = consumer_key,
                      consumer_secret = consumer_secret,
                      debug = debug,
                      token = .crmar$token)
  httr::content(dataset)
}
