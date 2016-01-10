enemy = {}
enemy.size = 100
enemy.ai = {}
enemy.ai.dist = math.floor(window.h/2)
enemy.ai.shootingRate = 20  --bigger -> slower
enemy.speed = 300
enemy.total = 1
enemy.spawnrate = 1
enemy.spawntick = 700
enemy.damage = 25

shipenemy = love.graphics.newImage("resc/enemy.png")

function enemy:spawn(x,y,r,h,id)
  table.insert(enemy, {x = x,
                       y = y,
                       r = r,
                       h = h,
                       tick = 0,
                       id = id})
end

function enemy_infinitespawn(start)
  if enemy.spawntick == 800 then
    for i = 1, enemy.spawnrate do
      local randx = math.random(player.x-level.size[level.lv],player.x+level.size[level.lv])
      local randy = math.random(player.y-level.size[level.lv],player.y+level.size[level.lv])
      enemy:spawn(randx,randy,0,1000,enemy.total)
      enemy.total = enemy.total + 1
    end
    enemy.spawntick = 0
    enemy.spawnrate = enemy.spawnrate + 2
  else
    enemy.spawntick = enemy.spawntick + 1
  end
end

function enemy:update(dt)
  for i,v in ipairs(enemy) do
    if v.h < 1 then
      player.killcount = player.killcount + 1
      table.remove(enemy, i)
    else
      local angle, dirX, dirY = get_enemy_rotation(v.x,v.y)
      if v.y >= player.y then
        angle = -angle
      end
      v.r = angle
      if math.abs(math.dist(player.x,player.y,v.x,v.y)) > enemy.ai.dist then
        v.y = v.y + dirY/1000 * enemy.speed * dt
        v.x = v.x + dirX/1000 * enemy.speed * dt
      end
      if v.tick == enemy.ai.shootingRate then
        bullet:spawn(v.x,v.y,-dirX,-dirY,1,v.id)
        v.tick = 0
      else
        v.tick = v.tick + 1
      end
    end
  end
end

function get_enemy_rotation(en_x, en_y)
  local ux1, uy1 = 0, player.y
  local ux2, uy2 = player.x, player.y

  --love.graphics.line(ux1,uy1,ux2,uy2)

  local vx1, vy1 = player.x, player.y
  local vx2, vy2 = player.x - (en_x-player.x), player.y - (en_y-player.y)

  --love.graphics.line(vx1,vy1,vx2,vy2)

  local vx = vx2-vx1
  local vy = vy2-vy1
  local ux = ux2-ux1
  local uy = uy2-uy1

  local angle = math.acos((ux*vx+uy*vy)/(math.sqrt(ux*ux+uy*uy)*math.sqrt(vx*vx+vy*vy)))
  return angle, vx, vy
end

function enemy:draw()
  for i,v in ipairs(enemy) do
    if v.x < player.x+window.w+enemy.size and v.x > player.x-window.w/2-enemy.size and v.y > player.y-window.h-enemy.size and v.y < player.y+window.h+enemy.size then
      love.graphics.setColor(getColor_hp(v.h))
      love.graphics.print(v.h, v.x,v.y+shipenemy:getHeight())
      love.graphics.draw(p_fire, v.x, v.y)
      love.graphics.setColor(255,255,255,255)
      love.graphics.draw(shipenemy,v.x,v.y,v.r,player.scale,player.scale,0, (player.scale*ship:getHeight())/2)

    end
  end
  love.graphics.setColor(255,255,255,255)
end

function getColor_hp(hp)
  if hp >= 750 then
    return 20,255,20,255
  elseif hp < 750 and hp > 300 then
    return 255,140,0,255
  elseif hp <= 300 then
    return 255,10,10,255
  end
end
