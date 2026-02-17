#' Create a template inforapide in HTML
#'
#' @return Un objet de format de sortie R Markdown à transmettre
#'   \code{rmarkdown::\link{render}()}.
#' @export
#'

inforap_html_pour_pdf <- function(...,dev=FALSE) {

  if(dev){
    fileLocation <- here::here("inst")
  }else{
    fileLocation <- system.file(package="chartegraphique.sser")
  }

  lua_filters <- c(
    file.path(fileLocation,"inforap-template","resources","lua","newcolumn.lua"),
    file.path(fileLocation,"inforap-template","resources","lua","addspace.lua")
  )

  cssList <- list(
    file.path(fileLocation,"inforap-template","resources","css","pdf", "style_IRJ_main_pdf.css")
  )

  templateFile <- file.path(fileLocation,"inforap-template","resources","html","template_IRJ_paged_pdf.html")

  logo_sser_footer  <- file.path(fileLocation,"inforap-template","resources", "images", "logo_sser_header.png")
  logo_sser_header     <- file.path(fileLocation,"inforap-template","resources", "images", "logo_sser_header.png")
  logo_fr_path_file  <- file.path(fileLocation,"inforap-template","resources", "images", "logo_republique_francaise.png")
  logo_download_file <- file.path(fileLocation,"inforap-template","resources", "images", "logo_download.png")


  pagedown::html_paged(
    ...,
    css = cssList,
    template = templateFile,
    extra_dependencies = list(fontawesome::fa_html_dependency()),
    number_sections = FALSE,
    pandoc_args = c(
      "--variable", paste0("logo_sser_footer:", logo_sser_footer),
      "--variable", paste0("logo_sser_header:", logo_sser_header),
      "--variable", paste0("logo_fr_path:",   logo_fr_path_file),
      "--variable", paste0("logo_download:",  logo_download_file),
      "--lua-filter", lua_filters[1],
      "--lua-filter", lua_filters[2]
    ),
   fig_width=7
  )
}

#' Create a template inforapide in HTML
#'
#' @return Un objet de format de sortie R Markdown à transmettre
#'   \code{rmarkdown::\link{render}()}.
#'

inforap_html <- function(...,dev=FALSE) {

  if(dev){
    fileLocation <- here::here("inst")
  }else{
    fileLocation <- system.file(package="chartegraphique.sser")
  }

  cssList <- list(
    file.path(fileLocation,"inforap-template","resources","css","style_IRJ_commun.css"),
    file.path(fileLocation,"inforap-template","resources","css","style_IRJ_html_specifique.css")
  )

  templateFile <- file.path(fileLocation,"inforap-template","resources","html","template_IRJ_html.html")

  logo_sp_path_file  <- file.path(fileLocation,"inforap-template","resources", "images", "logo_statistique_publique_texte.PNG")
  logo_sser_file     <- file.path(fileLocation,"inforap-template","resources", "images", "Logo_SSM_Justice_transparent.png")
  logo_fr_path_file  <- file.path(fileLocation,"inforap-template","resources", "images", "logo_republique_francaise.png")
  logo_download_file <- file.path(fileLocation,"inforap-template","resources", "images", "logo_download.png")

  rmarkdown::html_document(
    ...,
    css = cssList,
    template = templateFile,
    extra_dependencies = list(fontawesome::fa_html_dependency()),
    number_sections=FALSE,
    pandoc_args = c(
      "--variable", paste0("logo_sp_path:",   logo_sp_path_file),
      "--variable", paste0("logo_sser_path:", logo_sser_file),
      "--variable", paste0("logo_fr_path:",   logo_fr_path_file),
      "--variable", paste0("logo_download:",  logo_download_file)
    ),
    fig_width = 15
  )

}
