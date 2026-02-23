#let auteurs = [$auteurs$] //necessaire pour que le code typst des auteurs fonctionne dans le .qmd

#show: doc => insee(
  title: [$title$],
  collection: [$collection$],
  date_publication: [$date_publication$],
  numero: [$numero$],
  chapo: [$chapo$],
  chapo_taille: int($chapo_taille$),
  auteurs: auteurs,
  surtitre: [$surtitre$],
  logo_insee_header: "$logo_insee_header$",
  tetiere: "$tetiere$",
  logo_x: "$logo_x$",
  qrcode: "$qrcode$",
  
  doc
)


