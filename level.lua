level = {}

level.lv = 1

level.size = {}
level.size[1] = 2000

level.start = {}
level.start.x = {}
level.start.x[1] = 3000
level.start.y = {}
level.start.y[1] = 3000

star = love.graphics.newImage("resc/star.png")

function level:init()
  level_bg()
end

function level_bg()
  stars = level.size[level.lv]*0.6
  starsx = {}
  starsy = {}

  for i = 1, stars do
    local rand1 = math.random(level.start.x[level.lv]-level.size[level.lv], level.start.x[level.lv]+level.size[level.lv])
    local rand2 = math.random(level.start.y[level.lv]-level.size[level.lv], level.start.y[level.lv]+level.size[level.lv])
    starsx[i] = rand1
    starsy[i] = rand2
  end
end


function level:update()

end

function level:draw()
  love.graphics.circle("line",level.start.x[level.lv],level.start.y[level.lv],level.size[level.lv])
  for i = 1, stars do
    if starsx[i] > player.x-window.w/2 and starsx[i] < player.x+window.w/2 and starsy[i] > player.y-window.h/2 and starsy[i] < player.y+window.h/2 then
      love.graphics.points(starsx[i],starsy[i])
    end
  end
end
