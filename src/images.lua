function Spritesheet(grill, type)
  local spritesheet = {
    quads = {}
  }
  local grill = grill
  local image = love.graphics.newImage("img/" .. type .. ".png")

  function get_image(x,y)
    return love.graphics.newQuad(x*16, y*16, 16, 16, image:getDimensions())
  end

  function spritesheet.draw_image(x,y,quad)
    love.graphics.draw(image, quad, x, y, 0,( grill.tile / 15 ), ( grill.tile / 15 )) -- correct for float to int
  end

  if type == "characters" then
    function get_set(x,y)
      x,y = x*3,y*4
      local quads = {}
      quads["down"] = {}
      quads["down"]["stand"] = {get_image(1+x,0+y)}
      quads["down"]["walk"] = {get_image(0+x,0+y),get_image(2+x,0+y)}

      quads["right"] = {}
      quads["right"]["stand"] = {get_image(1+x,2+y)}
      quads["right"]["walk"] = {get_image(0+x,2+y),get_image(2+x,2+y)}

      quads["left"] = {}
      quads["left"]["stand"] = {get_image(1+x,1+y)}
      quads["left"]["walk"] = {get_image(0+x,1+y),get_image(2+x,1+y)}

      quads["up"] = {}
      quads["up"]["stand"] = {get_image(1+x,3+y)}
      quads["up"]["walk"] = {get_image(0+x,3+y),get_image(2+x,3+y)}
      return quads
    end
    -- mans
    spritesheet.quads["man"] = get_set(0,0)
    spritesheet.quads["boy"] = get_set(1,0)
    spritesheet.quads["libri"] = get_set(0,2)
    spritesheet.quads["barra"] = get_set(1,2)
    -- mob
    spritesheet.quads["alien"] = get_set(3,0)
    spritesheet.quads["slime"] = get_set(0,1)
    spritesheet.quads["bat"] = get_set(1,1)
    spritesheet.quads["spider"] = get_set(3,1)
    -- girl
    spritesheet.quads["blonde_girl"] = get_set(2,2)
    spritesheet.quads["red_girl"] = get_set(3,2)
    spritesheet.quads["brown_girl"] = get_set(2,0)
    -- ghost
    spritesheet.quads["ghost_white"] = get_set(2,1)
    spritesheet.quads["ghost_yellow"] = get_set(0,3)
    spritesheet.quads["ghost_red"] = get_set(1,3)
    spritesheet.quads["ghost_blue"] = get_set(2,3)
    spritesheet.quads["ghost_green"] = get_set(3,3)

  elseif type == "basictiles" then
    spritesheet.quads["wall"] = {}
    spritesheet.quads["wall"]["blue"] = {get_image(0,0),get_image(1,0),get_image(2,0),get_image(3,0)}
    spritesheet.quads["wall"]["red"] = {get_image(4,0),get_image(5,0),get_image(6,0),get_image(7,0)}
    spritesheet.quads["wall"]["stone"] = {get_image(0,10),get_image(1,10)}
    spritesheet.quads["wall"]["wood"] = {get_image(0,11),get_image(1,11)}

    spritesheet.quads["floor"] = {}
    spritesheet.quads["floor"]["grass"] = {get_image(0,8),get_image(1,8),get_image(3,1),get_image(4,1)}
    spritesheet.quads["floor"]["wood"] = {get_image(0,1),get_image(0,2),get_image(2,10),get_image(2,11),get_image(0,9)}
    spritesheet.quads["floor"]["ice"] = {get_image(5,3),get_image(5,4)}
    spritesheet.quads["floor"]["stone"] = {get_image(6,1),get_image(1,9)}
    spritesheet.quads["floor"]["carpet"] = {get_image(1,2)}
    spritesheet.quads["floor"]["color"] = {get_image(1,1),get_image(3,1)}

    spritesheet.quads["decor"] = {}
    spritesheet.quads["decor"]["shelf"] = get_image(7,6)
    spritesheet.quads["decor"]["chest"] = get_image(4,4)
    spritesheet.quads["decor"]["table"] = get_image(6,6)
    spritesheet.quads["decor"]["urn"] = get_image(3,3)
    spritesheet.quads["decor"]["bed_down"] = get_image(5,6)
    spritesheet.quads["decor"]["bed_up"] = get_image(5,5)
    spritesheet.quads["decor"]["throne"] = get_image(6,5)
    spritesheet.quads["decor"]["statue"] = get_image(7,5)
    spritesheet.quads["decor"]["tower"] = get_image(7,5)
    spritesheet.quads["decor"]["statue"] = get_image(7,5)
    spritesheet.quads["decor"]["tag_armor"] = get_image(6,8)
    spritesheet.quads["decor"]["tag_magic"] = get_image(7,8)
    spritesheet.quads["decor"]["tag_weapon"] = get_image(6,9)
    spritesheet.quads["decor"]["tag_potion"] = get_image(7,9)

    spritesheet.quads["door"] = {get_image(0,6),get_image(1,6),get_image(2,6),get_image(0,7),get_image(1,7)}

    spritesheet.quads["cartel"] = get_image(3,8)

  elseif type == "things" then
    spritesheet.quads["door"] = {get_image(0,0),get_image(0,1),get_image(0,2),get_image(0,3)}
    spritesheet.quads["chest"] = {get_image(6,0),get_image(6,1),get_image(6,2),get_image(6,3)}
    spritesheet.quads["torch"] = {}
    spritesheet.quads["torch"]["yellow"] = {get_image(0,4),get_image(1,4),get_image(2,4)}
    spritesheet.quads["torch"]["blue"] = {get_image(0,5),get_image(1,5),get_image(2,5)}
    spritesheet.quads["torch"]["red"] = {get_image(0,6),get_image(1,6),get_image(2,6)}
    spritesheet.quads["torch"]["green"] = {get_image(0,7),get_image(1,7),get_image(2,7)}
  end

  return spritesheet
end

function Images(grill)
  local images = {}
  images["characters"] = Spritesheet(grill,"characters")
  images["basictiles"] = Spritesheet(grill,"basictiles")
  images["things"] = Spritesheet(grill,"things")
  return images
end

return Images
