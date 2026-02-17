# -------------------------------
# FONCTIONS COULEURS
# -------------------------------



#' Afficher une grille de couleurs
#'
#' La fonction \code{display_colors} génère et affiche une grille de couleurs à partir d'un vecteur de couleurs nommées.
#' Chaque couleur est représentée par un carré dans une grille, avec le nom de la couleur affiché en dessous.
#'
#' @param colorVector Un vecteur nommé de couleurs. Les noms des éléments du vecteur sont utilisés comme étiquettes dans la grille.
#'
#' @return Un graphique ggplot affichant la grille de couleurs.
#'
#' @examples
#' # Exemple d'utilisation de la fonction display_colors
#' library(chartegraphique.sser)
#' couleurs <- c("rouge" = "#FF0000", "vert" = "#00FF00", "bleu" = "#0000FF")
#' chartegraphique.sser:::display_colors(couleurs)
#'
#' @import ggplot2 dplyr
display_colors <- function(colorVector){


  if(is.null(names(colorVector))){
    nameColor <- colorVector
  }else{
    nameColor <- names(colorVector)
  }

  colorDf <- data.frame(
    nom = nameColor,
    couleur = colorVector
  )

  # Calculer le nombre de lignes et de colonnes
  n <- nrow(colorDf)
  colonnes <- ceiling(sqrt(n))
  lignes <- ceiling(n / colonnes)

  # Ajouter des colonnes pour les positions dans la grille
  colorDf <- colorDf %>%
    mutate(ligne = rep(lignes:1, each = colonnes)[1:n],
           colonne = rep(1:colonnes, times = lignes)[1:n])

  ggp <- ggplot(colorDf, aes(x = colonne, y = ligne)) +
    geom_tile(aes(fill = couleur), color = "white", size = 2, width = 0.8, height = 0.8) +
    scale_fill_identity() +
    geom_text(aes(label = couleur), y = colorDf$ligne - 0.15, size = 2.5, vjust = 1) +
    geom_text(aes(label = nom), y = colorDf$ligne - 0.4, size = 3.5, vjust = 1) +
    theme_void() +
    theme(
      legend.position = "none",
      aspect.ratio = 1
    ) +
    labs(x = NULL, y = NULL)

  print(ggp)

}


#' Convertit un code hexadécimal avec transparence (8 caractères) en code hexadécimal standard (6 caractères)
#'
#' Cette fonction prend un code couleur hexadécimal au format `#RRGGBBAA` (avec canal alpha)
#' et le convertit en un code `#RRGGBB` équivalent, en simulant la fusion avec un arrière-plan
#' spécifié (par défaut blanc). La conversion suit le modèle de mélange alpha standard.
#'
#' @param hex_alpha Chaîne de caractères au format `#RRGGBBAA` (ex: `"#80FF00CC"`).
#' @param bg_hex Chaîne de caractères au format `#RRGGBB` représentant la couleur d'arrière-plan
#'               (par défaut `"#FFFFFF"` pour blanc).
#'
#' @return Une chaîne de caractères au format `#RRGGBB`.
#'
#' @examples
#' # Fusion avec fond blanc (défaut)
#' \dontrun{
#' library(chartegraphique.sser)
#' hex_alpha_to_rgb("#80FF00CC")  # Résultat: "#99FF33"
#'
#' # Fusion avec fond gris clair
#' hex_alpha_to_rgb("#80FF00CC", "#DDDDDD")  # Résultat: "#8EEB2E"
#'
#' # Gestion des erreurs
#' try(hex_alpha_to_rgb("#1234567"))  # Erreur: format invalide
#' }
#' @note
#' - Si `hex_alpha` est déjà opaque (`AA = "FF"`), la couleur retournée est identique à `#RRGGBB`.
#' - Si `hex_alpha` est totalement transparent (`AA = "00"`), la couleur retournée est `bg_hex`.
#' - Les valeurs sont arrondies mathématiquement pour éviter les artefacts visuels.
hex_alpha_to_rgb <- function(hex_alpha, bg_hex = "#FFFFFF") {
  # Vérification du format d'entrée
  if (!grepl("^#[0-9A-Fa-f]{8}$", hex_alpha)) {
    stop("Format invalide. Utilisez #RRGGBBAA (ex: #80FF00CC)")
  }

  # Extraction des composantes
  r <- strtoi(substr(hex_alpha, 2, 3), 16L)
  g <- strtoi(substr(hex_alpha, 4, 5), 16L)
  b <- strtoi(substr(hex_alpha, 6, 7), 16L)
  a <- strtoi(substr(hex_alpha, 8, 9), 16L) / 255

  # Extraction de l'arrière-plan
  bg_r <- strtoi(substr(bg_hex, 2, 3), 16L)
  bg_g <- strtoi(substr(bg_hex, 4, 5), 16L)
  bg_b <- strtoi(substr(bg_hex, 6, 7), 16L)

  # Calcul des nouvelles couleurs
  new_r <- round(r * a + bg_r * (1 - a))
  new_g <- round(g * a + bg_g * (1 - a))
  new_b <- round(b * a + bg_b * (1 - a))

  # Conversion en hexadécimal
  sprintf("#%02X%02X%02X", new_r, new_g, new_b)
}

#' Récupérer ou afficher les couleurs de la charte graphique du SSER.
#'
#' La fonction \code{colors_sser} permet de récupérer les codes couleurs de la charte graphique du SSER.
#' Si aucun argument n'est renseigné, la fonction affiche la grille complete des couleurs disponibles.
#'
#' @param ... Un vecteur de charactère contenant le nom  des couleurs à
#' retourner ou une liste enumérée des couleurs à renvoyer (voir exemples).
#' Si l'input est un vecteur \strong{nommé}, alors le nom est conservé dans le vecteur retourné.
#'
#' @return Un vecteur de couleurs. Le vecteur retourné conserve les noms si l'input est nommé.
#'
#' @examples
#' library(ggplot2)
#' library(chartegraphique.sser)
#' # Afficher toutes les couleurs de la palette SSER
#' colors_sser()
#'
#' # Récupérer les couleurs G1, E1 et P4 :
#' colors_sser("G1", "E1", "P4")
#' colors_sser(c("G1", "E1", "P4"))
#'
#' # Utilisation d'un vecteur nommé :
#' mes_couleurs_par_annees <- c("annee_2022" = "G1", "annee_2023" = "P1")
#' colors_sser(mes_couleurs_par_annees)
#'
#' # appliquer une couleur sur un graphique :
#' ggplot(mpg, aes(x = class)) +
#'   geom_bar(fill=colors_sser("P1"))
#'
#' @import colorspace dplyr ggplot2
#' @export
colors_sser <- function(...) {

  colors <- NULL
  # construction de la palette de base avec les couleurs de l'état
  # vect_col1 <- c(
  #   "#958B62", "#91AE4F", "#169B62", "#466964", "#00AC8C", "#5770BE",
  #   "#484D7A", "#FF8D7E", "#D08A77", "#FFC29E", "#FFE800", "#FDCF41",
  #   "#FF9940", "#E18B63", "#FF6F4C", "#7D4E5B", "#A26859", "#000000"
  # )
  #
  # vect_col0 <- colorspace::darken(vect_col1, amount = 0.1, method = "relative")
  # vect_col2 <- colorspace::lighten(vect_col1, amount = 0.5, method = "relative")
  # vect_col3 <- colorspace::lighten(vect_col1, amount = 0.75, method = "relative")
  # vect_col4 <- colorspace::lighten(vect_col1, amount = 0.9, method = "relative")
  #
  # names(vect_col0) <- paste0(letters[1:18], "0")
  # names(vect_col1) <- paste0(letters[1:18], "1")
  # names(vect_col2) <- paste0(letters[1:18], "2")
  # names(vect_col3) <- paste0(letters[1:18], "3")
  # names(vect_col4) <- paste0(letters[1:18], "4")

  # vecteur
  # colors <-
  #   c(vect_col0, vect_col1, vect_col2, vect_col3, vect_col4)

  # ajout des palettes relatives aux différentes collections du SSER
  # A modifier si besoin
  # colors <- c(colors,
  #                           "vert_fonce"   = "#00AC8C",
  #                           "vert_moyen"   = "#83D2C1",
  #                           "vert_clair"   = "#BCE4DB",
  #                           "bleu_fonce"   = "#484D7A",
  #                           "bleu_moyen"   = "#7788C3",
  #                           "bleu_clair"   = "#B4B9DE",
  #                           "orange_fonce" = "#ED6E51",
  #                           "orange_moyen" = "#F8BCA6",
  #                           "orange_clair" = "#FCDFD3",
  #                           "prune"        = "#7D4E5B"
  # )

  colorsIRJ <- c("G1"="#484D7A",
                 "F1"="#5770BE",
                 "E1"="#00AC8C",
                 "O1"="#FF6F4C",
                 "P1"="#7D4E5B")

  colors <- c(colorsIRJ,
              setNames(sapply(alpha(colorsIRJ, alpha = 0.5),hex_alpha_to_rgb), c("G2", "F2", "E2", "O2", "P2")),
              setNames(sapply(alpha(colorsIRJ, alpha = 0.25),hex_alpha_to_rgb), c("G3", "F3", "E3", "O3", "P3")),
              setNames(sapply(alpha(colorsIRJ, alpha = 0.1),hex_alpha_to_rgb), c("G4", "F4", "E4", "O4", "P4")))

  # colors <- c(colors,
  #             "G1"="#484D7A",
  #             "G2" = scales::alpha("#484D7A",alpha = 0.5),
  #             "G3" = scales::alpha("#484D7A",alpha = 0.25),
  #             "G4" = scales::alpha("#484D7A",alpha = 0.1)
  #             )
  #
  # colors <- c(colors,
  #             "F1"="#5770BE",
  #             "F2" = scales::alpha("#5770BE",alpha = 0.5),
  #             "F3" = scales::alpha("#5770BE",alpha = 0.25),
  #             "F4" = scales::alpha("#5770BE",alpha = 0.1)
  # )
  #
  # colors <- c(colors,
  #             "E1"="#00AC8C",
  #             "E2" = scales::alpha("#00AC8C",alpha = 0.5),
  #             "E3" = scales::alpha("#00AC8C",alpha = 0.25),
  #             "E4" = scales::alpha("#00AC8C",alpha = 0.1)
  # )
  #
  # colors <- c(colors,
  #             "O1"="#FF6F4C",
  #             "O2" = scales::alpha("#FF6F4C",alpha = 0.5),
  #             "O3" = scales::alpha("#FF6F4C",alpha = 0.25),
  #             "O4" = scales::alpha("#FF6F4C",alpha = 0.1)
  # )
  #
  # colors <- c(colors,
  #             "P1"="#7D4E5B",
  #             "P2" = scales::alpha("#7D4E5B",alpha = 0.5),
  #             "P3" = scales::alpha("#7D4E5B",alpha = 0.25),
  #             "P4" = scales::alpha("#7D4E5B",alpha = 0.1)
  # )


  ## Ajout couleurs supplémentaire noir et gris
  # colors <- c(colors,
  #                           "noir" = "#000000",
  #                           "gris" = "#777777")


  cols <- c(...)

  if (is.null(cols)){

    display_colors(colors)

    return (colors)

  }else{
    res <- colors[cols]
    if(!is.null(names(cols))){
      names(res) <- names(cols)
    }else{
      names(res) <- NULL
    }

    return(res)
  }

}

