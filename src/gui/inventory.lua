-- inventory.lua

Interface = require("gui/interface")
Quest_list = require("quest_list")

function Inventory(boss)
  local inventory = {}
  local bag = {}
  local equip = nil
  inventory.interface = Interface(boss)
  inventory.quest_list = Quest_list(boss)
  local grill = boss.grill
  local show = false

  function inventory.draw()
    if show then
      love.graphics.setColor(0,0,0)
      love.graphics.rectangle("fill", 0, 0, grill.WIDTH, grill.tile*2,0,2,2)
      inventory.interface.draw()
      for i,p in ipairs(bag) do
        p.draw(i,0) end
      equip.draw(grill.tile_w-1,0)
    end
  end

  function inventory.equip(item)
    equip = item
  end

  function inventory.add(item)
    table.insert(bag, item)
  end

  function inventory.remove(item)
    for i,p in ipairs(bag) do if p.code == item.code then table.remove(bag,i) return end end
  end

  function inventory.show()
    show = not(show)
  end

  return inventory
end

return Inventory
