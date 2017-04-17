--[[
List of states is taken from States folder, so, to add one, just put a bunch of files
(diffuse texture, normals texture and, if needed, small script redefining some params)
to States folder.
]]

-- let’s scan for all backgrounds we can find
states = {}
for i, file in ipairs(fs.readDir('States', '*.png')) do
  if file:find('_nm.png') == nil then
    name = path.getFileNameWithoutExtension(file)
    states[name] = name
  end
end

-- input params:
defineSelect('State', states, nil)
defineText('Value', 7, InputLength.Fixed, nil)

return function(state, value)
  -- number plate params
  plate.size = { 1024, 540 }
  plate.sizeMultipler = 0.5 -- change it to 1.0 if you want to get 1024×540 textures
  plate.background = 'States/' .. state .. '.png'
  plate.normals = 'States/' .. state .. '_nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'font.ttf'
  text.color = '#000000'
  text.size = 240
  text.weight = FontWeight.Normal
  text.lineSpacing = 49
  text.kerning = 0
  text.spaces = 0

  -- state-specific params
  offset = { x = 0, y = 21 }
  stateParams = 'States/' .. state .. '.lua'
  if fs.exists(stateParams) then loadfile(stateParams)() end
  
  -- draw text
  drawText(value, offset.x, offset.y, Gravity.Center)
end