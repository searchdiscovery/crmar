% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_recipe_file.R
\name{get_recipefile}
\alias{get_recipefile}
\title{Get Recipe File}
\usage{
get_recipefile(
  recipe_id = NULL,
  debug = FALSE,
  consumer_key = Sys.getenv("CONSUMER_KEY"),
  consumer_secret = Sys.getenv("CONSUMER_ID")
)
}
\arguments{
\item{recipe_id}{The id of the recipe being requested}

\item{debug}{Outputs the call in the Console for debugging purposes}

\item{consumer_key}{Consumer key given by CRMA App}

\item{consumer_secret}{Consumer secret given by CRMA App}
}
\value{
Dataframe of datasets and metadata
}
\description{
This function pulls a list of recipes from CRMA
}
