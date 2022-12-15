#' Get A Dataset
#'
#' This function will pulls a dataset from TCRM
#'
#' @param datasetId The ID of the dataset
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
get_dataset <- function(datasetId = NULL,
                               debug = FALSE,
                               consumer_key = Sys.getenv('CONSUMER_KEY'),
                               consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'wave/datasets'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/{datasetId}")
  dataset <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .crmar$token)
  httr::content(dataset)
}
