# Documentation avancée

### Pour conserver le .typ généré avant le .pdf

Mettre ceci comme format dans le yml du fichier qmd: format:
`insee-flash-typst: keep-typ: true`

------------------------------------------------------------------------

### Exemple de tableau à 1 colonne :

``` typst
myfig( pos: bottom + right,
largeur: 50%, dx: 0mm, dy: 0mm, width-image: 100%, pad-bottom: 0mm, pad-top: 4mm, pad-left: 2mm, pad-right: 0mm,
titre: "1. Un titre sur une seule ligne",
lecture: "Une note de lecture sur une seule ligne.", source: "Insee, 2026.", "insee_1col.png" )
```

------------------------------------------------------------------------

### Exemple de tableau à 2 colonnes:

``` typst
myfig( pos: bottom,
largeur: 100%, dx: 0mm, dy: 0mm, width-image: 100%, pad-bottom: 0mm, pad-top: 4mm, pad-left: 2mm, pad-right: 0mm,
titre: "1. Un titre sur une seule ligne",
lecture: "Une note de lecture sur une seule ligne.",
source: "Insee, 2026.", "insee_2cols.png" )
```

L’image du tableau est fabriquée avec cette fonction:
etudes.pdf::generer_tableau_insee(n_lignes = 20, format_colonnes = 1,
nom_fichier = “insee_1col.png”)

------------------------------------------------------------------------

### Gestion fine des espacements:

Ajouter un espace insécable dans le texte du content\[\]: `~`

Ajouter un espace insécable dans le chapo: `\u202f`

Modifier l’espace entre 2 mots (par défaut entre 0.25 et 0.33em), dans
le texte du content\[\]: `La population#h(0.15em)ligérienne`

Faire un saut de colonne dans le texte du content\[\]:

``` typst
]
colbreak()
content[
```

------------------------------------------------------------------------

### Gestion de l’espacement à l’intérieur des encadrés

Par défaut, le leading (espace entre les lignes) et le spacing (espace
entre les paragraphes) sont définis par defaut à :

- spacing: 1.2em
- leading: 0.65em

Il est possible de surcharger ces valeurs en précisant les valeurs
souhaitées:

``` typst
#pour-en-savoir-plus(spacing: 1em,  leading: 0.5em)[
  == Pour en savoir plus

- *Coutard G., Morineau D.*, « #link("https://www.insee.fr/fr/statistiques/8627617")[Un tiers des habitants des Pays de la Loire ne sont pas nés dans la région]», Insee Flash Pays de la Loire n° 156, août 2025.
]
```

------------------------------------------------------------------------

### Exposants:

- chapo: caractere special d’exposant U1D49 pour le “e” et U02B3 pour le
  “r” Exemple: “quittent la région le 1ᵉʳ jour”

- dans le texte: “1er janvier 2026” s’écrit comme ceci: 1#super
  ``` math
  er
  ```
  janvier 2026

- dans les figures:

``` typst
myfig( pos: bottom + right, largeur: 49%, dx: 0mm, dy: 0mm, width-image: 100%,
titre: "1. Nombre d’entrées pour 100 sorties et solde migratoire par région le 1" + super("er") + " jour", lecture: "La Corse compte 166 arrivants pour 100 sortants au cours de l’année 2022. Son solde migratoire est égal à +2 700. En Île-de-France, le solde migratoire est de -135 300 habitants.",
source: "Insee, Enquête annuelle de recensement 2023.",
"_extensions/insee-flash/resources/images/if157_fig1.png" )
```

------------------------------------------------------------------------

### Différents moyens de faire le triangle:

- blabla figure 2
- blabla figure 2  (necessite ceci: \#import
  “@preview/fontawesome:0.5.0”: \*)
- \#let appel-fleche(corps) = { box( width: 0.8em, height: 0.8em, {
  place(center + horizon, polygon( fill: B6, (0%, 0%), // Point haut
  gauche (100%, 50%),// Pointe (milieu droite) (0%, 100%) // Point bas
  gauche ) ) } ) h(0.4em) corps }

et dans le qmd:

`{=typst} blabla devant #appel-fleche[figure 3]`
