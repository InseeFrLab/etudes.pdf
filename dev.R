## 3. Figure en R

::: {#fig-3}

```{r}
#| echo: false
#| label: fig-iris


# Graphique simple : Relation entre longueur et largeur des pétales
plot(iris$Petal.Length, iris$Petal.Width,
     col = iris$Species,           # Couleur par espèce
     pch = 19,                     # Style de point (rond plein)
     main = "Iris : Pétales",      # Titre
     xlab = "Longueur",            # Label X
     ylab = "Largeur")             # Label Y
legend("topleft", legend = levels(iris$Species), col = 1:3, pch = 19)
```

**Lecture** : Note de lecture

**Source** :  Insee, Recensement de la population 2022.
:::