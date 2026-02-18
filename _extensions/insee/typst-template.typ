// --- VARIABLES DE CHARTE (Issues de ton CSS) ---
#let color-primary = rgb("#042F80")   
#let color-secondary = rgb("#248BFF")  
#let color-tertiary = rgb("#FB5A5A") 
#let color-titre = rgb("#FF848A") 

#let blocDefinitions = rgb("#F6F6F6") 
#let blocEnSavoirPlus = rgb("#E1F3FF")
#let blocSources = rgb("#FFF8E5")

#let contourB1 = rgb("#B5E1FF")

#let puceR4 = rgb("#FA5A5A")
#let puceB6 = rgb("#145CBE")

#let auteur-state = state("auteur-state", none)
#let logo_state = state("logo_path", none)


#let pt_insee_titre(y) = box(height: 0pt, width: 0.5em, {
  move(
    dy: y, // Ajustez cette valeur pour le monter (-) ou le descendre (+)
    text(fill: color-titre, weight: "bold", size: 24pt)[#sym.dot.c]
  )
})



// --- Structure de la page ---
#let insee(
  title: none,
  collection: none,
  numero: none,
  date_publication: none,
  chapeau: none,
  logo_insee_header: none,
  tetiere: none,
  auteurs: none,
  surtitre: none,

  body


) = {
  // --- CONFIGURATION DE LA PAGE ---
set page(
    paper: "a4",
    margin: (x: 15mm, y:  15mm),
    footer: context {
      let page_num = counter(page).get().at(0)
      if page_num == 2 {
      let logo_path = logo_state.get()

  v(-15mm)  

  set text(size: 6pt, font: "Open Sans")
grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    gutter: 2mm,
    align: left + top,

    [*Insee Pays de la Loire* \
     105, rue des Français Libres \
     BP 67401 \
     44274 NANTES \
     Cedex 2],

    [*Directeur de la publication :* \
     Arnaud Degorre \
    \

     *Rédactrice en chef :* \
     Valérie Deroin],

    [Bureau de presse : \
     02 40 41 75 89 \

     ISSN 2275 – 9808 \
     © Insee Pays de la Loire],

   
    [#link("www.insee.fr")[www.insee.fr]\
    #link("https://twitter.com/InseePdL")[\@Insee]],

     [QRcode],

    image(logo_path, height: 0.8cm)
  )
  
    }
      set text(size: 6pt, font: "Open Sans")
      
     
    }
  )

  auteur-state.update(auteurs)
  logo_state.update(logo_insee_header)

  set text(font: "Open Sans", lang: "fr", size: 8pt)
  show figure: it => {
    set text(size: 6pt)
    set align(left)
    it
  }
  show figure: set figure(supplement: none, numbering: none)

  // --- EN-TÊTE (LOGO INSEE 47mm + TITRE) ---
  grid(
    columns: (47mm, 1fr),
    column-gutter: 9.6mm,
    // Zone Logo (Hauteur 25mm)
    box(height: 25mm, width: 47mm)[
      #align(bottom)[
      #image(logo_insee_header, width: 100%)
      ]
    ],
    // Zone Titre
box(height: 25mm, width: 100%)[
  #align(bottom)[
    #set text(size: 12pt, weight: "regular", fill:color-secondary )
    #block(below: 3.5mm,surtitre)
    #set text(weight: "extrabold", size: 19pt, fill:black)
    #block(title)
  ]
]
  )

  v(12mm) // Espace vertical de 12mm

  // --- BANDEAU BLEU  ---
// On regroupe les deux éléments dans un stack sans aucun espacement
  stack(spacing: 0pt)[
    #move(dx: -15mm)[
      #block(
        fill: color-primary,
        width: 100% + 30mm,
        height: 15mm,
        inset: (x: 15mm),
        spacing: 0pt, //  Supprime la marge propre au bloc
      )[
        #align(right + horizon)[
          #set text(fill: color-titre, weight: "bold", size: 12pt)
          #collection #pt_insee_titre(-0.3em) n° #numero #pt_insee_titre(-0.3em) #date_publication
        ]
      ]
    ]
  ][
    // --- TETIERE ---
    #block(height: 30mm, width: 100%, spacing: 0pt)[
      #move(dx: -15mm)[
        #image(tetiere, width: 210mm, height: 100%, fit: "cover")
      ]
    ]
  ]

  v(5mm)

  // --- ZONE CHAPEAU
  grid(
    align(top)[
      #set text(weight: "bold", size: 10pt)
      #chapeau
    ]
  )


  v(13mm)

  // --- CORPS DE TEXTE (2 COLONNES)  et TITRES---
  //  Style des titres avec le triangle bleu Insee
  show heading.where(level: 1): it => {
    set text(fill: color-secondary, size: 9pt, weight: "bold")
    block(above: 2em, below: 1.2em)[
      #it.body
    ]
  }

  show heading.where(level: 2): it => {
    set text(fill: color-secondary, size: 9pt, weight: "bold")
    block(above: 1.5em, below: 1em)[
      #sym.triangle.filled.r #it.body
    ]
  }

  show: columns.with(2,  gutter: 5mm)


  
  
  body 



} // fin de la fonction principale




// Fonction pour l'encadré
#let encadre(corps) = {
  block(
    width: 100%,
    inset: 5pt, //marge interieure = padding
    radius: 0pt, //angle des coins
    stroke: 2pt + color-titre, // Ajoute une bordure de 1pt de couleur rouge
    spacing: 1.2em, // marging, définit l'espace vide au dessus et en dessous du bloc
  )[
    #set text(size: 7pt, weight: "regular")
    #corps
  ]
} 

// Fonction pour bloc Définitions
#let definitions(corps) = {
  block(
    fill: blocDefinitions,
    width: 100%,
    inset: 5pt,
    radius: 0pt,
    spacing: 1.2em,
  )[
    #set text(size: 7pt, weight: "regular")
    #corps
  ]
}

// Fonction pour bloc Pour en savoir plus
#let pour-en-savoir-plus(corps) = {
  block(
    fill: blocEnSavoirPlus,
    width: 100%,
    inset: 5pt,
    radius: 0pt,
    spacing: 1.2em,
  )[
    #set text(size: 7pt, weight: "regular")
    #set list(marker: text(fill: red, size: 0.8em)[#sym.circle.filled])
    #show link: set text(fill: blue)
    #show link: underline
    #corps
  ]
}

// fonction auteurs
#let signature() = {
  context {
    let noms = auteur-state.get() //.get() récupère la valeur actuelle du state
    if noms != none {
      v(1em)
      block(width: 100%, breakable: false)[
        #set text(size: 8pt, weight: "semibold", fill: color-primary)
        #noms
      ]
      v(1em)
    }
  }
}

#let pt_insee = h(0.4em) + box(height: 0pt, width: 0.5em, {
  move(
    dy: -1.7em, // Ajustez cette valeur pour le monter (-) ou le descendre (+)
    text(fill: color-titre, weight: "bold", size: 28pt)[#sym.dot.c]
  )
})




