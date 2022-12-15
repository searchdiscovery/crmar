#' Get Recipes
#'
#' This function pulls a list of recipes from TCRM
#'
#' @param page A generated token that indicates the view of the objects to be returned.	Optional	v38
#' @param format Returns a collection filtered by the format of the current
#' recipe definition. Valid values are: 'R2' (Data Prep Classic), 'R3' (Data Prep).	Optional	v48
#' @param licenseType Filters the collection by the Analytics license type.
#' Valid values areEinsteinAnalytics (CRM Analytics)Sonic (Salesforce Data Pipeline)	Optional	52
#' @param pageSize Number of items to be returned in a single page. Minimum is
#' 1, maximum is 200, and default is 25.	Optional	38
#' @param q Search terms. Individual terms are separated by spaces. A wildcard is
#' automatically appended to the last token in the query string. If the user’s
#' search query contains quotation marks or wildcards, those symbols are automatically
#' removed from the query string in the URI along with any other special characters.	Optional	38
#' @param sort The type of sort order to be applied to the returned collection.
#' Valid values are: 'AppCreatedBy', 'CreatedDate', 'LastModified', 'LastModifiedBy',
#' 'Mru' (Most Recently Used, last viewed date), 'Name', 'Type'.	Optional	v38
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#' @importFrom glue glue
#'
get_recipes <- function(page = NULL,
                              format = NULL,
                              licenseType = NULL,
                              pageSize = NULL,
                              q = NULL,
                              sort = NULL,
                              debug = FALSE,
                              consumer_key = Sys.getenv('CONSUMER_KEY'),
                              consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## reciepes Endpoint
  stopifnot(is.character(.crmar$instanceurl))

  endpoint <- 'wave/recipes'

  requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}")

  res <- get_crma(requrl,
                  consumer_key = consumer_key,
                  consumer_secret = consumer_secret,
                  debug = debug,
                  token = .crmar$token)
  httr::content(res)
}
