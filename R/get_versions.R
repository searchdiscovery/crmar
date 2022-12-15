#' Get Salesforce Versions
#'
#' This function will pull all the versions available
#'
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of versions
#'
get_versions <- function(debug = FALSE,
                               consumer_key = Sys.getenv('CONSUMER_KEY'),
                               consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))

  requrl <- glue::glue("{.crmar$instanceurl}/services/data/")
  dataset <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .tcrmr$token)
  purrr::map_df(httr::content(dataset), data.frame)
}
