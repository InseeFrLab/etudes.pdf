# 

## Commandes utiles pour le développeur:

### Pour faire le package R

- `devtools::document()`: Génère la documentation R pour le package.
- `devtools::check()`: Vérifie le package pour les erreurs de syntaxe et
  les problèmes de dépendances.
- `devtools::install()` ou `devtools::build()`: Construit et installe le
  package.
- `detach("package:etudes.pdf", unload = TRUE)`: Décharge le package.
- `devtools::load_all()`: Charge toutes les fonctions et objets du
  package.

#### Pour faire le site pagedown

- [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)

#### Pour lancer les tests unitaires:

- `devtools::test()`
