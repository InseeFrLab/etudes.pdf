#' install_if_typst
#'
#' Prepare un fichier insee flash pdf à partir d'un fichier .qmd
#' @export
install_if_typst <- function() {
  # On pointe vers le dossier parent insee flash qui contient TOUT
  source_dir <- system.file("if", package = "etudes.pdf")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/if"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/if")
}



#' install_ia_typst
#'
#' Prepare un fichier insee analyses pdf à partir d'un fichier .qmd
#' @export
install_ia_typst <- function() {
  # On pointe vers le dossier parent insee analyses qui contient TOUT
  source_dir <- system.file("ia", package = "etudes.pdf")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/ia"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/ia")
}