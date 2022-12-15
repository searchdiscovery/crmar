#' Get A Dataset Export Part ID
#'
#' This function will pulls a list of available dataset exports
#'
#' @param exportid The export id
#' @param limit Requesting Metadata
#' @param fields Request specific fields other than the default `Id, CreatedDate, and PartNumber`. See details for more options.
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @details
#'
#' Fields options can include any of the following options:
#' AllCompressedDataFileLength, CreatedById, CreatedDate, DataFile, DataFileLength,
#' DatasetExportId, Id, IsDeleted, LastModifiedById, LastModifiedDate, Owner, PartNumber, SystemModstamp
#'
#' @export
#' @return Dataframe
#'
#' @importFrom readr read_delim
#' @importFrom dplyr arrange
#'
get_datasetexportparts <- function(exportid = NULL,
                                   limit = 100,
                                   fields = c('Id', 'DataFileLength', 'DatasetExportId', 'CreatedDate', 'PartNumber'),
                                   debug = FALSE,
                                   consumer_key = Sys.getenv('CONSUMER_KEY'),
                                   consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  stopifnot(is.character(fields))

  #make the fields value a string for the SOQL query
  fieldstring <- paste(fields, collapse = ',')

  #make the soql query string
  soql_string <- stringr::str_replace_all(glue::glue("SELECT {fieldstring} FROM DatasetExportPart WHERE DatasetExportId = '{exportid}'"), ' ', replacement = '+' )

  #call the soql query
  soqlres <- soql_query(soql_string, debug = debug)

  #add in the exportid to the response
  soqlres$exportId <- exportid

  #return the requested data
  dplyr::arrange(soqlres, PartNumber)

}
