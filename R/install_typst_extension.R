use_inforap_typst <- function() {
  # On pointe vers le dossier parent qui contient TOUT
  source_dir <- system.file("inforap", package = "chartegraphique.sser")
  
  if (source_dir == "") stop("Source introuvable dans le package.")

  dest_dir <- "_extensions/inforap"
  
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # On copie TOUT le contenu (yml + dossier resources)
  file.copy(list.files(source_dir, full.names = TRUE), 
            dest_dir, 
            recursive = TRUE, 
            overwrite = TRUE)
  
  message("Extension et ressources installées dans _extensions/inforap")
}