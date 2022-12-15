#' Get a dataset export part file
#'
#' This function will pull a dataset export part file that has been exported using the CSV output options in recipes.
#'
#' @param exportpart The id of the dataset export part
#' @param filelength The binary length of the file
#' @param exportpartid Used to help define the output relationship to combine the results of multiple parts.
#' Default is NULL.
#' @param colnames Either TRUE, FALSE or a character vector of column names.
#' If TRUE, the first row of the input will be used as the column names, and will not be included in the data frame. If FALSE, column names will be generated automatically: X1, X2, X3 etc.
#' If col_names is a character vector, the values will be used as the names of the columns, and the first row of the input will be read into the first row of the output data frame.
#' Missing (NA) column names will generate a warning, and be filled in with dummy names ...1, ...2 etc. Duplicate column names will generate a warning and be made unique, see name_repair to control how this is done.
#' @param coltypes One of NULL, a cols() specification, or a string. See vignette("readr") for more details.
#' If NULL, all column types will be imputed from guess_max rows on the input interspersed throughout the file. This is convenient (and fast), but not robust. If the imputation fails, you'll need to increase the guess_max or supply the correct types yourself.
#' Column specifications created by list() or cols() must contain one column specification for each column. If you only want to read a subset of the columns, use cols_only().
#' Alternatively, you can use a compact string representation where each character represents one column:
#'   c = character
#'   i = integer
#'   n = number
#'   d = double
#'   l = logical
#'   f = factor
#'   D = date
#'   T = date time
#'   t = time
#'   ? = guess
#'   _ or - = skip
#' By default, reading a file without a column specification will print a message showing what readr guessed they were. To remove this message, set show_col_types = FALSE or set 'options(readr.show_col_types = FALSE).
#' @param debug Outputs the call in the Console for debugging purposes
#' @param consumer_key Consumer key given by CRMA App
#' @param consumer_secret Consumer secret given by CRMA App
#'
#' @export
#' @return Dataframe of available dataset export part files
#'
#' @importFrom readr read_delim
#'
get_datasetexportpartfile <- function(exportpart = NULL,
                                      filelength = 100,
                                      exportpartid = NULL,
                                      colnames = TRUE,
                                      coltypes = NULL,
                                      debug = FALSE,
                                      consumer_key = Sys.getenv('CONSUMER_KEY'),
                                      consumer_secret = Sys.getenv('CONSUMER_ID')) {
  ## Datasets Endpoint
  stopifnot(is.character(.crmar$instanceurl))
  endpoint <- 'sobjects/DatasetExportPart'

  #Are there more than one parts?
  parts.n <- length(exportpart)
  #If there is only one part defined then run the part id and return the result
  if (parts.n == 1){
    requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/{exportpart}/DataFile")
    res <- get_crma(requrl,
                    consumer_key = consumer_key,
                    consumer_secret = consumer_secret,
                    debug = debug,
                    token = .crmar$token)
    dataset <- httr::content(res, as = 'raw')
    return(readr::read_delim(dataset))
  } else {
    raw_output <- purrr::map2(endpoint, exportpart, function(endpoint, exportpart) {
      requrl <- glue::glue("{.crmar$instanceurl}{.crmar$version_url}/{endpoint}/{exportpart}/DataFile")
      res <- get_crma(requrl,
                      consumer_key = consumer_key,
                      consumer_secret = consumer_secret,
                      debug = debug,
                      token = .crmar$token)
      httr::content(res, as = 'raw')
    })
    if(length(raw_output) > 1){
      dataset <- list()
      for (i in seq(raw_output)) {
        if (i == 1) {
          dataset <- raw_output[[i]]
        } else {
          dataset <- append(dataset, raw_output[[i]])
        }
      }
    }
    return(readr::read_delim(dataset))
    }
}
