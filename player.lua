player = {}
player.x = level.start.x[level.lv]
player.y = level.start.y[level.lv]
player.r = 0
player.scale = window.w/1920
player.maxspeed = 450
player.hp = 1000
player.shooting = false
player.shotcooldown = 30
player.tick = 0
player.damage = 25
player.killcount = 0
ship = love.graphics.newImage("resc/ship.png")

stick = {}
stick.lx = 0
stick.ly = 0
stick.le = false
stick.rx = 0
stick.ry = 0
stick.re = false

--stick area
stick.a = {}
stick.a.lx = 0
stick.a.rx = window.w-window.h/2
stick.a.y = window.h/2
stick.a.w = window.h/2
stick.a.h = window.h/2
--save touch id
stick.a.id1 = 0
stick.a.id2 = 0

--stick elongation
stick.exl = 0
stick.eyl = 0
stick.exr = 0
stick.eyr = 0
stick.emax = stick.a.w/2

--particle
fire_emit = 40
p_fire:setEmissionRate(fire_emit)

angle = 0

function player:init()
end

function stick_checkuserpos(x,y,side)
  if side == "left" then
    if collision_rect(x,y,1,1,stick.a.lx,stick.a.y,stick.a.w,stick.a.h) == true then
      return true
    else
      return false
    end
  elseif side == "right" then
    if collision_rect(x,y,1,1,stick.a.rx,stick.a.y,stick.a.w,stick.a.h) == true then
      return true
    else
      return false
    end
  end
end

function input_get()
  local touches = love.touch.getTouches()
  if touches[2] ~= nil and stick.a.id2 == 0 then
    local x, y = love.touch.getPosition(touches[2])
    --left stick enabled -> check right only
    if stick.le == true and stick.re == false then
      if stick_checkuserpos(x,y,"right") == true then
        stick.re = true
        stick.a.id2 = "right"
        stick.rx, stick.ry = x, y
      else
        stick.re = false
      end
    --right stick enabled -> check left only
    elseif stick.le == false and stick.re == true then
      if stick_checkuserpos(x,y,"left") == true then
        stick.le = true
        stick.a.id2 = "left"
        stick.lx, stick.ly = x, y
      else
        stick.le = false
      end
    --both sticks disabled
    elseif stick.le == false and stick.re == false then
      if stick_checkuserpos(x,y,"left") == true then
        stick.le = true
        stick.a.id2 = "left"
        stick.lx, stick.ly = x, y
      elseif stick_checkuserpos(x,y,"right") == true then
        stick.re = true
        stick.a.id2 = "right"
        stick.rx, stick.ry = x, y
      else
        stick.re, stick.le = false, false
      end
    end
  elseif touches[2] == nil then
    if stick.a.id2 == "right" then
      stick.re = false
    elseif stick.a.id2 == "left" then
      stick.le = false
    end
  end
  if touches[1] ~= nil and stick.a.id1 == 0 then
    local x, y = love.touch.getPosition(touches[1])
    --left stick enabled -> check right only
    if stick.le == true and stick.re == false then
      if stick_checkuserpos(x,y,"right") == true then
        stick.re = true
        stick.a.id1 = "right"
        stick.rx, stick.ry = x, y
      else
        stick.re = false
      end
    --right stick enabled -> check left only
    elseif stick.le == false and stick.re == true then
      if stick_checkuserpos(x,y,"left") == true then
        stick.le = true
        stick.a.id1 = "left"
        stick.lx, stick.ly = x, y
      else
        stick.le = false
      end
    --both sticks disabled
    elseif stick.le == false and stick.re == false then
      if stick_checkuserpos(x,y,"left") == true then
        stick.le = true
        stick.a.id1 = "left"
        stick.lx, stick.ly = x, y
      elseif stick_checkuserpos(x,y,"right") == true then
        stick.re = true
        stick.a.id1 = "right"
        stick.rx, stick.ry = x, y
      else
        stick.re, stick.le = false, false
      end
    end
  elseif touches[1] == nil then
    if stick.a.id1 == "right" then
      stick.re = false
    elseif stick.a.id1 == "left" then
      stick.le = false
    end
  end
  if touches[1] == nil and touches[2] == nil then
    stick.le = false
    stick.re = false
    stick.a.id1 = 0
    stick.a.id2 = 0
  end
end

function input_use()
  if stick.le == true and stick.re == true then
    touches = love.touch.getTouches()
    if touches[1] ~= nil and touches[2] ~= nil then
    local x1, y1 = love.touch.getPosition(touches[1])
    local x2, y2 = love.touch.getPosition(touches[2])
    --bounds positive
    --if x1 > stick.emax then x1 = stick.emax end
    --if x2 > stick.emax then x2 = stick.emax end
  --  if y1 > stick.emax then y1 = stick.emax end
  --  if y2 > stick.emax then y2 = stick.emax end
  --  --bounds negative
  --  if x1 < -stick.emax then x1 = -stick.emax end
  --  if x2 < -stick.emax then x2 = -stick.emax end
  --  if y1 < -stick.emax then y1 = -stick.emax end
  --  if y2 < -stick.emax then y2 = -stick.emax end

      if stick.a.id1 == "right" then
        stick.eyr = stick.ry-y1
        stick.exr = stick.rx-x1
        stick.eyl = stick.ly-y2
        stick.exl = stick.lx-x2
      else
        stick.eyr = stick.ry-y2
        stick.exr = stick.rx-x2
        stick.eyl = stick.ly-y1
        stick.exl = stick.lx-x1
      end
    end
  end
end

function player:update(dt)

  if player.hp < 0 then
    game:set(0)
  end

  input_get()
  input_use()

  if stick.le == true and stick.re == true then
    if stick.exl > player.maxspeed then
      stick.exl = player.maxspeed
    elseif stick.exl < -player.maxspeed then
      stick.exl = -player.maxspeed
    end
    if stick.eyl > player.maxspeed then
      stick.eyl = player.maxspeed
    elseif stick.eyl < -player.maxspeed then
      stick.eyl = -player.maxspeed
    end

    player.x = player.x - stick.exl/(stick.emax/15) --~50
    player.y = player.y - stick.eyl/(stick.emax/15)
  end

  --keep in center of camera
  if player.x > (love.graphics.getWidth() / 2 * camera.scaleX) then
		camera.x = player.x - love.graphics.getWidth() / 2 * camera.scaleX
	end

	if player.y > (love.graphics.getHeight() / 2 * camera.scaleY) then
		camera.y = player.y - love.graphics.getHeight() / 2 * camera.scaleX
	end

  player_checkBounds()

end

function player_checkBounds()
  if math.dist(player.x,player.y,level.start.x[level.lv], level.start.y[level.lv]) > level.size[level.lv] then
    game:set(0)
  end
end

function p_fire_gain(dt)
  if fire_emit < 200 then
    fire_emit = fire_emit + 8
  end
  return fire_emit
end

function p_fire_lose(dt)
  if fire_emit > 10 then
    fire_emit = fire_emit - 8
  end
  return fire_emit
end


function player:draw(dt)

  local leftCornerX = player.x-window.w/2
  local leftCornerY = player.y+window.h/2

  if stick.le == true then
    --love.graphics.print(stick.lx.." "..stick.ly,0,0)
    love.graphics.circle("line",leftCornerX+stick.lx,leftCornerY-window.h+stick.ly,stick.emax)
  end
  if stick.re == true then
    --love.graphics.print(stick.rx.." "..stick.ry,0,20)
    love.graphics.circle("line",leftCornerX+stick.rx,leftCornerY-window.h+stick.ry,stick.emax)
    love.graphics.circle("line",leftCornerX+stick.rx,leftCornerY-window.h+stick.ry,stick.emax/2)
  end

  if stick.le == true and stick.re == true then
    --love.graphics.print(math.floor(stick.exr).." "..math.floor(stick.eyr),500,20)
    --love.graphics.print(math.floor(stick.exl).." "..math.floor(stick.eyl),500,0)
    p_fire:setEmissionRate(p_fire_gain(dt))


    love.graphics.print(angle,500,600)

    if stick.eyr == 0 and stick.exr == 0 then
      stick.eyr = 1
      stick.exr = 1
    end

    local angle, mx, my = get_rotation()

    if stick.eyr >= 0 then
      player.r = -angle
    else
      player.r = angle
    end


    if math.abs(stick.eyr) > stick.emax/2 or math.abs(stick.exr) > stick.emax/2 then
      player.shooting = true
    else
      player.shooting = false
    end

    player_shoot(mx,my)

  else
    p_fire:setEmissionRate(p_fire_lose(dt))
  end

  local firex = player.x
  local firey = player.y


  love.graphics.setColor(getColor_hp(player.hp))


  love.graphics.print("HP: "..player.hp, player.x-window.w/2+12, player.y-window.h/2+12)
  love.graphics.draw(p_fire, firex, firey)

  love.graphics.setColor(255,255,255,255)
  love.graphics.print("FPS: "..love.timer.getFPS().."       Kills: "..player.killcount, player.x-window.w/2+200, player.y-window.h/2+12)

  love.graphics.draw(ship ,player.x, player.y, player.r, player.scale, player.scale, 0, (player.scale*ship:getHeight())/2)


end

function get_rotation()
  local ux1, uy1 = 0, stick.ry
  local ux2, uy2 = stick.rx, stick.ry

  --love.graphics.line(ux1,uy1,ux2,uy2)

  local vx1, vy1 = stick.rx, stick.ry
  local vx2, vy2 = stick.rx - stick.exr, stick.ry - stick.eyr

  --love.graphics.line(vx1,vy1,vx2,vy2)

  local vx = vx2-vx1
  local vy = vy2-vy1
  local ux = ux2-ux1
  local uy = uy2-uy1

  local angle = math.acos((ux*vx+uy*vy)/(math.sqrt(ux*ux+uy*uy)*math.sqrt(vx*vx+vy*vy)))
  return angle, vx, vy
end

function player_shoot(mx,my)
  --if player.shooting == true and player.tick == player.shotcooldown then
  --  bullet:spawn(player.x, player.y, mx, my)
--    player.tick = 0
--  else
--    player.tick = player.tick + 1
--  end
if player.shooting == true then
  local pox = mx
  local poy = my
  if pox > ship:getHeight() then
    pox = ship:getHeight()
  end
  if poy > ship:getHeight() then
    poy = ship:getHeight()
  end
  bullet:spawn(player.x, player.y, -mx, -my, 0, 1000)
end
end
