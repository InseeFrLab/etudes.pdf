// --- VARIABLES DE CHARTE (Issues de ton CSS) ---
#let color-primary = rgb(72, 77, 122)    // --color-primary
#let color-secondary = rgb(163, 166, 188)  // --color-secondary
#let color-tertiary = rgb(87, 112, 190)   // --color-tertiary
#let color-grey-bg = rgb("#f5f5f5")
#let color-grey-light = rgb("#ececec") 



#let inforap(
  title: none,
  date_publication: none,
  numero: none,
  auteur1: none,
  auteur2: none,
  maquette: "SSER",
  directeur_publication: none,
  redacteur_chef: none,
  pour_en_savoir_plus: none,
  page_web_justice: none,
  logo_sser_header: none,
  logo_fr_path: none,
  logo_download: none,         
  page_web_justice_url: none, 
  logo_sser_footer: none,
  body
) ={
  // --- CONFIGURATION GÉNÉRALE ---
  set page(
    paper: "a4",
    margin: (top: 40mm, bottom: 20mm, x: 20mm),
    
    header: context {
      if counter(page).get().at(0) == 1 {
        grid(
          columns: (1fr, 1fr),
          align(left + bottom)[#image(logo_fr_path, width: 35mm)],
          align(right + bottom)[#image(logo_sser_header, width: 30mm)]
        )
      }
    },

    footer: context {
      set text(size: 6pt, font: "Marianne")
      let page_num = counter(page).get().at(0)
      let is_last_page = page_num == counter(page).final().at(0)
      
      stack(
        spacing: 4mm,
        line(length: 100%, stroke: 0.35pt + black),



        // CONDITION 1 : DERNIÈRE PAGE (Prioritaire)
        if is_last_page {
          grid(
            columns: (1fr, 1fr),
            align: bottom,
            align(left)[Infos Rapides Justice #numero \ #date_publication],
            align(right)[SSER - Statistique publique \ de la justice],
          )
        }


        // CONDITION 2 : AUTRES PAGES IMPAIRES
        else if calc.odd(page_num) {
          // PAGE IMPAIRE : Uniquement le numéro de page à droite
          align(right)[#strong(str(page_num))]
        } else {
          // PAGE PAIRE : Structure complète (Numéro, Date, SSER)
          grid(
            columns: (10mm, 1fr, 1fr),
            align(left)[#strong(str(page_num))],
            align(left)[SSER - Statistique publique\  de la justice],
            align(right)[Infos Rapides Justice #numero \ #date_publication],
          )
        }
      )
    }
  )

  // --- TYPOGRAPHIE ---
  set text(font: "Marianne", size: 8pt, weight: 300, lang: "fr") 
  set par(justify: true, leading: 0.6em)
  
  show link: set text(fill: color-tertiary)
  show link: underline

  // --- TITRAGE ---

    block(
    fill: color-primary,
    width: 100%,
    inset: (left: 11pt, right: 11pt, y: 8pt),
    radius: 2mm,
    below: 2em
  )[
    #set text(fill: white, size: 16pt, weight: 400)
    #grid(
      columns: (1fr, auto),
      [Infos Rapides Justice],
      align(right)[#numero #sym.dot.c #date_publication]
    )
  ]


  block(width: 100%, above: 2em, below: 2em)[
    #set text(fill: color-primary, size: 22pt, weight: 700)
    #title
  ]

  block(width: 35mm, stroke: (top: 0.5pt + color-primary), inset: (top: 2mm), below: 8mm)[
    #set text(fill: color-primary, size: 8pt, weight: 400)
    *#auteur1* \
    *#auteur2*
  ]



  // --- RÈGLES DES TITRES ---
  show heading.where(level: 1): it => block(below: 0.5em, above: 1.2em)[
    #set text(fill: color-primary, size: 10pt, weight: 700)
    #it.body
  ]
  
  show heading.where(level: 2): it => block(below: 0.5em, above: 1em)[
    #set text(fill: color-primary, size: 8pt, weight: 700)
    #it.body
  ]

  // --- CORPS DE TEXTE ---
  show: columns.with(2, gutter: 8mm)

  body

  // --- SECTION FINALE (Ressources + Données + Editorial) ---
  // On place tout dans un seul 'place' pour que ce soit solidaire
  place(
    bottom,
    scope: "parent",
    float: true,
    block(width: 100%)[
      // 1. LES DEUX BLOCS
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 20pt,
        block(
          fill: rgb("#ececec"),
          inset: 10pt,
          radius: 10pt,
          width: 100%,
          [
            #set text(size: 8.5pt, weight: 700)
            Pour en savoir plus
            #v(4pt)
            #set text(size: 7.5pt, weight: 400)
            #pour_en_savoir_plus
          ]
        ),
        block(
          fill: color-secondary,
          inset: 10pt,
          radius: 10pt,
          width: 100%,
          [
            #set text(size: 8.5pt, weight: 700)
            Découvrez nos collections
            #v(4pt)
            #set text(size: 7.5pt, weight: 400)
            - Infos Rapides Justice
            - Infostat Justice
            - Dossier Méthode
            #v(4pt)
            #link("https://www.justice.gouv.fr/")[*Site Internet du SSER*]
          ]
        )
      )

      #v(20pt)

// 2. BANDEAU BLEU AVEC ICÔNE ET LIEN BLANC
      #block(
        fill: color-primary,
        width: 100%,
        inset: 10pt,
        radius: 10pt,
        [
          #grid(
            columns: (auto, 1fr), // L'image prend sa place, le texte le reste
            column-gutter: 15pt,
            align: horizon,      // Aligne l'icône et le texte verticalement au centre
            
            // L'IMAGE DE TÉLÉCHARGEMENT
            if logo_download != none { 
              image(logo_download, width: 12mm) 
            } else {
              // Si l'image n'est pas trouvée, on met un espace vide ou un placeholder
              square(size: 12mm, fill: none)
            },

            // LE TEXTE ET LE LIEN
            [
              #set text(fill: white, size: 8pt)
              Les données des figures associées à cette publication sont disponibles sur le site internet du SSER : \
              #set text(weight: 700)
              
              // On force la couleur blanche sur le lien spécifiquement
              #if page_web_justice_url != none { 
                link(page_web_justice_url)[#text(fill: white)[#page_web_justice]] 
              } else { 
                page_web_justice 
              }
            ]
          )
        ]
      )

      // Ce "ressort" va pousser tout ce qui suit vers le bas du bloc 'place'
      #v(1fr)

      // 3. PIED DE PAGE ÉDITORIAL
      #grid(
        columns: (1fr, auto),
        column-gutter: 10pt,
        align: bottom,
        text(size: 7pt)[
          Directeur de la publication : #directeur_publication \
          Rédacteur en chef : #redacteur_chef \
          #if maquette != none [Maquette : #maquette] \
          ISSN 1252-7556 ©Justice 2025
        ],
        image(logo_sser_footer, width: 25mm) 
      )
    ] // Ferme le block(width: 100%)
  ) // Ferme le place()
} // Ferme la fonction inforap (tout à la fin du fichier)




// --- COMPOSANTS SPÉCIFIQUES ---
//figure
#let figure_box(corps, caption: none) = {
  block(
    fill: color-grey-bg,
    inset: 10pt,
    radius: 2.5mm, // Correction ici
    width: 100%,
    stroke: 1pt + rgb("#f5f5f5"),
    [
      #corps
      #if caption != none {
        v(5pt)
        set text(size: 7pt)
        caption
      }
    ]
  )
}

// Encadré Source & Définitions (Bicolonne pleine largeur)
#let source_box(gauche, droite) = {
  place(
    bottom, 
    scope: "parent", 
    float: true, 
    // Le secret : clearance s'assure que le texte ne vient pas se coller
    clearance: 2em, 
    block(
      stroke: 1pt + color-primary,
      fill: white,
      inset: 15pt,
      radius: 2.5mm,
      width: 100%,
      [
        #set text(fill: color-primary, size: 14pt, weight: 700)
        Source et définitions
        #v(1em)
        #grid(
          columns: (1fr, 1fr),
          column-gutter: 25pt,
          align: top,
          [ #set text(fill: black, size: 8pt, weight: 300); #gauche ],
          [ #set text(fill: black, size: 8pt, weight: 300); #droite ]
        )
      ]
    )
  )
}


#let ressources_bloc(en_savoir_plus, collections) = {
  block(width: 100%, breakable: false, above: 30pt, [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 20pt,
      // Bloc "Pour en savoir plus"
      block(
        fill: rgb("#ececec"),
        inset: (x: 20pt, y: 10pt),
        radius: 10pt,
        width: 100%,
        height: 100%,
        [
          #set text(size: 8pt, weight: 400, line-height: 1.3em)
          #set list(marker: n_point => text(size: 0.6em, baseline: 0.25em)[•], indent: 0pt)
          #strong[Pour en savoir plus]
          #v(5pt)
          #en_savoir_plus
        ]
      ),
      // Bloc "Découvrez nos collections"
      block(
        fill: color-secondary, // Utilise votre variable --color-secondary
        inset: (x: 20pt, y: 10pt),
        radius: 10pt,
        width: 100%,
        height: 100%,
        [
          #set text(size: 8pt, weight: 400)
          #set list(marker: n_point => text(size: 0.6em, baseline: 0.25em)[•], indent: 0pt)
          #strong[Découvrez nos collections]
          #v(5pt)
          #collections
        ]
      )
    )
  ])
}
