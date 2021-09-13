#' @title  4 png Logos & colors for MLB (baseball)
#' @description MLB Profesional league baseball data table , logos and colors
#' @return Logos and colors from ESPN
#' @export
#' @importFrom httr content GET
#' @import dplyr purrr
#' @examples
#'
#'
#'
#' \donttest{get_png_logos()}

  get_png_logos <- function() {
   message("4 MLB ESPN logos in png!")
    team_url <- "https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/teams"
    raw_teams <- httr::GET(team_url, query = list(limit = "50")) %>%
      httr::content()
    purrr::pluck(raw_teams, "sports", 1, "leagues", 1, "teams")%>%
      dplyr::tibble(value = .data$.) %>%
      tidyr::unnest_wider(.data$value) %>%
      tidyr::unnest_wider(.data$team) %>% tidyr::hoist(
        .data$logos,
        logo = list(1, "href"),
        logodark = list(2, "href"),
        logoscore = list(3, "href"),
        logoscoredark = list(4, "href")
      ) %>%
      dplyr::select(id, "name":"alternateColor", "logo":"logoscoredark", -"shortDisplayName") %>%
      purrr::set_names(
        nm = c(
          "tm_id", "tm_name", "tm_abb", "tm", "primary",
          "secondary", "logo", "logodark", "logoscore", "logoscoredark"
        )
      ) %>%
      dplyr::mutate(
        "primary" = paste0("#", .data$primary),
        "secondary" = paste0("#", .data$secondary)
      )


  }
