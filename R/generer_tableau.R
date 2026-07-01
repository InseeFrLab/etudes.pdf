#' generer_tableau_insee
#'
#'
#' genere une image d'un tableau de n lignes, sur 1 ou 2 colonnes
#' @export
generer_tableau_insee <- function(
  n_lignes,
  format_colonnes = 1,
  nom_fichier = "tableau_insee.png"
) {
  # 1. Ajustement du nombre de colonnes
  nb_cols_data <- ifelse(format_colonnes == 1, 5, 10)
  df <- data.frame(
    Indicateur = paste("Mon indicateur sur une longue ligne", 1:n_lignes)
  )
  for (i in 2:nb_cols_data) {
    df[[paste("Donnée", i - 1)]] <- format(
      round(runif(n_lignes, 10, 100), 1),
      nsmall = 1,
      decimal.mark = ","
    )
  }

  # 2. mise en forme
  mat_hjust <- matrix(
    c(0, rep(1, nb_cols_data - 1)),
    nrow = n_lignes,
    ncol = nb_cols_data,
    byrow = TRUE
  )
  mat_x <- matrix(
    c(0.05, rep(0.95, nb_cols_data - 1)),
    nrow = n_lignes,
    ncol = nb_cols_data,
    byrow = TRUE
  )

  insee_theme <- gridExtra::ttheme_default(
    core = list(
      fg_params = list(
        fontsize = 8,
        hjust = as.vector(mat_hjust),
        x = as.vector(mat_x)
      ),
      bg_params = list(fill = "white", col = "white")
    ),
    colhead = list(
      fg_params = list(fontsize = 8, fontface = "bold", hjust = 0.5, x = 0.5),
      bg_params = list(fill = "#E1F1F8", col = "#A0A0A0", lwd = 0.5)
    ),
    padding = grid::unit(c(2, 4), "mm") # Réduit pour éviter le blanc interne
  )

  # 3. Création du grob
  tableau_grob <- gridExtra::tableGrob(df, rows = NULL, theme = insee_theme)

  # Calculer la largeur et hauteur réelles du tableau (en pouces)
  # On convertit les unités grid (mm ou cm) en pouces pour ggsave
  w <- sum(grid::convertWidth(tableau_grob$widths, "in", valueOnly = TRUE))
  h <- sum(grid::convertHeight(tableau_grob$heights, "in", valueOnly = TRUE))

  # On ajoute une toute petite marge de sécurité (0.1 pouce) pour ne pas couper les bords
  ggplot2::ggsave(
    filename = nom_fichier,
    plot = tableau_grob,
    width = w + 0.1,
    height = h + 0.1,
    dpi = 300,
    bg = "white"
  )

  message("Tableau généré")
}
