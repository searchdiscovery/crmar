#' Get Services
#'
#' This function will pull all the available services
#'
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
#' @import magrittr
#' @import dplyr
#'
get_services <- function(debug = FALSE,
                         consumer_key = Sys.getenv('CONSUMER_KEY'),
                         consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}")
  dataset <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .crmar$token)
  data.frame(httr::content(dataset)) %>%
    tidyr::pivot_longer(cols = dplyr::everything(), names_to = 'service', values_to = 'endpoint')
}
