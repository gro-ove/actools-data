--[[
Custom more advanced version of European number plates. Has custom normal maps and
country-specific behavior.
]]

-- let’s scan for all backgrounds we can find
countries = {}
for i, file in ipairs(fs.readDir('Countries', '*.png')) do
  if file:find('_nm.png') == nil then
    name = path.getFileNameWithoutExtension(file)
    countries[name] = name
  end
end

-- input params
defineSelect('Country', countries, nil)
defineText('Prefix', 2, InputLength.Fixed, 'AC')
defineNumber('Number', 3, 0, 999, nil)
defineText('Postfix', 2, InputLength.Varying, 'KS')

-- country-specific functions
function cs_Netherlands(prefix, number, postfix)
  forbidden = 'AEIOUWMYCQ'
  allowed = 'BDFGHJKLNPRSTVXZ'

  for c in forbidden:gmatch'.' do
    prefix = prefix:gsub(c, function(c) 
      random = math.random(1, #allowed)
      return allowed:sub(random, random) 
    end)
    
    postfix = postfix:gsub(c, function(c) 
      random = math.random(1, #allowed)
      return allowed:sub(random, random) 
    end)
  end

  text.font = 'kenteken.ttf'  
  text.size = 150

  textValue = number:sub(1, 2) .. '-' .. prefix .. '-' .. postfix

  -- let’s make sure text fits
  for i = 1, 10 do    
    size = measureText(textValue, 0, 0)
    if size.x > 800 then text.kerning = text.kerning - 1 else break end
  end

  -- draw text
  drawText(textValue, 162, 6, Gravity.West)
end

return function(country, prefix, number, postfix)
  -- fix values according to font
  prefix = prefix:upper()
  postfix = postfix:upper()

  -- number plate params
  plate.size = { 1024, 256 }
  plate.background = 'Countries/' .. country .. '.png'

  customNormals = 'Countries/' .. country .. '_nm.png'
  if fs.exists(customNormals) then
    plate.normals = customNormals
  else
    plate.normals = 'nm.png'
  end

  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.color = '#473e29'
  text.weight = FontWeight.Normal
  text.kerning = -4
  text.spaces = 48  -- space between words, could be an array

  if country == 'Netherlands' then
    cs_Netherlands(prefix, postfix, number)
  else
    text.font = 'common.ttf'
    text.size = 210

    -- draw text
    drawText(prefix .. ' ' .. number .. ' ' .. postfix, 162, 14, Gravity.West)
  end  
end