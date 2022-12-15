#' Query TCRM
#'
#' This function will run a query using SOQL
#'
#' @param query The query, in string format.	Either query or queryString (not used yet) is required, but not both.
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#'
crma_query <- function(query = NULL,
                       debug = FALSE,
                       consumer_key = Sys.getenv('CONSUMER_KEY'),
                       consumer_secret = Sys.getenv('CONSUMER_ID')) {

  stopifnot(is.character(.crmar$instanceurl))

  #query endpoint
  endpoint <- 'wave/query/'
  requrl <- glue::glue("{.crmar$instanceurl}/services/data/v53.0/{endpoint}")

  body =  list(query = query)

  dataset <- get_crma(verb = "POST",
                      requrl,
                      consumer_key = consumer_key,
                      consumer_secret = consumer_secret,
                      body = body,
                      debug = debug,
                      token = .crmar$token)

  purrr::map_df(httr::content(dataset)$results$records, as.data.frame)
}
