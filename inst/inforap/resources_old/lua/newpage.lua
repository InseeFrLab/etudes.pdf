function RawBlock(el)
  if el.format:match('tex') and el.text:match('\\newpage') then
    return pandoc.RawBlock('html', '<div class="page-break"></div>')
  end
end