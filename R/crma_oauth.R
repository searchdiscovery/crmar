#` Oauth function to authorize and get the access token
#'
#' Description this is the description
#'
#' @param baseurl A URL that the Auth should use to authenticate through
#' @param consumer_key This is the name of the person
#' @param consumer_secret this is the other person
#'
#' @import httr
#' @export
#`
crmar_auth <- function(baseurl = "https://login.salesforce.com/",
                       consumer_key = Sys.getenv("CONSUMER_KEY"),
                       consumer_secret = Sys.getenv("CONSUMER_SECRET")) {

  stopifnot(is.character(consumer_key))
  stopifnot(is.character(consumer_secret))

  if (any(c(consumer_key, consumer_secret) == "")) {
    stop("Client ID or Client Secret not found. Are your environment variables named `CONSUMER_KEY` and `CONSUMER_SECRET`?")
  }

  crma_endpoint <- httr::oauth_endpoint(
    authorize = "services/oauth2/authorize",
    access = "services/oauth2/token",
    base_url = baseurl
  )

  crma_app <- httr::oauth_app(
    appname = "change",
    key = consumer_key,
    secret = consumer_secret
  )

  #Oauth2 token
  token <- httr::oauth2.0_token(
    endpoint = crma_endpoint,
    app = crma_app,
    scope = "api",
    use_oob = TRUE,
    oob_value = "https://localhost"
  )

  message("Successfully authenticated with OAuth")
  .crmar$token <- token
  .crmar$scope <- token$credentials$scope
  .crmar$accesstoken <- token$credentials$access_token
  .crmar$instanceurl <- token$credentials$instance_url
  .crmar$id <- token$credentials$id
  .crmar$signature <- token$credentials$signature
  .crmar$consumer_key <- consumer_key
  .crmar$consumer_secret <- consumer_secret
  .crmar$version <- version
  #get the version and save it as a session item
  versions <- get_versions()
  .crmar$version_url <-  versions[nrow(versions), ]$url
}
