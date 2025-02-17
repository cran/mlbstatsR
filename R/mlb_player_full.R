#' @title Estadistica oficial bateo y pitcheo de los jugadores de la MLB (baseball)
#' @param year  numeric
#' @param stats character
#' @param season_type character
#' @return Estadisticas de la pagina oficial mlb.com
#' @export
#' @import tidyr dplyr purrr
#' @importFrom dplyr %>%
#' @importFrom jsonlite fromJSON
#' @importFrom glue glue
#' @importFrom janitor clean_names
#' @examples
#' # year = year que queremos visualizar
#' # stats = hitting o pitching
#' # season_type = 'regular', 'playoffs', 'wildcard',
#' # 'divisionales', 'championship','mundiales' o 'pretemporada
#' # Get las estadisticas de pitcheo del 2018
#' \donttest{mlb_team_stats(2018, "pitching", "regular")}
#'


mlb_player_full <- function(year = year_actual, stats= "hitting", season_type = "regular"){

  year_actual <- as.double(substr(Sys.Date(), 1, 4))

  offset <- seq(0, 400, 25)

  if (!dplyr::between (as.numeric(year), 1903, year_actual)) {
    stop(paste("Por favor escoge un year entre 1903 y ", year_actual))
  }
  if (!season_type %in% c("regular", "playoffs", "wildcard",
                          "divisionales","championship","mundiales","pretemporada")) {
    stop("Please choose one season of 'regular', 'playoffs', 'wildcard', 'divisionales', 'championship',
                            'mundiales' o 'pretemporada'")
  }
  if (!stats %in% c("hitting", "pitching")) {
    stop("Please choose season_type of 'hitting' o 'pitching'")
  }


  message(
    dplyr::case_when(
      season_type == "regular"~ glue::glue("Getting {stats} stats de la {season_type} season del {year}!"),
      season_type == "playoffs" ~ glue::glue("Getting {stats} stats de los {season_type} del {year}!"),
      season_type == "wildcard" ~ glue::glue ("Getting {stats} stats del {season_type} del {year}!"),
      season_type == "divisionales" ~ glue::glue ("Getting {stats} stats de las series {season_type} del {year}!"),
      season_type == "championship" ~ glue::glue ("Getting {stats} stats de la league {season_type} series del {year}!"),
      season_type == "mundiales" ~ glue::glue ("Getting {stats} stats de las series {season_type} del {year}!"),
      season_type == "pretemporada" ~ glue::glue ("Getting {stats} stats de la {season_type} del {year}!")
    )
  )[[1]]


  season_type <- dplyr::case_when( season_type == "regular" ~ "R",
                                   season_type == "playoffs" ~ "P",
                                   season_type == "wildcard"~ "F",
                                   season_type == "divisionales" ~ "D",
                                   season_type == "championship" ~ "L",
                                   season_type == "mundiales" ~ "W",
                                   season_type == "pretemporada" ~ "S")[[1]]


  orden <-  dplyr::case_when( stats == "hitting" ~ "onBasePlusSlugging&order=desc",
                              stats == "pitching" ~ "earnedRunAverage&order=asc")[[1]]

  urls <- glue::glue("https://bdfed.stitch.mlbinfra.com/bdfed/stats/player?stitch_env=prod&season={year}&sportId=1&stats=season&group={stats}&gameType={season_type}&offset={offset}&sortStat={orden}&playerPool=ALL")

  purrr::map(urls, ~jsonlite::fromJSON(.x)) -> crudos

  purrr::map_dfr(crudos, "stats") -> df




   df <-df %>%  janitor::clean_names() %>%
                dplyr::as_tibble() %>%
                dplyr::mutate(stat = stats,
                              season_type = case_when( season_type == "R" ~ "Regular Season",
                                                       season_type == "P" ~ "Post Season",
                                                       season_type == "F" ~ "Wild Card",
                                                       season_type == "D" ~ "Division Series",
                                                       season_type == "L" ~ "League Championship Series",
                                                       season_type == "W" ~ "World Series",
                                                       season_type == "S" ~ "Spring Training",
                                                       TRUE ~ season_type))%>%

                dplyr::select(
                  "season_type", "stat", "year",  dplyr::everything(),-"type" )

  return(df)



}


