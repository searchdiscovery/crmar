#' Get Datasets
#'
#' This function pulls a list of datasets from TCRM
#'
#' @param datasetTypes	The type of the dataset. Valid values are: 'Default', 'Live', 'Staged', 'Data'. Optional	50.0
#' @param folderId	Filters the results to include only the contents of a specific folder.
#' The id can be the requesting user’s ID for items in the user’s private folder.	Optional	36.0
#' @param hasCurrentOnly	Boolean	Indicates whether to filter the list of datasets to include only those datasets that have a current version (true) or not (false).. The default is false.	Optional	52.0
#' @param ids	Filter the list of datasets to include only datasets with the specified ids.	Optional	53.0
#' @param includeCurrentVersion	Boolean	Indicates whether to include the current dataset version metadata in the collection (true) or not (false).. The default is false.	Optional	52.0
#' @param licenseType Filters the collection by the Analytics license type.. Valid values are: 'EinsteinAnalytics' (CRM Analytics), 'Sonic' (Salesforce Data Pipeline). Optional	52.0
#' @param order	Ordering applied to the results. Valid values are: 'Ascending', 'Descending'. Optional	42.0
#' @param page	A generated token that indicates the view of datasets to be returned.	Optional	36.0
#' @param pageSize	The number of items to be returned in a single page. Minimum is 1, maximum is 200, and default is 25.	Optional	36.0
#' @param q Search terms. Individual terms are separated by spaces. A wildcard is automatically appended to the last token in the query string. If the user’s search query contains quotation marks or wildcards, those symbols are automatically removed from the query string in the URI along with any other special characters.	Optional	36.0
#' @param scope The type of scope to be applied to the returned collection. Valid values are: 'CreatedByMe', 'Mru' (Most Recently Used), 'SharedWithMe'. Optional	38.0
#' @param sort The type of sort order to be applied to the returned collection. Valid values are: 'App', 'CreatedBy', 'CreatedDate', 'LastModified', 'LastModifiedBy', 'Mru' (Most Recently Used, last viewed date), 'Name', 'Type'. Optional	38.0
#' @param supportsNewDates Indicates whether to filters the list of datasets to include only those datasets that support new dates (true) or not (false).. The default is false.	Optional	52.0
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
get_datasets <- function(datasetTypes = NULL,
                               folderId = NULL,
                               hasCurrentOnly = NULL,
                               ids = NULL,
                               includeCurrentVersion = NULL,
                               licenseType = NULL,
                               order = NULL,
                               page = NULL,
                               pageSize = NULL,
                               q = NULL,
                               scope = NULL,
                               sort = NULL,
                               supportsNewDates = NULL,
                               debug = FALSE,
                               consumer_key = Sys.getenv('CONSUMER_KEY'),
                               consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'wave/datasets'
  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}")
  datasets <- get_crma(requrl,
                       consumer_key = consumer_key,
                       consumer_secret = consumer_secret,
                       debug = debug,
                       token = .crmar$token)

  purrr::map_df(httr::content(datasets)$datasets, data.frame)
}
