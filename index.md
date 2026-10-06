## Générer un Insee Flash ou Insee Analyses en PDF

------------------------------------------------------------------------

### 📋 Présentation

`etudes.pdf` est un package R qui permet la création de publications
**Insee Flash Pays de la Loire** ou **Insee Analyses Pays de la Loire**
au format **PDF** conformes à la charte graphique de l’Insee.

- [Liste des publications Insee Pays de la
  Loire](https://www.insee.fr/fr/statistiques?debut=0&categorie=2&collection=109)
- [Charte Insee Flash
  2025](https://inseefrlab.github.io/etudes.pdf/reference/figures/Cahier_des_charges_IF_2025.pdf)

------------------------------------------------------------------------

### 🚀 Installation

- Lancez la commande suivante pour installer le package `etudes.pdf`:

Sur AUS, il est obligatoire de l’installer depuis gitlab.insee.fr:

``` r

remotes::install_git("https://gitlab.insee.fr/yfawc1/etudes.pdf", dependencies = TRUE)
```

Sur POSTE, il est aussi possible de l’installer depuis github:

``` r

remotes::install_github("https://github.com/InseeFrLab/etudes.pdf")
```

- Lancer la fonction
  [`install_insee_flash_typst()`](https://inseefrlab.github.io/etudes.pdf/reference/install_insee_flash_typst.md)
  pour installer l’extension typst dédiée aux Insee Flash ou
  [`install_insee_analyses_typst()`](https://inseefrlab.github.io/etudes.pdf/reference/install_insee_analyses_typst.md)
  pour installer l’extension typst des Insee Analyses: un dossier
  `\_extensions` est créé.

- déplacer le fichier modèle `if157.qmd` ou `ia144.qmd`du dossier
  `\_extensions/insee-flash` ou `\_extensions/insee-analyses` vers la
  racine puis lancer `quarto render if157.qmd` ou
  `quarto render ia144.qmd`pour générer le pdf.

- modifier le fichier `if157.qmd` ou `ia144.qmd`en fonction de vos
  besoins et lancer `quarto render if157.qmd` ou
  `quarto render ia144.qmd`pour régenerer le pdf.

### Remarque pour AUS

AUS étant coupé d’internet, il a été nécessaire d’embarquer la librairie
Meander dans le package R:

- meander:0.4.1 est embarqué dans
  `insee_analayses/typst/packages/preview/` et
  `insee-flash/typst/packages/preview/`
- hy-dro-gen:0.1.1, sa dépendance transitive est également embarquée aux
  mêmes emplacements.
