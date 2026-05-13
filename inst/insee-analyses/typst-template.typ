// *****************************************************************************
// ***********************     TEMPLATE INSEE ANALYSES     ************************
// *****************************************************************************

// =============================================================================
// VARIABLES 
// =============================================================================

#let B1 = rgb("#B5E1FF")
#let B4 = rgb("#248BFF")
#let B5 = rgb("#2674DD")
#let B6 = rgb("#145CBF")
#let B8 = rgb("#042F80")
#let R4 = rgb("#FB5A5A")
#let R1 = rgb("#FFE2E2")
#let G1 = rgb("#F2F2F2")


// =============================================================================
// HELPERS INTERNES
// =============================================================================

// Fonction pour le point median INSEE
// Valeur par défaut : dy = -1.7em (point final).
#let pt-insee(dy: -1.7em) = h(0.2em) + box(height: 0pt, width: 0.5em, {
  move(    dy: dy,    text(fill: R4, weight: "bold", size: 28pt)[#sym.dot.c]  )})

// Triangle décoratif des titres de niveau 2.
#let mytriangle(b, s) = box(  baseline: b, text(size: s)[#sym.triangle.filled.r])

// Heading niveau 2 pour les blocs 
#let _heading2-bloc(it) = {
  set text(fill: B6, size: 8pt, weight: "bold")
  block(above: 1.5em, below: 1em)[
    #mytriangle(-0.1em, 12pt)
    #h(0.3em)#it.body
  ]
}

// Réinitialise la couleur du gras à noir (usage : à l'intérieur des blocs
// encadrés pour ne pas hériter du gras bleu du corps principal).
#let _strong-noir(it) = text(fill: black, weight: "bold", it.body)

//taille du texte des blocs (insee -> blocs)
#let taille_bloc_state = state("taille_bloc", 7)

//donnees compl
#let _logo_donnees_compl = state("logo_donnees_compl", none)


// ═══════════════════════════════════════════
// MEANDER 
// ═══════════════════════════════════════════
#import "@preview/meander:0.4.1"

//un bloc positionné à 'top' aura une marge haute à 0 sinon 4mm (et de même pour bloc à 'bottom')
#let mybloc(pos: top + right, largeur: 66%, hauteur: auto, dx: 4pt, dy: 0pt,
            pad-top: 0mm, pad-bottom: 0mm, pad-left: 0mm, pad-right: 0mm, contenu) = {
  meander.placed(pos, dx: dx, dy: dy,
    pad(top: pad-top, bottom: pad-bottom, right: pad-right, left: pad-left,
      block(width: largeur, height: hauteur, contenu)
    )
  )
}

#let page_3_colonnes(saut: true) = {
  meander.container(align: left,width: 32%, margin: (right: 2.5mm))
  meander.container(align: center, width: 32%, margin: (x: 2.5mm))
  meander.container(align: right, width: 32%, margin: (left: 2.5mm))
    if saut { meander.pagebreak() }

}



#let page1_3colonnes(saut: true, avec-partenaire: false) = {
  let h = if avec-partenaire { 100% - 3.8cm } else { 100% }
  meander.container(align: left,   width: 32%, margin: (right: 2.5mm), height: h)
  meander.container(align: center, width: 32%, margin: (x: 2.5mm), height: h)
  meander.container(align: right,  width: 32%, margin: (left: 2.5mm), height: h)
  if saut { meander.pagebreak() }
}



// =============================================================================
// FONCTION PRINCIPALE
// =============================================================================

#let insee-analyses(
  title: none,
  collection: none,
  numero: none,
  date_publication: none,
  chapo: none,
  chapo_taille: none,
  texte_taille: none,
  titre_taille: none,
  bloc_texte_taille: none,
  logo_insee_header: none,
  logo_x: none,
  logo_donnees_compl: none,
  tetiere: none,
  qrcode: none,
  auteurs: none,
  surtitre: none,
  partenaire: none,
  logo_partenaire:none,
  body
) = {




  // --- CONFIGURATION DE LA PAGE et des FOOTER  ---
set page(
    paper: "a4",
    margin: (x: 15mm, y: 15mm,  top: 15mm, bottom: 15mm),

    // ── PAGE 1 : footer partenaire éventuel ─────────────────────
    footer: context {

     let page_num = counter(page).get().at(0)

      if page_num == 1 and (logo_partenaire != "" and partenaire != "") {
        v(-35mm)

        // ── ligne pointillés rouge bord à bord ──
        move(dx: -15mm,
          line(length: 210mm, stroke: (paint: R4, thickness: 2pt, dash: "loosely-dotted"))
        )
        
        // ── contenu : logo + texte ──
      box(height: 35mm, width: 100%)[
        #align(horizon)[
          #grid(
            columns: (20%, 1fr),
            column-gutter: 8mm,
            align: left , 
            // ── colonne gauche : label + logo ──
            stack(dir: ttb, spacing: 4pt,
              text(size: 7pt, weight: "bold")[En partenariat avec],
              v(4mm),
              if logo_partenaire != none { image(logo_partenaire, width: 80%) },
            ),
            // ── colonne droite : texte centré verticalement ──
            pad(left: 0pt)[#text(size: 7pt)[#partenaire]],
          )
        ]
      ]
      }


      // ── PAGE 2 : collection + titre + date à gauche ─────────
      if page_num == 2 {
        align(left)[
           #text(size: 6pt, fill: B6)[#collection • n°#numero • #date_publication]
        ]
      }

      // ── PAGE 3 : collection + titre + date à droite ─────────
      else if page_num == 3 {

        align(right)[
          #text(size: 6pt, fill: B6)[#collection • n°#numero • #date_publication]
        ]
      }

      // ── PAGE 4  ──────────────────────────────
      else if page_num == 4 {
        v(-20mm)
        show strong: _strong-noir
        grid(
          columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
          gutter: 2mm,
          align: left + top,
          [*Insee Pays de la Loire* \
          105, rue des Français Libres \
          BP 67401 \
          44274 NANTES Cedex 2],
          [*Directeur de la publication :* \
          Arnaud Degorre \
          \
          *Rédactrice en chef :* \
          Valérie Deroin],
          [*Bureau de presse :* \
          02 40 41 75 89 \
          ISSN 2275 – 9808 \
          © Insee Pays de la Loire],
          [#link("www.insee.fr")[www.insee.fr] \
          #box(baseline: 2mm, image(logo_x)) #h(2pt)
          #link("https://twitter.com/InseePdL")[\@Insee]],
          [#if qrcode != none and qrcode != "" {
            image(qrcode)
          } else { [qrcode] }],
          image(logo_insee_header, height: 0.8cm)
        )
      }
    }
  ) // fin set page




  // taille et police du corps de texte 
  set text(font: "Open Sans", lang: "fr", size: texte_taille * 1pt)
  taille_bloc_state.update(bloc_texte_taille)

  // Donnees complementaires
 _logo_donnees_compl.update(logo_donnees_compl)


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
    set text(fill: B6, size: titre_taille * 1pt, weight: "bold")
    block(above: 2em, below: 1.2em)[#it.body]
  }
  show heading.where(level: 2): it => {
    set text(fill: B6, size: titre_taille * 1pt, weight: "bold")
    block(above: 1.5em, below: 1em,
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.3em,
        pad(top: -2pt, text(size: 12pt)[#sym.triangle.filled.r]),
        par(hanging-indent: 1em, it.body),
      )
    )
  }
  show heading.where(level: 3): it => {
    set text(fill: B6, size: 7pt, weight: "bold")
    block(above: 2em, below: 1.2em)[#it.body]
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
      #image(logo_insee_header, width: 100%)
    ],
    // Zone Titre
   box(height: 25mm, width: 100%)[
    #set text(size: 12pt, weight: "regular", fill:B6 )
    #block(below: 4mm,surtitre)
    #set text(weight: "extrabold", size: 15pt, fill:black)
    #block(title)
  ]
  )

// --- BANDEAU BLEU ---
move(dx: -15mm)[
  #block(
    fill: B8,
    width: 100% + 30mm,
    height: 15mm,
    inset: (x: 15mm),
    spacing: 0pt,
  )[
    #align(right + horizon)[
      #text(fill: R4, weight: "bold", size: 12pt)[
      #collection #pt-insee(dy: -0.3em) n° #numero #pt-insee(dy: -0.3em) #date_publication
    ]
  ]
]
]

v(-3.5mm)
// --- TETIERE + CHAPO ---
grid(
  columns: (68mm, 1fr),
  rows: (68mm),

  // Tétière débordant dans la marge gauche
  move(dx: -15mm,
    box(width: 68mm, height: 68mm)[
      #image(tetiere, width: 100%, height: 100%, fit: "cover")
    ]
  ),

  // Chapo + trait rouge aligné en bas
  box(width: 100%, height: 68mm)[
    #stack(dir: ttb,
      box(height: 68mm)[
        #pad(left: -10mm, top:4mm)[  
            #set text(weight: "semibold", size: chapo_taille * 1pt)
            #chapo
        ]
      ],
      move(
      dx: -15mm, dy: -0.5mm, 
      line(length: 100% + 15mm + 15mm, stroke: 3pt + R4) 
    ),
    )
  ],
)

  v(8mm)

  // --- TEXTE : espacements --
set par(
  spacing: 1.2em, // espace entre les paragaphes (defaut: 1.2em)
  leading: 0.65em, // espace entre les lignes (defaut: 0.65em)
)

show heading: set block(
  above: 13pt,       // Un saut de ligne exact AVANT le titre
  below: 13pt,       // Un saut de ligne exact APRÈS le titre
  sticky: true       // Empêche le titre de rester seul en bas de colonne
)

body


} // fin de la fonction principale


// =============================================================================
// FONCTIONS DE BLOCS
// =============================================================================


#let bloc_base(
  corps,
  fill: none,
  stroke: none,
  text_delta: 0,
  spacing: 1.2em,
  leading: 0.65em,
  extra: none,
) = context {

  block(
    width: 100%,
    inset: 3mm,
    radius: 8pt,
    spacing: 0.4em,
    fill: fill,
    stroke: stroke,
  )[
    #show strong: _strong-noir
    #show heading.where(level: 2): _heading2-bloc

    #set text(
      size: (taille_bloc_state.get() + text_delta) * 1pt,
      weight: "regular"
    )

    #set par(
      spacing: spacing,
      leading: leading,
    )

    // styles spécifiques optionnels
    #if extra != none {
      extra
    }

    #corps
  ]
}

//Encadre
#let encadre(corps, spacing:1.2em, leading:0.65em) =  bloc_base(
    corps,
    stroke: 3pt + R4,
    spacing: spacing,
    leading: leading,
  )


//Definitions
#let definitions(corps, spacing:1.2em, leading:0.65em) =  bloc_base(
    corps,
    fill: G1,
    spacing: spacing,
    leading: leading,
)

// Pour en savoir plus
#let pour-en-savoir-plus(corps, spacing:1.2em, leading:0.65em) =  bloc_base(
    corps,
    fill: B1,
    spacing: spacing,
    leading: leading,
    extra: [
      #set list(marker: text(fill: red, size: 0.8em)[#sym.circle.filled])
      #show link: set text(fill: B6)
      #show link: underline
    ]
  )

//Sources
#let sources(corps, spacing:1.2em, leading:0.65em) =  bloc_base(
    corps,
    fill: R1,
    spacing: spacing,
    leading: leading,
  )



//Bloc encadre-figure
#let encadre-figure(corps, spacing:1.2em, leading:0.65em) =  bloc_base(
    corps,
    fill: G1,
    text_delta: -1,
    spacing: spacing,
    leading: leading,
  )

#let myfig(
  pos: top + right,
  largeur: 66%,
  dx: 0pt, dy: 0pt,
  pad-top: 0mm, pad-bottom: 0mm, pad-left: 0mm, pad-right: 0mm,
  champ-libre: none,
  titre: none,
  lecture: none,
  source: none,
  champ: none,
  note: none,
  width-image: 100%,
  chemin
) = {
  mybloc(pos: pos, largeur: largeur, dx: dx, dy: dy,
         pad-top: pad-top, pad-bottom: pad-bottom, pad-right: pad-right, pad-left: pad-left)[
    #if titre     != none [== #titre]
    #encadre-figure[
      #figure(image(chemin, width: width-image))
      #if champ-libre != none [#champ-libre \ ]
      #if note    != none [*Note* : #note \ ]
      #if lecture != none [*Lecture* : #lecture \ ]
      #if champ   != none [*Champ* : #champ \ ]
      #if source  != none [*Source* : #source]
    ]
  ]
}



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

//Donnees complementaires
#let donnees() = context {
  let logo = _logo_donnees_compl.get()
  link("https://www.insee.fr")[
    #block(
      radius: 8pt,
      fill: B5,
      inset: 8pt,
    )[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 6pt,
        align: left + horizon,
        if logo != none { image(logo, width: 15pt) },
        text(size: (taille_bloc_state.get() - 1) * 1pt, fill: white)[Retrouvez les données associées à cette publication sur insee.fr],
      )
    ]
  ]
}

#let appel-fleche(corps) = {
  box(
  width: 0.8em,
  height: 0.8em,
  {
    place(center + horizon, 
      polygon(
        fill: B6,
        (0%, 0%),   // Point haut gauche
        (100%, 50%),// Pointe (milieu droite)
        (0%, 100%)  // Point bas gauche
      )
    )
  }
)
  h(0.4em)
  corps
}