-- interface.lua

function Interface(boss)
  local grill = boss.grill
  local attr = {
      life = 100,
      life_max = 100,
      level = 1,
      money = 0,
      exp = 0,
      exp_max = 50
    }
  local interface = {

  }

function interface.draw()
  love.graphics.setColor(255,255,0)
  love.graphics.print("Money " .. attr.money, grill.WIDTH - grill.tile*4, 0)

  love.graphics.setColor(255,0,255)
  love.graphics.print("Exp " .. attr.exp .. "/" .. attr.exp_max, grill.WIDTH - grill.tile*4, grill.tile)

  love.graphics.setColor(255,255,255)
  love.graphics.print("Level " .. attr.level, grill.WIDTH - grill.tile*3 * 3, 0)

  love.graphics.setColor(255,0,0)
  love.graphics.print("Life " .. attr.life .. "/" .. attr.life_max, grill.WIDTH - grill.tile*3 * 3, grill.tile)

  love.graphics.setColor(255, 255, 255)
end

function interface.add_life(life)
  attr.life = attr.life + life
  if attr.life > attr.life_max then
    attr.life = attr.life_max end
  if attr.life <= 0 then
    print("dead") end
end

function interface.add_exp(exp)
  attr.exp = attr.exp + exp
  if attr.exp >= attr.exp_max then
    attr.exp = attr.exp - attr.exp_max
    attr.exp_max = attr.exp_max * 2
    attr.level = attr.level + 1
    attr.life_max = attr.life_max + 10
    print("new level")
  end
end


  return interface
end

return Interface