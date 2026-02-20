// *****************************************************************************
// ***********************     TEMPLATE INSEE FLASH     ************************
// *****************************************************************************


// =============================================================================
// VARIABLES 
// =============================================================================

#let B4 = rgb("#248BFF")
#let B6 = rgb("#145CBF")
#let B8 = rgb("#042F80")
#let R3 = rgb("#FF848A")

#let gris = rgb("#f2f2f2")
#let bleu-clair = rgb("#f0faff")
#let blocSources = rgb("#FFF8E5")



// =============================================================================
// HELPERS INTERNES
// =============================================================================

// Fonction pour le point median INSEE.
// Valeur par défaut : dy = -1.7em (point final).
#let pt-insee(dy: -1.7em) = h(0.2em) + box(height: 0pt, width: 0.5em, {
  move(
    dy: dy,
    text(fill: R3, weight: "bold", size: 28pt)[#sym.dot.c]
  )
})

// Triangle décoratif des titres de niveau 2.
#let mytriangle(b, s) = box(
  baseline: b, text(size: s)[#sym.triangle.filled.r]
)

// Heading niveau 2 pour les blocs 
#let _heading2-bloc(it) = {
  set text(fill: B6, size: 9pt, weight: "bold")
  block(above: 1.5em, below: 1em)[
    #mytriangle(-0.1em, 12pt)
    #h(0.3em)#it.body
  ]
}

// Réinitialise la couleur du gras à noir (usage : à l'intérieur des blocs
// encadrés pour ne pas hériter du gras bleu du corps principal).
#let _strong-noir(it) = text(fill: black, weight: "bold", it.body)


// =============================================================================
// FONCTION PRINCIPALE
// =============================================================================

#let insee(
  title: none,
  collection: none,
  numero: none,
  date_publication: none,
  chapeau: none,
  logo_insee_header: none,
  logo_x: none,
  tetiere: none,
  qrcode: none,
  auteurs: none,
  surtitre: none,
  footer-from: 2,
  body
) = {

  // --- CONFIGURATION DE LA PAGE et du FOOTER ---
set page(
    paper: "a4",
    margin: (x: 15mm, y:  15mm),
    footer: context {
      let page_num = counter(page).get().at(0)
      if page_num >= footer-from {
      show strong: _strong-noir

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

        [*Bureau de presse :* \
        02 40 41 75 89 \

        ISSN 2275 – 9808 \
        © Insee Pays de la Loire],

        [#link("www.insee.fr")[www.insee.fr]\
        #box(baseline: 2mm, image(logo_x)) #h(2pt) #link("https://twitter.com/InseePdL")[\@Insee]],

        [#if qrcode != none and qrcode != "" {
          image(qrcode) 
        } else {
          [qrcode]
        }],

        image(logo_insee_header, height: 0.8cm)
      )
  }
      set text(size: 6pt, font: "Open Sans")
  }
 ) // fin set page


  // taille et police du corps de texte
  set text(font: "Open Sans", lang: "fr", size: 8pt)



   // --- FIGURES ---
  show figure: set figure(supplement: none, numbering: none)
  show figure: it => {
    set text(size: 6pt)
    set align(left)
    show strong: _strong-noir
    it
  }


// --- TITRES ---
  show heading.where(level: 1): it => {
    set text(fill: B6, size: 9pt, weight: "bold")
    block(above: 2em, below: 1.2em)[#it.body]
  }
  show heading.where(level: 2): it => {
    set text(fill: B6, size: 9pt, weight: "bold")
    block(above: 1.5em, below: 1em,
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.3em,
        pad(top: -2pt, text(size: 12pt)[#sym.triangle.filled.r]),
        par(hanging-indent: 1em, it.body),
      )
    )
  }

  show strong: it => text(fill: blue, weight: "bold", it.body)

   // Intercepte le triangle Unicode ▶ écrit directement dans le texte
  show "▶︎": mytriangle(0em,12pt)


  // --- EN-TÊTE  ---
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
    #set text(size: 12pt, weight: "regular", fill:B6 )
    #block(below: 3.5mm,surtitre)
    #set text(weight: "extrabold", size: 19pt, fill:black)
    #block(title)
  ]
  ]
  )

  v(12mm) // Espace vertical de 12mm

  // --- BANDEAU BLEU  ---
  stack(spacing: 0pt)[
    #move(dx: -15mm)[
      #block(
        fill: B8,
        width: 100% + 30mm,
        height: 15mm,
        inset: (x: 15mm),
        spacing: 0pt, //  Supprime la marge propre au bloc
      )[
        #align(right + horizon)[
          #set text(fill: R3, weight: "bold", size: 12pt)
          #collection #pt-insee(dy: -0.3em) n° #numero #pt-insee(dy: -0.3em) #date_publication
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

  // --- CHAPEAU
  grid(
    align(top)[
      #set text(weight: "bold", size: 10pt)
      #chapeau
    ],
  )


  v(13mm)

  // --- CORPS DE TEXTE (2 COLONNES) ---
  show: columns.with(2,  gutter: 5mm)

  // --- TEXTE ---
  body 


} // fin de la fonction principale


// =============================================================================
// FONCTIONS DE BLOCS
// =============================================================================

//Encadre
#let encadre(corps) = block(
  width: 100%,
  inset: 5pt,
  radius: 0pt,
  stroke: 2pt + R3,
  spacing: 1.2em,
)[
  #show strong: _strong-noir
  #show heading.where(level: 2): _heading2-bloc
  #set text(size: 7pt, weight: "regular")
  #corps
]

//Definitions
#let definitions(corps) = block(
  fill: gris,
  width: 100%,
  inset: 5pt,
  radius: 0pt,
  spacing: 1.2em,
)[
  #show strong: _strong-noir
  #show heading.where(level: 2): _heading2-bloc
  #set text(size: 7pt, weight: "regular")
  #corps
]

//Pour en savoir plus
#let pour-en-savoir-plus(corps) = block(
  fill: bleu-clair,
  width: 100%,
  inset: 5pt,
  radius: 0pt,
  spacing: 1.2em,
)[
  #show strong: _strong-noir
  #show heading.where(level: 2): _heading2-bloc
  #set text(size: 7pt, weight: "regular")
  #set list(marker: text(fill: red, size: 0.8em)[#sym.circle.filled])
  #show link: set text(fill: blue)
  #show link: underline
  #corps
]

// Bloc Sources 
#let sources(corps) = block(
  fill: blocSources,
  width: 100%,
  inset: 5pt,
  radius: 0pt,
  spacing: 1.2em,
)[
  #show strong: _strong-noir
  #set text(size: 7pt, weight: "regular")
  #corps
]

// Auteurs
#let signature(auteurs: none) = {
  show strong: _strong-noir
  if auteurs != none {
    v(1em)
    block(width: 100%, breakable: false)[
      #set text(size: 8pt, weight: "semibold", fill: B4)
      #auteurs
    ]
    v(1em)
  }
}