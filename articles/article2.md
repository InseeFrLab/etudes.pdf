# Documentation avancée

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
