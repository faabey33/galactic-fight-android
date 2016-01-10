bullet = {}
bullet.size = 5
bullet.speed = 18

function bullet:spawn(x,y,dirX,dirY,team,id)
  table.insert(bullet, {x = x, y = y, dirX = dirX, dirY = dirY, team = team, id = id})
end

function bullet:update(dt)
  for i,v in ipairs(bullet) do
    v.y = v.y - v.dirY/10 * bullet.speed * dt
    v.x = v.x - v.dirX/10 * bullet.speed * dt
    if v.team == 1 then
      if math.dist(v.x,v.y,player.x,player.y) < 20 then
        player.hp = player.hp - enemy.damage
        table.remove(bullet, i)
      end
    elseif v.team == 0 then
      for i = 1, #enemy do
        if math.dist(enemy[i]["x"],enemy[i]["y"],v.x,v.y) < 50 then
          enemy[i]["h"] = enemy[i]["h"]-player.damage
          table.remove(bullet, i)
        end
      end
    end
  end
end

function bullet:draw()
  for i,v in ipairs(bullet) do
    if v.x ~= nil or v.y ~= nil then
      if v.x > player.x+window.w or v.x < player.x-window.w or v.y < player.y-window.h or v.y > player.y+window.h then
        table.remove(bullet, i)
      else
        if v.team == 0 then love.graphics.setColor(200,200,200,130)
        elseif v.team == 1 then love.graphics.setColor(255,100,100,130) end
        love.graphics.circle("fill",v.x,v.y,bullet.size)
      end
    end
  end
end
