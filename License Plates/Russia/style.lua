--[[
Here is a good example of custom random values — with simple “nil”, just a random string 
would be used, but in Russia, only small number of charactes is allowed, so we have to
generate random string from this configuration file instead.

Also, kerning of the main piece of text could be reduced to make sure it will fit to
640 pixels (just some random value).
]]

allowed = 'abekmhopctyx'
regions = {
  '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '102', '11', '113', '116', '12', '121', '123', 
  '124', '125', '126', '13', '134', '136', '138', '14', '142', '15', '150', '152', '154', '159', '16', '161',
  '163', '164', '17', '173', '174', '177', '178', '18', '186', '19', '190', '196', '197', '198', '199', '21',
  '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
  '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57',
  '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75',
  '750', '76', '77', '777', '78', '79', '80', '82', '83', '85', '86', '87', '89', '90', '91', '92', '93', '94',
  '95', '96', '97', '98', '99'
}

-- input params
defineText('Prefix', 1, InputLength.Fixed, function () return generateRandomString(allowed, 1) end)
defineText('Postfix', 2, InputLength.Fixed, function () return generateRandomString(allowed, 2) end)
defineNumber('Number', 3, 0, 999, nil)
defineNumber('Region', 2, 0, 999, function () return regions[math.random(1, #regions)] end)

return function(prefix, postfix, number, region)
  -- number plate params
  plate.size = { 1040, 220 }
  plate.background = 'bg.png'
  plate.normals = 'nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'font.ttf'
  text.size = 235
  text.color = '#000000'
  text.weight = FontWeight.Normal
  text.kerning = 11

  -- let’s make sure text fits in its slot
  for i = 1, 10 do    
    size = measureText(prefix .. number .. postfix, 65, 48, Gravity.West)
    if size.x > 640 then text.kerning = text.kerning - 1 else break end
  end

  -- draw text
  drawText(prefix .. number .. postfix, 65, 48, Gravity.West)

  -- region
  text.size = 180
  text.kerning = 11
  drawText(region, 350, 50, Gravity.North)
end