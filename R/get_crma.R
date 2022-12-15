#' Get verb based API call
#'
#' Function used internally to pull data from CRMA
#'
#' @param requrl Request URL defined by the function requesting data
#' @param consumer_key The consumer key from the app in SalesForce
#' @param consumer_secret The consumer secret from the app in SalesForce
#' @param debug Outputs the call in the Console for debugging purposes
#' @param token The token defined during the authorization process
#' @param body The body of the request
#' @param verb The verb of the httr call
#'
#' @noRd
#'
get_crma <- function(requrl,
                     consumer_key,
                     consumer_secret,
                     debug = FALSE,
                     token = .crmar$token,
                     body = FALSE,
                     verb = "GET") {

  get_token_config <- function(consumer_key,
                               client_secret,
                               token) {
    type <- httr::config(token = .crmar$token)
  }

  if (debug) {
    debug_call <- httr::verbose(data_out = TRUE, data_in = TRUE, info = TRUE)
  } else {
    debug_call <- NULL
  }

  token_config <- get_token_config(consumer_key = consumer_key)#, client_secret = client_secret)

  req <- httr::RETRY(verb,
                     url = requrl,
                     encode = "json",
                     accept_json(),
                     body = body,
                     token_config,
                     debug_call,
                     httr::add_headers(
                       `client_id` = consumer_key
                     ))
}
