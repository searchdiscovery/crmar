#' Get Recipe File
#'
#' This function pulls a list of recipes from CRMA
#'
#' @param recipe_id The id of the recipe being requested
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of datasets and metadata
#' @importFrom glue glue
#'
get_recipefile <- function(recipe_id = NULL,
                           debug = FALSE,
                           consumer_key = Sys.getenv('CONSUMER_KEY'),
                           consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Recipes Endpoint
  stopifnot(is.character(.crmar$instanceurl))

  endpoint <- 'wave/recipes'

  requrl <- glue::glue("{.crmar$instanceurl}/services/data/v52.0/{endpoint}/{recipe_id}/file")

  res <- get_crma(requrl,
                  consumer_key = consumer_key,
                  consumer_secret = consumer_secret,
                  debug = debug,
                  token = .crmar$token)

  #result <- cat(httr::content(res, as = 'text', encoding = 'UTF-8'), sep = '\n', file = )
  res
}
