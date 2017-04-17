--[[
Just some text on a texture for selected province. To add a new province, simply put
its diffuse and normals textures to Provincies folder. If you need to alternate colors,
either use “if-elseif-else-end” branching or copy approach used in United States style.
]]

-- let’s scan for all backgrounds we can find
provincies = {}
for i, file in ipairs(fs.readDir('Provincies', '*.png')) do
  if file:find('_nm.png') == nil then
    name = path.getFileNameWithoutExtension(file)
    provincies[name] = name
  end
end

-- input params:
defineSelect('Province', provincies, nil)
defineText('Value', 7, InputLength.Fixed, nil)

return function(province, value)
  -- number plate params
  plate.size = { 1024, 540 }
  plate.sizeMultipler = 0.5 -- change it to 1.0 if you want to get 1024×540 textures
  plate.background = 'Provincies/' .. province .. '.png'
  plate.normals = 'Provincies/' .. province .. '_nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'font.ttf'
  text.color = '#041589'
  text.size = 320
  text.weight = FontWeight.Normal
  text.lineSpacing = 49
  text.kerning = -23
  text.spaces = 107
  
  -- draw text
  drawText(value:sub(1, 4) .. ' ' .. value:sub(5), -10, 10, Gravity.Center)
end