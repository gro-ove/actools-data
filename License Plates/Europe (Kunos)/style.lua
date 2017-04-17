--[[
Usual Kunos license plates. Unlike Kunos though, they are lighted from above, but it
could be changed. List of backgrounds (for different countries) is loaded automatically,
so, if you want to add some, just put them to Countries folder.
]]

-- let’s scan for all backgrounds we can find
countries = {}
for i, file in ipairs(fs.readDir('Countries', '*.png')) do
  name = path.getFileNameWithoutExtension(file)
  countries[name] = name
end

-- input params
defineSelect('Country', countries, nil)
defineText('Prefix', 2, InputLength.Fixed, 'AC')
defineNumber('Number', 3, 0, 999, nil)
defineText('Postfix', 2, InputLength.Varying, 'KS')

return function(country, prefix, number, postfix)
  -- number plate params
  plate.size = { 1024, 256 }
  plate.background = 'Countries/' .. country .. '.png'
  plate.normals = 'nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'common.ttf'
  text.size = 210
  text.color = '#473e29'
  text.weight = FontWeight.Normal
  text.kerning = -4
  text.spaces = 48  -- space between words, could be an array

  -- draw text
  drawText(prefix .. ' ' .. number .. ' ' .. postfix, 162, 14, Gravity.West)
end