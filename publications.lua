-- Publications page helper.
-- Runs after the reference list is built and:
--   1. sorts publications newest first, with a heading for each year
--   2. bolds the surnames listed under `bold-authors` in publications.qmd

local function first_year(text)
  for y in text:gmatch('%f[%d](%d%d%d%d)%f[%D]') do
    local n = tonumber(y)
    if n and n >= 1900 and n <= 2100 then return n end
  end
  return nil
end

local function bold_names(block, names)
  return block:walk({
    Str = function(s)
      for _, name in ipairs(names) do
        if s.text:sub(1, #name) == name then
          local rest = s.text:sub(#name + 1)
          if rest == '' or rest:match('^%p') then
            local out = { pandoc.Strong({ pandoc.Str(name) }) }
            if rest ~= '' then table.insert(out, pandoc.Str(rest)) end
            return out
          end
        end
      end
    end
  })
end

function Pandoc(doc)
  doc = pandoc.utils.citeproc(doc)
  local names = {}
  local meta_names = doc.meta['bold-authors']
  if meta_names then
    for _, n in ipairs(meta_names) do
      table.insert(names, pandoc.utils.stringify(n))
    end
  end

  doc.blocks = doc.blocks:walk({
    Div = function(div)
      if div.identifier ~= 'refs' then return nil end

      local items = {}
      for i, block in ipairs(div.content) do
        if block.t == 'Div' then
          local year = first_year(pandoc.utils.stringify(block)) or 0
          if #names > 0 then block = bold_names(block, names) end
          table.insert(items, { block = block, year = year, index = i })
        end
      end

      table.sort(items, function(a, b)
        if a.year ~= b.year then return a.year > b.year end
        return a.index < b.index
      end)

      local content = {}
      local current = nil
      for _, item in ipairs(items) do
        if item.year ~= current then
          current = item.year
          local label = current > 0 and tostring(current) or 'In press'
          table.insert(content, pandoc.Header(2, label, pandoc.Attr('', { 'pub-year' })))
        end
        table.insert(content, item.block)
      end

      div.content = content
      return div
    end
  })
  return doc
end
