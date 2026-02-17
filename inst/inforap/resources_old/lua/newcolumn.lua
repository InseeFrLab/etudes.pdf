-- Force un saut de colonne dans les layouts multi-colonnes
function RawBlock(el)
  if el.text == "\\newcolumn" then
    return pandoc.RawBlock('html', '<div class="newcolumn"></div>')
  end
end
