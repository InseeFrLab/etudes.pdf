# 

## En cas de problèmes d’installation

#### Installation du package Meander

En cas de difficulté lors du quarto render, si la version de
quarto-typst utilisée est trop ancienne, il peut y avoir un conflit avec
le package Meander, qui requiert des fonctions typst récentes. Un
message d’erreur de ce genre peut alors survenir:

    error: module sym does not contain chevron
     ┌─ @preview/meander:0.4.2\src\bisect.typ:6:25
     │ 6 │ #let symbol_func = [#sym.chevron.l].func() │

Il faut simplement mettre à jour la version de quarto utilisée, en
téléchargeant une version plus récente ici:
<https://quarto.org/docs/download/>

Penser à redémarrer le logiciel (Rstudio, Positron) une fois quarto mis
à jour.

------------------------------------------------------------------------

#### Font Open Sans

Si ce message survient lors du quarto render:

    [typst]: Compiling if157.typ to if157.pdf
    ...downloading @preview/hy-dro-gen:0.1.1
     850.9 KiB / 850.9 KiB (100 %) 850.9 KiB/s in 345.15 ms ETA: 0 s 
    warning: unknown font family: open sans
     ┌─ \\?\C:\Users\karl4\Documents\Projets\etudes.pdf\if157.typ:325:17 
     │ 325 │ set text(font: "Open Sans", lang: "fr", size: texte_taille * 1pt)
     │ ^^^^^^^^^^^ warning: unknown font family: open sans

Il faut télécharger les polices Open Sans sur le poste, nécessaires pour
générer les pdf: <https://fonts.google.com/specimen/Open+Sans>

Clic droit sur tous les fichiers, puis Installer.

Penser à redémarrer le logiciel (Rstudio, Positron) une fois les fonts
téléchargées sur le poste.
