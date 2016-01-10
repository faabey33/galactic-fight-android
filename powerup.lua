powerup = {}

powerup.max = 5
powerup.tick = 800
powerup.count = 0
powerup.x = {}
powerup.y = {}

function powerup:update()
  if powerup.count < powerup.max then
    if powerup.tick == 1000 then
      local randx = math.random(player.x-level.size[level.lv],player.x+level.size[level.lv])
      local randy = math.random(player.y-level.size[level.lv],player.y+level.size[level.lv])
      powerup.count = powerup.count + 1
      powerup:spawn(randx,randy)
    else
      powerup.tick = powerup.tick + 1
    end
  end
  for i = 1, #powerup.x do
    if powerup.x[i] ~= nil and powerup.y[i] ~= nil then
      if math.dist(player.x, player.y, powerup.x[i], powerup.y[i]) < 200 then
        player.hp = player.hp + 500
        table.remove(powerup.x, i)
        table.remove(powerup.y, i)
        powerup.count = powerup.count - 1
      end
    end
  end
end

function powerup:spawn(x,y)
  powerup.x[powerup.count] = x
  powerup.y[powerup.count] = y
end


function powerup:draw()
  for i = 1, #powerup.x do
    love.graphics.draw(p_powerup, powerup.x[i], powerup.y[i])
  end
end
