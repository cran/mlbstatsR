#' @title Apply ivo theme to a plots
#'
#' @param data An existing plot object
#' @param ... Optional additional arguments to plots
#' @return Returns a plot
#' @importFrom dplyr %>%
#' @importFrom ggplot2 '%+replace%'
#' @importFrom ggtext element_markdown
#' @export
#' @import dplyr
#' @import ggplot2
#' @import ggtext
#' @examples
#' \donttest{
#' theme_ivo()
#' }

theme_ivo <- function(data,...) {
  theme_minimal(base_size = 9, base_family = "Chivo") %+replace%
    theme(
      panel.grid.minor = element_line(colour = "#e1e1e1"),
      panel.grid.major = element_line(color = "#e1e1e1"),
      plot.background = element_rect(fill = "#f4f4f4", color = "#f4f4f4"),
      plot.title.position = "plot",
      plot.title = element_markdown(size = 22, face = "bold"),
      plot.subtitle = element_markdown(size = 16, face = "bold"),
      axis.title.x = element_text(size = 16, hjust = 0.5, face = "bold"),
      axis.title.y = element_text(size = 16, hjust = 0.5, face = "bold"),
      plot.margin = margin(15, 25, 20, 5),
      plot.caption = ggtext::element_markdown(size = 8.5)
    )
}
