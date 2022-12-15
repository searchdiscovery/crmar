#' Get A Dataset Export Files
#'
#' This function will pulls a list of files for a dataset from TCRM
#'
#' @param partId The ID of the dataset
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
#' @importFrom readr read_delim
#'
get_datasetfile <- function(partId = NULL,
                                    debug = FALSE,
                                    consumer_key = Sys.getenv('CONSUMER_KEY'),
                                    consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'sobjects/DatasetExportPart'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/{partId}/DataFile")
  dataset <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .crmar$token)

  res <- readBin(httr::content(dataset),what =  "character" )
  res1 <- readr::read_delim(res, delim = ',')
}
