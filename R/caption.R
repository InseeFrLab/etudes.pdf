#' Construire une légende formatée
#'
#' Cette fonction génère une légende formatée en HTML à partir de divers champs d'entrée.
#' Elle divise les chaînes de caractères en segments de longueur spécifiée pour un affichage
#' optimal.
#'
#' @param ... Liste de paires nom-valeur supplémentaires à inclure dans la légende.
#' @param nCharByRow Nombre maximal de caractères par ligne pour le formatage (par défaut 70).
#'
#' @return Une chaîne de caractères formatée en HTML représentant la légende.
#'
#' @examples
#' # Exemple d'utilisation de la fonction buildCaption
#' \dontrun{
#' library(ggplot2)
#' myCaption <- build_caption(Source="SSER",
#'                            Champ="France métropolitaine",
#'                            Lecture="Indication pour aider à la lecture du graphique. Ce texte s'il est trés long sera tronqué aprés nCharByRow charactères pour aller sur une 2eme ligne")
#' ggplot(mpg, aes(x = class, fill = drv)) +
#'   geom_bar() +
#'   scale_fill_manual(values = colors_sser("G1","P1","E1")) +
#'   theme_sser()+
#'   labs(caption = myCaption)
#' }
#'
#'
#' @export
build_caption <- function(..., nCharByRow=70){

  dots <- list(...)
  if(length(dots)==0L){
    stop("Aucun paramètres renseignés")
  }

  splitStringNmax <- function(texte, N) {
    if (N < 1) {
      stop("N doit être un entier positif")
    }

    if (nchar(texte) == 0) {
      return(character(0))
    }

    words <- strsplit(texte, " ")[[1]]
    cumulativeNchar <- cumsum(1+sapply(words,nchar,USE.NAMES = FALSE))-1
    breaksInterval <- seq(from=0,to=nchar(texte)+1,by=N)

    intervals <- findInterval(cumulativeNchar,breaksInterval,rightmost.closed = T)

    splitListOfwords <- split(words, intervals)
    splitWords <-   unlist(lapply(splitListOfwords,paste0,collapse=" "),use.names = FALSE)


    return(splitWords)
  }


  if(!is.null(dots)){
    captions <- purrr::imap(dots,function(content,name){
      captionPart <- paste0(name," : ",content)
      captionPart_revamp  <- paste0(splitStringNmax(captionPart,N = nCharByRow),collapse= "<br>")
      captionPart_revamp <- gsub(name,paste0("<b>",name,"</b>"),x = captionPart_revamp)
    })
  }

  captions <- paste0(captions,collapse = "<br>")


  return(captions)

}


