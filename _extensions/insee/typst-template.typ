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

  body


) = {
  // --- CONFIGURATION DE LA PAGE ---
  set page(
    paper: "a4",
    margin: (x: 15mm, y: 15mm),
    footer: context {
      let page_num = counter(page).get().at(0)
      let is_last_page = page_num == counter(page).final().at(0)
      set text(size: 6pt, font: "Open Sans")
      
      stack(
        spacing: 2mm,
        if is_last_page {
          grid(
            columns: (1fr, 1fr),
            align(left)[Derniere page]
          )
        }
      )
    }
  )

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
        #set text(weight: "bold", size: 19pt)
        #block(below: 0pt, title) // block below 0pt évite un saut de ligne parasite
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
          #collection #sym.dot.c n° #numero #sym.dot.c #date_publication
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

  // --- BLOC AUTEURS ---
  block(width:  100%, breakable: false)[
    #set text(size: 9pt, style: "italic")
    #auteurs
  ]
}

