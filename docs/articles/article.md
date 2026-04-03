# Documentation de base

### Structure du fichier .qmd à modifier

Un document se compose de trois parties :

1.  **Métadonnées (YAML)**

Ces variables (sauf le format) sont à mettre à jour selon l’étude:

- title: “Titre de l’étude”
- collection: “Insee Flash Pays de la Loire”
- numero: “157”
- date_publication: “Septembre 2025”
- chapo: “Résumé de l’étude”
- chapo_taille: 12
- texte_taille: 8
- titre_taille: 9
- bloc_texte_taille: 7
- auteurs: “Nom Prénom (Insee)”
- surtitre: “SURTITRE”
- qrcode: “\_extensions/insee-flash/resources/images/qrcode.png”
- format: insee-flash-typst

2.  **Contenu (Typst)**

Le contenu est écrit dans un bloc et se compose de 2 grandes parties, le
texte et les figures/encadrés. Le texte est à mettre dans la balise
content\[\] tandis que les figures/encadrés sont à positionner plus bas.

``` typst
meander.reflow({
  import meander: *

  content[
    <<..texte de l'étude ici..>>
  ]

  // ── PAGE 1 ──
  <<..figures et encadrés de la page 1 ici..>>
  page_2colonnes()

  // ── PAGE 2 ──
  <<..figures et encadrés de la page 2 ici..>>
  page_2colonnes(saut: false)
})
```

### Rédiger le texte

= Titre niveau 1

\* **gras** *\**

### Ajouter une figure (sous forme d’image)

``` typst
myfig(
  pos: bottom + right, largeur: 49%, dx: 0mm, dy: 0mm, width-image: 100%,
  pad-bottom: 0mm, pad-top: 4mm, pad-left: 0mm, pad-right: 0mm,
  titre: "1. Nombre d’entrées pour 100 sorties et solde migratoire par région en 2022",
  lecture: "La Corse compte 166 arrivants pour 100 sortants au cours de l’année 2022. Son solde migratoire est égal à +2 700. En Île-de-France, le solde migratoire est de -135 300 habitants.",
  source: "Insee, Enquête annuelle de recensement 2023.",
  "_extensions/insee-flash/resources/images/if157_fig1.png"
)
```

Paramètres utiles:

- pos : position (top, bottom, left, right)
- largeur : largeur du bloc (mettre 49% afin de laisser suffisamment de
  places entre les deux colonnes)
- dx : ajustement horizontal
- dy : ajustement vertical

Sous le titre, il est possible d’ajouter un champ-libre, une note, une
lecture, un champ, une source. Le dernier paramètre de myfig() est le
chemin de l’image.

### Blocs disponibles

Encadré:

``` typst
#encadre[
== Titre
<<..texte..>>]
```

Définitions:

``` typst
#definitions[
== Titre
<<..texte..>>]
```

Pour en savoir plus:

``` typst
#pour-en-savoir-plus[
== Pour en savoir plus
- lien]
```

Sources:

``` typst
#sources[
== Titre
<<..texte..>>]
```

### Positionnement des blocs

Les blocs sont positionnés avec mybloc :

mybloc( pos: bottom + right, largeur: 49%, dy: -20mm )

\$\$ \#encadre\\ ... \$\$

Paramètres clés pos : position dans la page largeur : largeur dy :
décalage vertical dx : décalage horizontal

### Ajouter l’ours (footer)

\#ours() Hauteur fixe : 17 mm QR code automatique si défini dans le YAML
