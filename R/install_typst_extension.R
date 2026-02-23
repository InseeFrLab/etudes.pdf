#' use_insee_typst
#'
#' Prepare un fichier pdf à partir d'un fichier .qmd
#' @export
use_insee_typst <- function() {
  # On pointe vers le dossier parent qui contient TOUT
  source_dir <- system.file("insee", package = "etudes.pdf")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/insee"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/insee")
}