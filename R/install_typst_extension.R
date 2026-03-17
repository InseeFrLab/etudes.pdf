#' install_insee_flash_typst
#'
#' Prepare un fichier insee flash pdf à partir d'un fichier .qmd
#' @export
install_insee_flash_typst <- function() {
  # On pointe vers le dossier parent insee flash qui contient TOUT
  source_dir <- system.file("insee-flash", package = "etudes.pdf")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/insee-flash"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/insee-flash")
}



#' install_insee_analyses_typst
#'
#' Prepare un fichier insee analyses pdf à partir d'un fichier .qmd
#' @export
install_insee_analyses_typst <- function() {
  # On pointe vers le dossier parent insee analyses qui contient TOUT
  source_dir <- system.file("insee-analyses", package = "etudes.pdf")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/insee-analyses"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/insee-analyses")
}