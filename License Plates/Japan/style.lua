--[[
This one is a bit heavy. I’ve maded it before Japanese DLC, so, unline Europe style,
here I was looking at official Japanese guidelines and rules instead. In Japanese DLC,
number plates are different, but, to be honest, I don’t want to change this style to
something which for me looks less accurate.

By the way, as far as I understand, vehicle code should be the same per car.
]]

-- input params
defineSelect('Hiragana', {
  'さ', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 
  'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'ほ', 'ま', 'み', 
  'む', 'め', 'も', 'や', 'ゆ', 'よ', 'ら', 'り', 'る', 'ろ'
})

defineSelect('Prefecture', {
  '豊橋', '三河', '秋田', '青森', '八戸', '千葉', '野田', '愛媛', '福井', '福岡', '筑豊', '福島', '岐阜', '飛騨',
  '群馬', '福山', '広島', '旭川', '函館', '北見', '釧路', '室蘭', '帯広', '札幌', '姫路', '神戸', '水戸', '土浦', '石川', '岩手', '香川',
  '相模', '湘南', '川崎', '横浜', '高知', '熊本', '京都', '三重', '宮城', '宮崎', '松本', '長野', '奈良', '長岡', '新潟', '大分', '岡山',
  '和泉', '大阪', '佐賀', '熊谷', '大宮', '所沢', '滋賀', '島根', '浜松', '沼津', '静岡', '徳島', '足立', '多摩', '練馬', '品川', '鳥取',
  '富山', '庄内', '山形', '山口', '山梨' 
})

defineSelect('Vehicle', {
  34, 500, 580, 302, 336, 330 
})

defineNumber('Number', 4, 0, 9999, nil)

return function(hiragana, prefecture, vehicle, number)
  -- number plate params
  plate.size = { 1024, 512 }
  plate.sizeMultipler = 0.5 -- change it to 1.0 if you want to get 1024×512 textures
  plate.background = 'bg.png'
  plate.normals = 'nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- common text params
  text.color = '#31503b'
  text.weight = FontWeight.Normal

  -- fix number to proper format
  addDash = false
  numberText = '' .. number
  if numberText:sub(1, 1) ~= '0' then
    numberText = numberText:sub(1, 2) .. ' ' .. numberText:sub(3, 4)
    addDash = true
  elseif numberText:sub(2, 2) ~= '0' then
    numberText = '·' .. numberText:sub(2, 2) .. ' ' .. numberText:sub(3, 4)
  else
    numberText = '·· ·' .. numberText:sub(4, 4)
  end

  -- draw number
  text.font = 'japan.ttf'
  text.size = 350
  text.kerning = 35
  text.spaces = 93  -- space between words, could be an array

  drawText(numberText:sub(1, 2), 485, 96, Gravity.East)
  drawText(numberText:sub(4, 5), 632, 96, Gravity.West)
  if addDash then drawText('-', 78, 66, Gravity.Center) end

  -- draw car ID
  text.font = 'usa.ttf'
  text.size = 122
  text.kerning = 10
  text.spaces = 93

  drawText(vehicle, 583, 35, Gravity.Northwest)

  -- draw prefecture
  text.font = 'japan-special.ttf'
  text.size = 138
  text.kerning = 25
  text.spaces = 35

  drawText(prefecture, 503, 9, Gravity.Northeast)

  -- draw hiragana
  drawText(hiragana, -390, 86, Gravity.Center)
end