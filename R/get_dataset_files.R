#' Get A Dataset's Filies
#'
#' This function will pulls a list of files for a dataset from CRMA
#'
#' @param datasetId The ID of the dataset
#' @param versionId The ID of the dataset version
#' @param fileId The ID of the file needed to pull the dataset
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
get_dataset_files <- function(datasetId = NULL,
                              versionId = NULL,
                              fileId = NULL,
                              debug = FALSE,
                              consumer_key = Sys.getenv('CONSUMER_KEY'),
                              consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'wave/datasets'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/{datasetId}/versions/{versionId}/files/{fileId}")
  dataset <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .crmar$token)
  httr::content(dataset)
}
