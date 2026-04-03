# etudes.pdf

## 📋 Présentation

`etudes.pdf` est un package R qui permet la création de publications
**Insee Flash Pays de la Loire** ou **Insee Analyses Pays de la
Loire**au format **PDF** conformes à la charte graphique de l’Insee.

<https://www.insee.fr/fr/statistiques?debut=0&categorie=2&collection=109>

## 🚀 Installation

- Lancez la commande suivante pour installer le package `etudes.pdf`:

``` r
remotes::install_github("https://github.com/InseeFrLab/etudes.pdf")
```

- Lancer la fonction `install_if_typst()` pour installer l’extension
  typst dédiée aux Insee Flash ou `install_ia_typst()` pour installer
  l’extension typst des Insee Analyses: un dossier \_extensions est
  créé.

- déplacer le fichier modèle `if157.qmd` ou `ia144.qmd`du dossier
  \_extensions/if ou \_extensions/ia vers la racine puis lancer
  `quarto render if157.qmd` ou `quarto render ia144.qmd`pour générer le
  pdf.

- modifier le fichier `if157.qmd` ou `ia144.qmd`en fonction de vos
  besoins et lancer `quarto render if157.qmd` ou
  `quarto render ia144.qmd`pour régenerer le pdf.

## Commandes utiles pour le developpeur:

- [`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
- [`devtools::check()`](https://devtools.r-lib.org/reference/check.html)
- [`devtools::install()`](https://devtools.r-lib.org/reference/install.html)
  ou
  [`devtools::build()`](https://devtools.r-lib.org/reference/build.html)
- `detach("package:etudes.pdf", unload = TRUE)`

## Différents moyens de faire le triangle:

- blabla figure 2  
- blabla figure 2  (necessite ceci: \#import
  “@preview/fontawesome:0.5.0”: \*)
- \#let appel-fleche(corps) = { box( width: 0.8em, height: 0.8em, {
  place(center + horizon, polygon( fill: B6, (0%, 0%), // Point haut
  gauche (100%, 50%),// Pointe (milieu droite) (0%, 100%) // Point bas
  gauche ) ) } ) h(0.4em) corps }

et dans le qmd:

`{=typst} blabla devant #appel-fleche[figure 3]`

## Pour conserver le .typ généré avant le .pdf

Mettre ceci comme format dans le yml du fichier qmd: format:
`insee-flash-typst: keep-typ: true`

### Exemple de tableau à 1 colonne :

mfig( pos: bottom + right, largeur: 50%, dx: 0mm, dy: 0mm, width-image:
100%, pad-bottom: 0mm, pad-top: 4mm, pad-left: 2mm, pad-right: 0mm,
titre: “1. Un titre sur une seule ligne”, lecture: “Une note de lecture
sur une seule ligne.”, source: “Insee, 2026.”, “insee_1col.png” )

### Exemple de tableau à 2 colonnes:

mfig( pos: bottom, largeur: 100%, dx: 0mm, dy: 0mm, width-image: 100%,
pad-bottom: 0mm, pad-top: 4mm, pad-left: 2mm, pad-right: 0mm, titre: “1.
Un titre sur une seule ligne”, lecture: “Une note de lecture sur une
seule ligne.”, source: “Insee, 2026.”, “insee_2cols.png” )

L’image du tableau est fabriquée avec cette fonction:
etudes.pdf::generer_tableau_insee(n_lignes = 20, format_colonnes = 1,
nom_fichier = “insee_1col.png”)

## Gestion fine des espacements:

Ajouter un espace insécable dans le texte du content\[\]: `~`

Ajouter un espace insécable dans le chapo: `\u202f`

Modifier l’espace entre 2 mots (par défaut entre 0.25 et 0.33em), dans
le texte du content\[\]: `La population#h(0.15em)ligérienne`

Faire un saut de colonne dans le texte du content\[\]:

`]`

`colbreak()`

`content[`
