library(testthat)
library(yaml)
library(here)

# ==============================================================================
# 1. Tests structurels : Vérifier que l'arborescence et les ressources existent
# ==============================================================================

test_that("L'arborescence des extensions Insee est complète", {
  # --- Insee Analyses ---
  expect_true(dir.exists(here("inst/insee-analyses")))
  expect_true(file.exists(here("inst/insee-analyses/_extension.yml")))
  expect_true(dir.exists(here("inst/insee-analyses/resources")))
  expect_true(dir.exists(here("inst/insee-analyses/resources/images")))

  # Vérification des fichiers de template
  expect_true(file.exists(here("inst/insee-analyses/typst-template.typ")))
  expect_true(file.exists(here("inst/insee-analyses/typst-show.typ")))

  # Vérification des images (citations directes du contenu fourni)
  expect_true(file.exists(here(
    "inst/insee-analyses/resources/images/logoInseeFr.png"
  )))
  expect_true(file.exists(here(
    "inst/insee-analyses/resources/images/tetiere.png"
  )))
  expect_true(file.exists(here(
    "inst/insee-analyses/resources/images/logo_x.png"
  )))

  # --- Insee Flash ---
  expect_true(dir.exists(here("inst/insee-flash")))
  expect_true(file.exists(here("inst/insee-flash/_extension.yml")))
  expect_true(file.exists(here("inst/insee-flash/typst-template.typ")))
})


# ==============================================================================
# 2. Tests de métadonnées : Vérifier le contenu des _extension.yml
# ==============================================================================

test_that("Les métadonnées d'extension 'Insee Analyses' sont valides", {
  yml_path <- here("inst/insee-analyses/_extension.yml")
  yml <- yaml::read_yaml(yml_path)

  expect_equal(yml$title, "Insee Analyses Typst 3 colonnes")
  expect_equal(yml$author, "Insee")

  # Vérification de la structure de contribution
  expect_true("typst" %in% names(yml$contributes$formats))
  expect_true("template-partials" %in% names(yml$contributes$formats$typst))

  # Vérification des variables passées au template
  variables <- yml$contributes$formats$typst$variables
  expect_true("logo_insee_header" %in% names(variables))
  expect_true("tetiere" %in% names(variables))
})

test_that("Les métadonnées d'extension 'Insee Flash' sont valides", {
  yml_path <- here("inst/insee-flash/_extension.yml")
  yml <- yaml::read_yaml(yml_path)

  expect_equal(yml$title, "Insee Typst")
  expect_true("typst" %in% names(yml$contributes$formats))
})


# ==============================================================================
# 3. Tests de validation des fichiers Quarto (Frontmatter)
# ==============================================================================

test_that("Le fichier de démonstration IA144 contient un YAML valide", {
  # On lit le .qmd pour extraire et vérifier le frontmatter (sans le compiler)
  qmd_path <- here("inst/insee-analyses/ia144.qmd")
  qmd_content <- readLines(qmd_path, warn = FALSE)

  # Extraction basique du frontmatter (entre les ---)
  start <- which(qmd_content == "---")[1]
  end <- which(qmd_content == "---")[2]
  frontmatter <- qmd_content[(start + 1):(end - 1)]

  # On tente de parser le YAML du frontmatter
  yaml_data <- yaml::read_yaml(text = frontmatter)

  # Vérification des champs attendus
  expect_equal(
    yaml_data$title,
    "L’activité économique ligérienne consomme 4 400 hectares de 2011 à 2020"
  )
  expect_equal(yaml_data$collection, "Insee Analyses Pays de la Loire")
  expect_equal(yaml_data$numero, "144")
  expect_true(!is.null(yaml_data$qrcode))
})

test_that("Le fichier de démonstration IF157 contient un YAML valide", {
  qmd_path <- here("inst/insee-flash/if157.qmd")
  qmd_content <- readLines(qmd_path, warn = FALSE)

  start <- which(qmd_content == "---")[1]
  end <- which(qmd_content == "---")[2]
  frontmatter <- qmd_content[(start + 1):(end - 1)]

  yaml_data <- yaml::read_yaml(text = frontmatter)

  expect_equal(
    yaml_data$title,
    "L’attrait des Pays de la Loire montre des signes d’érosion"
  )
  expect_equal(yaml_data$collection, "Insee Flash Pays de la Loire")
})
