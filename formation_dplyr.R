


remove.packages(c("rlang", "vctrs", "dplyr"))

# Réinstaller dans l'ordre des dépendances
install.packages("rlang")
install.packages("vctrs")
install.packages("dplyr")


library(dplyr)


### filter_out()

employes <- tibble(
  nom      = c("Alice", "Bob", "Clara", "Denis", "Eva"),
  actif    = c(TRUE, FALSE, NA, FALSE, TRUE),
  anciennete = c(3, 1, NA, 8, 5)
)

# Supprimer les employés dont on sait qu'ils sont inactifs et ont moins de 2 ans d'ancienneté.

employes |>  filter_out(!actif & anciennete<2)



