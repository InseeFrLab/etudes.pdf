#' calibrage
#'
#' 
#' Calcule le nombre de caractères de chaque bloc de l'étude
#' @export
calibrage <-  function(file_path) {
  # Lecture du fichier
  text <- readChar(file_path, file.info(file_path)$size)
  
  # 1. Extraction des métadonnées YAML (Titre et Chapo)
  # On cherche ce qui est entre guillemets après la clé
  extract_yaml <- function(field, full_text) {
    pattern <- paste0(field, ':\\s*"([^"]+)"')
    match <- regexec(pattern, full_text)
    res <- regmatches(full_text, match)[[1]]
    if (length(res) > 1) return(res[2]) else return("")
  }
  
  titre_txt <- extract_yaml("title", text)
  # Pour le chapo, il peut être sur plusieurs lignes, on ajuste la regex
  chapo_pattern <- 'chapo:\\s*"((?:[^"\\\\]|\\\\.)*)"'
  chapo_match <- regmatches(text, regexec(chapo_pattern, text))[[1]]
  chapo_txt <- if(length(chapo_match) > 1) chapo_match[2] else ""

  # 2. Fonction Scanner optimisée pour les blocs Typst
  extract_typst_blocks <- function(tag, full_text) {
    found_blocks <- c()
    # On cherche "#tag[" ou "tag["
    starts <- gregexpr(paste0("(?m)(?:#)?", tag, "\\["), full_text, perl = TRUE)[[1]]
    
    if (starts[1] == -1) return(NULL)
    
    for (s in starts) {
      pos_start_content <- s + attr(starts, "match.length")[which(starts == s)]
      counter <- 1
      cursor <- pos_start_content
      text_len <- nchar(full_text)
      
      # Scanner de crochets
      while (counter > 0 && cursor <= text_len) {
        char <- substr(full_text, cursor, cursor)
        if (char == "[") counter <- counter + 1
        else if (char == "]") counter <- counter - 1
        cursor <- cursor + 1
      }
      found_blocks <- c(found_blocks, substr(full_text, pos_start_content, cursor - 2))
    }
    return(found_blocks)
  }

  # 3. Nettoyage commun
  clean_text <- function(x) {
    if (is.null(x) || length(x) == 0) return(0)
    x <- gsub("//.*?\n", " ", x)               # Commentaires
    x <- gsub("#[a-zA-Z0-9_-]+\\([^)]*\\)", " ", x) # Fonctions
    x <- gsub("\\s+", " ", x)                  # Espaces multiples
    return(sum(nchar(trimws(x))))
  }

  # 4. Calcul des différentes sections
  tags <- c("content", "encadre", "sources", "definitions", "pour-en-savoir-plus")
  
  # Calcul pour les blocs dynamiques
  results_blocks <- lapply(tags, function(t) {
    blocks <- extract_typst_blocks(t, text)
    data.frame(Section = t, Nb = length(blocks), Caracteres = clean_text(blocks))
  })
  df_blocks <- do.call(rbind, results_blocks)

  # Calcul pour le YAML
  df_yaml <- data.frame(
    Section = c("titre", "chapo"),
    Nb = c(1, 1),
    Caracteres = c(nchar(trimws(titre_txt)), nchar(trimws(chapo_txt)))
  )

  # Fusion et Total
  final_df <- rbind(df_yaml, df_blocks)
  total_row <- data.frame(
    Section = "TOTAL GÉNÉRAL",
    Nb = sum(final_df$Nb),
    Caracteres = sum(final_df$Caracteres)
  )
  
  return(rbind(final_df, total_row))
}



     