#' @title  League stats for MLB from ESPN(baseball)
#'
#' @description MLB Profesional league baseball data table , stats
#' @return stats & logo
#' @export
#' @importFrom httr content GET
#' @import dplyr purrr
#' @importFrom janitor clean_names
#' @examples
#' \donttest{
#' get_league_stats()
#' }
#'
get_league_stats <- function() {
  message("MLB ESPN League Stats!")

team_url <- "https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/teams"
raw_teams <- httr::GET(team_url, query = list(limit = "50")) %>%
  httr::content()
purrr::pluck(raw_teams, "sports", 1, "leagues", 1, "teams") %>%
  dplyr::tibble(value = .data$.) %>%
  tidyr::unnest_wider(.data$value) %>%
  tidyr::unnest_wider(.data$team) %>%
  tidyr::hoist(
    .data$logos,
    "logoscore" = list(3, "href")
  ) %>%
  tidyr::unnest_wider(.data$record) %>%
  tidyr::hoist(
    .data$items,
    summary = list(1, "summary"),
    stats = list(1, "stats")
  ) %>%
  tidyr::hoist(
    .data$stats,
    playoffSeed = list(1, "value"),
    wins = list(2, "value"),
    losses = list(3, "value"),
    winPercent = list(4, "value"),
    gamesBehind = list(5, "value"),
    ties = list(6, "value"),
    OTWins = list(7, "value"),
    OTLosses = list(8, "value"),
    gamesPlayed = list(9, "value"),
    pointsFor = list(10, "value"),
    pointsAgainst = list(11, "value"),
    avgPointsFor = list(12, "value"),
    avgPointsAgainst = list(13, "value"),
    points = list(14, "value"),
    differential = list(15, "value"),
    streak = list(16, "value"),
    divisionWinPercent = list(17, "value"),
    leagueWinPercent = list(18, "value"),
    pointDifferential = list(19, "value"),
    divisionGamesBehind = list(20, "value"),
    homeLosses = list(21, "value"),
    homeWins = list(22, "value"),
    homeTies = list(23, "value"),
    roadLosses = list(24, "value"),
    roadWins = list(25, "value"),
    roadTies = list(26, "value"),
    magicNumberDivision = list(27, "value"),
    magicNumberWildcard = list(28, "value"),
    playoffPercent = list(29, "value"),
    divisionPercent = list(30, "value"),
    wildCardPercent = list(31, "value"),
    divisionTied = list(32, "value")
  ) %>%
  janitor::clean_names() %>%
  dplyr::select(id, "name":"short_display_name", "logoscore":"division_tied", -"logos")
}

