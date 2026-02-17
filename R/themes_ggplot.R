#' @title Thème ggplot2 personnalisé pour les graphiques SSER
#' @description
#' Ces fonctions contiennent les paramètres de \code{theme} à appliquer aux graphiques
#' afin d'être conforme à la charte graphique du  SSER (couleurs de fond, grilles, polices, etc.)
#'
#' @param base_size Taille de base de la police (en points). Par défaut : 14.
#' @param plot_title Si \code{TRUE}, affiche le titre du graphique. Par défaut : \code{TRUE}.
#' @param plot_title_size Taille du titre du graphique. Par défaut : \code{base_size + 1}.
#' @param caption_size Taille de la légende du graphique. Par défaut : \code{base_size}.
#' @param axis_title \code{TRUE} \code{FALSE} ou une combinaison de 'x' 'y'
#'   pour afficher le titre des axes x et/ou y . Par défaut : \code{FALSE}.
#' @param axis_title_size Taille des titres des axes. Par défaut : \code{base_size}.
#' @param axis_title_just Justification des titres des axes.
#'   Doit être une chaîne de 1 ou 2 caractères parmi \code{c("b", "l", "m", "c", "r", "t")}.
#'   Par exemple, \code{"mc"} pour centré horizontalement et verticalement. Par défaut : \code{"mc"}.
#' @param axis_text \code{TRUE} \code{FALSE} ou une combinaison de 'x' 'y'
#'   pour afficher le texte des axes x et/ou y . Par défaut : \code{"xy"}.
#' @param axis_text_size Taille du texte des axes. Par défaut : \code{base_size}.
#' @param axis_line \code{TRUE} \code{FALSE} ou une combinaison de 'x' 'y'
#'   pour afficher la ligne de l'axe x et/ou y . Par défaut : \code{FALSE}.
#' @param axis_ticks Si \code{TRUE}, affiche les graduations des axes. Par défaut : \code{FALSE}.
#' @param grid  Grilles du graphique (une combinaison de `X`, `x`, `Y`, `y` ou \code{FALSE}). Par défaut : \code{"XY"}.
#' @param plot_legend  Si \code{TRUE}, affiche la légende. Par défaut : \code{TRUE}.
#' @param legend_title Si \code{TRUE}, affiche le titre de la légende. Par défaut : \code{FALSE}.
#' @param legend_size  Taille du texte de la légende. Par défaut : \code{base_size}.
#' @param legend_position  Position de la légende :
#'   \code{"bottom"}, \code{"left"}, \code{"top"}, \code{"right"}, ou \code{"none"}. Par défaut : \code{"bottom"}.
#'
#' @import ggtext
#' @import ggplot2
#'
#' @details
#' Ce thème respecte strictement la charte graphique SSER :
#' \itemize{
#'   \item \strong{theme_sser()} : Version de base avec un fond transparent.
#'   \item \strong{theme_sser_irj()} : Version pour les IRJ avec un fond coloré gris clair
#'   \item \strong{theme_sser_circle()} : Version adaptée aux graphiques circulaires (camemberts).
#' }
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#'
#' # Exemple de base avec theme_sser()
#' ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
#'   geom_point() +
#'   labs(title = "Relation longueur/largeur des sépales") +
#'   theme_sser()
#'
#' # Exemple avec theme_sser_irj() (fond coloré pour IRJ)
#' ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
#'   geom_point() +
#'   labs(title = "Relation longueur/largeur des sépales") +
#'   theme_sser_irj()
#'
#' # Exemple pour un graphique circulaire (camembert) avec theme_sser_circle()
#' ggplot(data = iris, aes(x = 1, fill = Species)) +
#'  geom_bar() +
#'  coord_polar("y") +
#'  theme_sser_circle()
#' }
#'
#' @seealso
#' \code{\link[ggplot2]{theme}} pour la fonction ggplot2 sous-jacente,
#'
#' @aliases theme_sser theme_sser_irj theme_sser_circle
#' @export

theme_sser <- function(base_size = 14,
                       plot_title = TRUE,
                       plot_title_size = base_size + 1,
                       caption_size = base_size ,
                       axis_title = FALSE,
                       axis_title_size = base_size,
                       axis_title_just = "mc",
                       axis_text = "xy",
                       axis_text_size = base_size,
                       axis_line = FALSE,
                       axis_ticks = FALSE,
                       grid = "XY",
                       plot_legend = TRUE,
                       legend_title = FALSE,
                       legend_size = base_size,
                       legend_position = "bottom"
) {

  # Paramètres fixes
  base_family <- "Marianne" # Police de base imposée par la charte graphique
  caption_hjust = 0 # Marge à gauche de la partie "caption"
  caption_margin = 10 #  Marge supérieure de la partie "caption" en points

  # Construction du thème
  ret <- ggplot2::theme_minimal(base_family = base_family, base_size = base_size) +
    theme_sser_background(grid) +
    theme_sser_title(plot_title, plot_title_size, base_family) +
    theme_sser_legend(plot_legend, legend_title, legend_size, legend_position) +
    theme_sser_axis(axis_line, axis_ticks, axis_text, axis_text_size,
                    axis_title, axis_title_size,
                    axis_title_just, base_family) +
    theme_sser_caption(caption_size, caption_margin, caption_hjust, base_family) +
    theme_sser_figure()

  return(ret)
}


### Fonction interne pour l'arrière-plan et les grilles
theme_sser_background <- function(grid) {

  background_theme <- ggplot2::theme()

## Gestion des grilles
  # Activation de toutes les grilles
  if (inherits(grid, "character") | grid == TRUE) {
    background_theme <- background_theme + ggplot2::theme(panel.grid = ggplot2::element_line(color = "black", linetype = "dotted", linewidth = 0.1))
    background_theme <- background_theme + ggplot2::theme(panel.grid.major.y = ggplot2::element_line(color = "black", linetype = "dotted", linewidth = 0.1))
    background_theme <- background_theme + ggplot2::theme(panel.grid.minor.y = ggplot2::element_line(color = "black", linetype = "dotted", linewidth = 0.1))
    background_theme <- background_theme + ggplot2::theme(panel.grid.major.x = ggplot2::element_line(color = "black", linetype = "dotted", linewidth = 0.1))
    background_theme <- background_theme + ggplot2::theme(panel.grid.minor.x = ggplot2::element_line(color = "black", linetype = "dotted", linewidth = 0.1))
  }
    # Suppression des grilles pour les caractères non trouvés
    if (inherits(grid, "character")){
      if (regexpr("Y", grid)[1] < 0)  background_theme <- background_theme + ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
      if (regexpr("y", grid)[1] < 0)  background_theme <- background_theme + ggplot2::theme(panel.grid.minor.y = ggplot2::element_blank())
      if (regexpr("X", grid)[1] < 0)  background_theme <- background_theme + ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
      if (regexpr("x", grid)[1] < 0)  background_theme <- background_theme + ggplot2::theme(panel.grid.minor.x = ggplot2::element_blank())
    }
  else{
    background_theme <- background_theme + ggplot2::theme(panel.grid = ggplot2::element_blank())
  }
  return(background_theme)
}

### Fonction interne pour le titre

theme_sser_title <- function(plot_title, plot_title_size, base_family) {
  if (plot_title) {
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0,
                                                      size = plot_title_size,
                                                      margin = margin(b = 10),
                                                      family = base_family,
                                                      face = "plain"
                                                      ))
  } else {
    ggplot2::theme(plot.title = element_blank())
  }
}


### Fonction interne pour la légende

theme_sser_legend <- function(plot_legend, legend_title, legend_size, legend_position) {
  if (plot_legend) {
    legend_theme <- theme(
      legend.background = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank(),
      legend.position = legend_position,
      legend.text = ggplot2::element_text(size = legend_size),
      legend.box.background = ggplot2::element_blank()
    )
    if (!legend_title) {
      legend_theme <- legend_theme + ggplot2::theme(legend.title = ggplot2::element_blank())
    }
    legend_theme
  } else {
    ggplot2::theme(legend.position = "none")
  }
}



### Fonction interne pour les axes

theme_sser_axis <- function(axis_line,axis_ticks,
                            axis_text, axis_text_size, axis_title,
                            axis_title_size, axis_title_just, base_family) {
  axis_theme <- theme()

## Gestion des lignes des axes

  # Activation de toutes les lignes d'axes
  if (inherits(axis_line, "character") | axis_line == TRUE) {
    axis_theme <- axis_theme + ggplot2::theme(axis.line.x = ggplot2::element_line(color = "black", linewidth = 0.15))
    axis_theme <- axis_theme + ggplot2::theme(axis.line.y = ggplot2::element_line(color = "black", linewidth = 0.15))
    axis_theme <- axis_theme + ggplot2::theme(axis.line = ggplot2::element_line(color = "black", linewidth = 0.15))

    # Suppression des des lignes des axes pour les caractères non trouvés
    if (inherits(axis_line, "character")){
      if (regexpr("x", tolower(axis_line))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.line.x = ggplot2::element_blank())
      if (regexpr("y", tolower(axis_line))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.line.y = ggplot2::element_blank())
    }
  }else{
    axis_theme <- axis_theme + ggplot2::theme(axis.line.x = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.line.y = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.line = ggplot2::element_blank())
  }

## Gestion des ticks des axes

  # Activation de toutes les ticks des axes
  if (inherits(axis_ticks, "character") | axis_ticks == TRUE) {
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks.x = ggplot2::element_line(linewidth = 0.15))
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks.y = ggplot2::element_line(linewidth = 0.15))
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks   = ggplot2::element_line(linewidth = 0.15))
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks.length = grid::unit(5, "pt"))

    # Suppression des des ticks des axes pour les caractères non trouvés
    if (inherits(axis_ticks, "character")){
      if (regexpr("x", tolower(axis_ticks))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.ticks.x = ggplot2::element_blank())
      if (regexpr("y", tolower(axis_ticks))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.ticks.y = ggplot2::element_blank())
    }
  }else{
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks.x = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks.y = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.ticks = ggplot2::element_blank())
  }

  # Alignement des titres des axes
  ## A RETRAVAILLER PLUS TARD POUR PLACER LE TITRE DE L'AXE Y EN HAUT AVEC UN ANGLE A 90
  xj <- switch(tolower(substr(axis_title_just, 1, 1)), b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)
  yj <- switch(tolower(substr(axis_title_just, 2, 2)), b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)

## Gestion du texte des axes

  # Activation de tous les textes des axes
  if (inherits(axis_text, "character") | axis_text == TRUE) {
    axis_theme <- axis_theme + ggplot2::theme(axis.text = ggplot2::element_text(size = axis_text_size, color = "black"))
    axis_theme <- axis_theme + ggplot2::theme(axis.text.x = ggplot2::element_text(size = axis_text_size, color = "black"))
    axis_theme <- axis_theme + ggplot2::theme(axis.text.y = ggplot2::element_text(size = axis_text_size, color = "black"))

    # Suppression des des textes des axes pour les caractères non trouvés
    if (inherits(axis_text, "character")){
      if (regexpr("x", tolower(axis_text))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.text.x = ggplot2::element_blank())
      if (regexpr("y", tolower(axis_text))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.text.y = ggplot2::element_blank())
    }
  }else{
    axis_theme <- axis_theme + ggplot2::theme(axis.text.x = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.text.y = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.text = ggplot2::element_blank())
  }


  # Activation de tous les titres des axes
  if (inherits(axis_title, "character") | axis_title == TRUE) {
    axis_theme <- axis_theme + ggplot2::theme(axis.title = ggplot2::element_text(size = axis_title_size, family = base_family, face = "plain", color = "black", hjust = xj, vjust = yj))
    axis_theme <- axis_theme + ggplot2::theme(axis.title.x = ggplot2::element_text(size = axis_title_size, family = base_family, face = "plain", color = "black", hjust = xj))
    axis_theme <- axis_theme + ggplot2::theme(axis.title.y = ggplot2::element_text(size = axis_title_size, family = base_family, face = "plain", color = "black", vjust = yj))

    # Suppression des titres des axes pour les caractères non trouvés
    if (inherits(axis_title, "character")){
      if (regexpr("x", tolower(axis_title))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.title.x = ggplot2::element_blank())
      if (regexpr("y", tolower(axis_title))[1] < 0)  axis_theme <- axis_theme + ggplot2::theme(axis.title.y = ggplot2::element_blank())
    }
  }else{
    axis_theme <- axis_theme + ggplot2::theme(axis.title.x = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.title.y = ggplot2::element_blank())
    axis_theme <- axis_theme + ggplot2::theme(axis.title = ggplot2::element_blank())
  }

  return(axis_theme)
}

# Fonction interne pour la légende du graphique

theme_sser_caption <- function(caption_size, caption_margin, caption_hjust, base_family) {
  theme(
    plot.caption.position = "plot",
    plot.caption = ggtext::element_markdown(
      lineheight = 1.2,
      hjust = caption_hjust, size = caption_size,
      margin = margin(t = caption_margin),
      family = base_family)
  )
}


# Fonction interne pour les marges et le cadre des figures

theme_sser_figure <- function() {
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "cm"),
    panel.border = element_blank(),
    panel.spacing = grid::unit(2, "lines")
  )
}


#' Theme sser pour les IRJ
#' @rdname theme_sser
#' @export
theme_sser_irj <- function(base_size = 14,
                           plot_title = TRUE,
                           plot_title_size = base_size + 1,
                           caption_size = base_size ,
                           axis_title = FALSE,
                           axis_title_size = base_size,
                           axis_title_just = "mc",
                           axis_text = "xy",
                           axis_text_size = base_size,
                           axis_line = FALSE,
                           axis_ticks = FALSE,
                           grid = "XY",
                           plot_legend = TRUE,
                           legend_title = FALSE,
                           legend_size = base_size,
                           legend_position = "bottom"){

  theme_irj <- theme_sser(base_size       = base_size,
                          plot_title      = plot_title,
                          plot_title_size = plot_title_size,
                          caption_size    = caption_size ,
                          axis_title      = axis_title,
                          axis_title_size = axis_title_size,
                          axis_title_just = axis_title_just,
                          axis_text       = axis_text,
                          axis_text_size  = axis_text_size,
                          axis_line       = axis_line,
                          axis_ticks      = axis_ticks,
                          grid            = grid,
                          plot_legend     = plot_legend,
                          legend_title    = legend_title,
                          legend_size     = legend_size,
                          legend_position = legend_position) +
    theme(panel.background = ggplot2::element_rect(fill = "#f5f5f5", color = NA),
          plot.background = ggplot2::element_rect(fill = "#f5f5f5", color = NA))

  return(theme_irj)
  }



#' @title Thème ggplot2 personnalisé pour les graphiques SSER circulaire
#' @rdname theme_sser
#' @export
theme_sser_circle <- function(...) {
  theme_sser(...,
             axis_text = FALSE,
             axis_title = FALSE,
             legend_position = "right"

  )
}
