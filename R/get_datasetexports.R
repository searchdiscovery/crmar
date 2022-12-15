#' Get A Dataset Exports
#'
#' This function will pulls a list of available dataset exports
#'
#' @param limit Requesting Metadata
#' @param fields The fields to be included in the response. Default is all fields.
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe
#'
#' @importFrom readr read_delim
#'
get_datasetexports <- function(limit = 100,
                               fields = 'FIELDS(ALL)',
                               debug = FALSE,
                               consumer_key = Sys.getenv('CONSUMER_KEY'),
                               consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))

  soql_string <- stringr::str_replace_all(glue::glue('SELECT {fields} FROM DatasetExport LIMIT {limit}'), ' ', replacement = '+' )

  soqlres <- soql_query(soql_string)

  soqlres
}
