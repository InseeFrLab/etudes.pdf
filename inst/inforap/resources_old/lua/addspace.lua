-- Force un espace dans les sorties pour PDF
function RawBlock(el)
  if el.text:match("\\addspace%s*%[([^%]]+)%]") then
    local size = el.text:match("\\addspace%s*%[([^%]]+)%]")
    return pandoc.RawBlock('html', '<div style="height: '..size..';"></div>')
  elseif el.text == "\\addspace" then
    return pandoc.RawBlock('html', '<div style="height: 1em;"></div>')
  end
end
