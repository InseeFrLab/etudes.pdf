# chartegraphique.sser

## 📋 Présentation

`chartegraphique.sser` est un package R qui permet la création de publications InfosRapidesJustice
au format PDF conformes à la charte graphique du SSER (SSM Justice).

Il permet de :

- 📄 Générer rapidement un modèle de publication InfoRapideJustice directement éditable en PDF
- 🎨 Ajuster la mise en page de la publication avec des commandes de maquettage
- 📊 Construire des graphiques conformes à la charte SSER


## 🚀 Installation

Lancez la commande suivante pour installer le package `chartegraphique.sser`:

``` r

devtools::install_gitlab(repo="douxvalkyn/etudes-pdf",
                        host="https://gitlab.com",
                        dependencies = TRUE,
                        upgrade = FALSE)
```



## Utilisation d'un document .qmd au lieu d'un document .rmd

Il est possible d'utiliser un document initial au format .qmd . Cela necessite les ajustements principaux suivants:

- inst/inforap_template/resources: ce dossier doit contenir toutes les ressources utiles (css, template html pandoc, images, lua, polices, ainsi que le js de pagedjs, qui remplace l'utilisation du package pagedown).
- inst/inforap_template/_extension.yml: ce fichier décrit tous les éléments, variables, ressources qui seront nécessaires pour le rendu pdf.
- R/install_quarto_extension.R: ce script permet d'installer une extension quarto à partir de ce package. L'extension permettra de produire un document dans un format spécifique html paginé.
- le template pandoc `template_IRJ_paged_pdf_qmd` a été adapté legerement.
- le yml du fichier initial (au format .qmd) est legerement modifié.