% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_dataset_files.R
\name{get_dataset_files}
\alias{get_dataset_files}
\title{Get A Dataset's Filies}
\usage{
get_dataset_files(
  datasetId = NULL,
  versionId = NULL,
  fileId = NULL,
  debug = FALSE,
  consumer_key = Sys.getenv("CONSUMER_KEY"),
  consumer_secret = Sys.getenv("CONSUMER_ID")
)
}
\arguments{
\item{datasetId}{The ID of the dataset}

\item{versionId}{The ID of the dataset version}

\item{fileId}{The ID of the file needed to pull the dataset}

\item{debug}{Outputs the call in the Console for debugging purposes}

\item{consumer_key}{Consumer key given by CRMA App}

\item{consumer_secret}{Consumer secret given by CRMA App}
}
\value{
Dataframe of datasets and metadata
}
\description{
This function will pulls a list of files for a dataset from CRMA
}
