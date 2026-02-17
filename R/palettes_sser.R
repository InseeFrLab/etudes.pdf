#' Affichage et accès aux palettes de couleurs sser
#'
#' @description
#' Cette fonction permet d'afficher toutes les palettes de couleurs disponibles
#' ou de retourner une palette spécifique si son nom est fourni.
#'
#' @param palette Une chaîne de caractères indiquant le nom de la palette souhaitée.
#'   Si `NULL` (par défaut), la fonction affiche un graphique de toutes les palettes disponibles.
#'   Les palettes disponibles sont :
#'   - "IRJ" (4 couleurs)
#'   - "bleu" (4 couleurs)
#'   - "vert" (4 couleurs)
#'   - "orange" (4 couleurs)
#'   - "prune" (4 couleurs)
#'   - "IRJ_2_col" (2 couleurs)
#'   - "IRJ_3_col" (3 couleurs)
#'   - "IRJ_4_col" (4 couleurs)
#'   - "IRJ_5_col" (5 couleurs)
#'   - "IRJ_6_col" (6 couleurs)
#'
#' @return
#' Si `palette` est `NULL`, la fonction affiche un graphique des palettes et retourne `NULL` invisiblement.
#' Sinon, elle retourne un vecteur de couleurs correspondant à la palette demandée.
#'
#' @details
#' Les palettes disponibles incluent :
#' \describe{
#'   \item{IRJ}{Palette principale à 4 couleurs (G1, G2, G3, G4)}
#'   \item{bleu}{Palette bleue à 4 couleurs (F1, F2, F3, F4)}
#'   \item{vert}{Palette verte à 4 couleurs (E1, E2, E3, E4)}
#'   \item{orange}{Palette orange à 4 couleurs (O1, O2, O3, O4)}
#'   \item{prune}{Palette prune à 4 couleurs (P1, P2, P3, P4)}
#'   \item{IRJ_2_col à IRJ_6_col}{Palettes IRJ avec 2 à 6 couleurs}
#' }
#'
#' @examples
#' library(ggplot2)
#' library(chartegraphique.sser)
#' # Afficher toutes les palettes
#' palettes_sser()
#'
#' # Récupérer une palette spécifique
#' couleurs <- palettes_sser("IRJ")
#' couleurs <- palettes_sser("IRJ_6_col")
#'
#' # Appliquer une palette :
#' ggplot(mpg, aes(x = class, fill = drv)) +
#'   geom_bar() +
#'   scale_fill_manual(values = palettes_sser("IRJ"))
#'
#' @export

palettes_sser <- function(palette=NULL){

  palettes <- list(
    "IRJ" = setNames(colors_sser("G1","G2","G3","G4"),c("G1","G2","G3","G4")),
    "bleu" = setNames(colors_sser("F1","F2","F3","F4"),c("F1","F2","F3","F4")),
    "vert" = setNames(colors_sser("E1","E2","E3","E4"),c("E1","E2","E3","E4")),
    "orange" = setNames(colors_sser("O1","O2","O3","O4"),c("O1","O2","O3","O4")),
    "prune" = setNames(colors_sser("P1","P2","P3","P4"),c("P1","P2","P3","P4")),

    "IRJ_2_col"= setNames(colors_sser("G1","F2"),c("G1","F2")),
    "IRJ_3_col"= setNames(colors_sser("G1","F2","F1"),c("G1","F2","F1")),
    "IRJ_4_col"= setNames(colors_sser("G1","F2","F1","E2"),c("G1","F2","F1","E2")),
    "IRJ_5_col"= setNames(colors_sser("G1","F2","F1","E2","O1"),c("G1","F2","F1","E2","O1")),
    "IRJ_6_col"= setNames(colors_sser("G1","F2","F1","E2","O1","P2"),c("G1","F2","F1","E2","O1","P2"))
  )


  if(is.null(palette)){
    # Create a data frame for all palettes
    df <- data.frame(
      palette = rep(names(palettes), lengths(palettes)),
      color = unlist(palettes),
      colorName = unlist(lapply(palettes,names)),
      x = unlist(lapply(palettes, seq_along)),
      y = rep(seq_along(palettes), lengths(palettes))
    )

    df$palette <- factor(df$palette, levels = names(palettes))


    g4 <- ggplot(df, aes(x = x, y = 1)) +
      geom_tile(aes(fill = color), colour = "white", height = 0.8) +
      geom_text(aes(label = colorName), colour = "white", size = 2.5) +
      scale_fill_identity() +
      facet_grid(palette ~ ., scales = "free_x", space = "free_x", switch = "y") +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        strip.text.y.left = element_text(angle = 0, hjust = 1, size = 10),  # Labels horizontaux à gauche
        strip.background = element_blank(),
        panel.spacing = unit(0.1, "lines"),
        strip.placement = "outside"
      ) +
      ggtitle("sser palettes")


    print(g4)
    return(invisible(NULL))
  }

  palette_return <- palettes[[palette]]
  names(palette_return) <- NULL

  return(palette_return)
}
