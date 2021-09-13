#' @title  Wordmarks & colors for MLB (baseball)
#'
#' @description MLB Profesional league baseball data table , Wordmarks and colors
#'
#' @return Wordmarks and colors
#' @export
#' @import utils
#' @examples
#' \donttest{get_mlb_wordmarks()}
#'
get_mlb_wordmarks <- function() {

  get_mlb_wordmarks <- utils::read.csv("https://raw.githubusercontent.com/IvoVillanueva/wordmarks/main/mlb_wordmarks.csv", stringsAsFactors = FALSE)

  return(get_mlb_wordmarks)

}
