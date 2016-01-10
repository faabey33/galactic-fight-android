menu = {}

menubg = love.graphics.newImage("resc/menubg.png")
playbutton = love.graphics.newImage("resc/play.png")

function menu:update(dt)
  p_menu:update(dt)
  touches = love.touch.getTouches()
  if touches[1] ~= nil then
    local x,y = love.touch.getPosition(touches[1])
    if collision_rect(x,y,1,1,window.w/2-playbutton:getWidth()/2*player.scale,window.h/2+200*player.scale,playbutton:getWidth(),playbutton:getHeight()) == true then
      game:set(1)
    elseif collision_rect(x,y,1,1,0,window.h-200,200,200) == true then
      love.system.openURL("http://fabianmainz.bplaced.net/")
    end
  end
end

function menu:draw()
  love.graphics.draw(p_menu,0,0)
  love.graphics.draw(menubg,0,0,0,player.scale,player.scale)
  love.graphics.draw(playbutton,window.w/2,window.h/2+200,0,player.scale,player.scale,playbutton:getWidth()/2,0)
end
