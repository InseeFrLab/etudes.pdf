# etudes.pdf

## 📋 Présentation

`etudes.pdf` est un package R qui permet la création de publications **Insee Flash Pays de la Loire** au format **PDF** conformes à la charte graphique de l'Insee.

https://www.insee.fr/fr/statistiques?debut=0&categorie=2&collection=109


## 🚀 Installation

-   Lancez la commande suivante pour installer le package `etudes.pdf`:

``` r
remotes::install_github("https://github.com/InseeFrLab/etudes.pdf")
```

-   Lancer la fonction `etudes.pdf::use_insee_typst()` pour installer l'extension typst de l'Insee: un dossier \_extensions est créé.

-   déplacer le fichier modèle `if157.qmd` du dossier \_extensions/insee vers la racine puis lancer `quarto render if157.qmd` pour générer le pdf.

-   modifier le fichier `if157.qmd` en fonction de vos besoins et lancer `quarto render if157.qmd` pour reafficher le pdf.

## Commandes utiles pour le developpeur:

-   `devtools::document()`
-   `devtools::check()`
-   `devtools::install()` ou `devtools::build()`
-   `detach("package:etudes.pdf", unload = TRUE)`

## Différents moyens de faire le triangle:

-   blabla `#box(text(size: 7.5pt, font: "DejaVu Sans")[▶])`{=typst} figure 2\
-   blabla `#box(text(size: 6pt)[#fa-icon("play")])`{=typst} figure 2  (necessite ceci: #import "@preview/fontawesome:0.5.0": \*)
-   #let appel-fleche(corps) = { box( width: 0.8em, height: 0.8em, { place(center + horizon, polygon( fill: B6, (0%, 0%), // Point haut gauche (100%, 50%),// Pointe (milieu droite) (0%, 100%) // Point bas gauche ) ) } ) h(0.4em) corps }

et dans le qmd:

```{=typst}
blabla devant #appel-fleche[figure 3]```