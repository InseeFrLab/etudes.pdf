# 

## Commandes utiles pour le développeur:

### Pour faire le package R

- [`devtools::document()`](https://devtools.r-lib.org/reference/document.html):
  Génère la documentation R pour le package.
- [`devtools::check()`](https://devtools.r-lib.org/reference/check.html):
  Vérifie le package pour les erreurs de syntaxe et les problèmes de
  dépendances.
- [`devtools::install()`](https://devtools.r-lib.org/reference/install.html)
  ou
  [`devtools::build()`](https://devtools.r-lib.org/reference/build.html):
  Construit et installe le package.
- `detach("package:etudes.pdf", unload = TRUE)`: Décharge le package.
- [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html):
  Charge toutes les fonctions et objets du package.

#### Pour faire le site pagedown

- [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)

#### Pour lancer les tests unitaires:

- [`devtools::test()`](https://devtools.r-lib.org/reference/test.html)
