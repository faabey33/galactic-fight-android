require "camera"
require "level"
require "game"
require "player"
require "bullet"
require "enemy"
require "powerup"
require "menu"

function love.load()
  love.graphics.setFont(comforta)
  player:init()
  level:init()

end

function love.update(dt)
  if game.state == 0 then
    menu:update(dt)
    player.x = level.start.x[level.lv]
    player.y = level.start.y[level.lv]
    player.hp = 1000
    player.tick = 0
    player.killcount = 0
  elseif game.state == 1 then
    love.audio.play(music)
    player:update()
    powerup:update()
    enemy_infinitespawn(0)
    p_fire:update(dt)
    p_powerup:update(dt)
    bullet:update(dt)
    enemy:update(dt)
  end
end

function love.draw()
  if game.state == 0 then
    menu:draw()
  elseif game.state == 1 then
    camera:set()
    level:draw()
    powerup:draw()
    bullet:draw()
    player:draw()
    enemy:draw()
    --love.graphics.print("sr: "..enemy.spawnrate.."  st: "..enemy.spawntick, player.x+300, player.y)
    camera:unset()
  end
end
