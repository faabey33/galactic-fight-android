game = {}

game.state = 0

function game:set(state)
  game.state = state
end

window = {}

window.w, window.h, window.f = love.window.getMode()



function collision_rect(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

fontsize = math.floor(window.h/28)
comforta = love.graphics.newFont("resc/comforta.ttf", fontsize)

fire = love.graphics.newImage("resc/fire.png")
star = love.graphics.newImage("resc/star.png")

music = love.audio.newSource("resc/music.mp3", type)

p_fire = love.graphics.newParticleSystem(fire, 200 )
p_fire:setPosition(0, 0 )
p_fire:setOffset( 0, 0 )
p_fire:setBufferSize( 150 )
p_fire:setEmitterLifetime( -1 )
p_fire:setParticleLifetime( 1.05 )
p_fire:setColors( 246, 148, 0, 255, 255, 86, 63, 61 )
p_fire:setSizes( 1, 0.5, 1 )
p_fire:setSpeed( 8, 80  )
p_fire:setDirection( math.rad(360) )
p_fire:setSpread( math.rad(360) )
p_fire:setLinearAcceleration( 0, 0 )
p_fire:setRotation( math.rad(0), math.rad(0) )
p_fire:setSpin( math.rad(0), math.rad(1), 1 )
p_fire:setRadialAcceleration( 0 )
p_fire:setTangentialAcceleration( 0 )

p_menu = love.graphics.newParticleSystem( star, 200 )
p_menu:setPosition( window.w/2, window.h/2 )
p_menu:setOffset( 0, 0 )
p_menu:setBufferSize( 1206 )
p_menu:setEmissionRate( 200 )
p_menu:setEmitterLifetime( -1 )
p_menu:setParticleLifetime( 5.05 )
p_menu:setColors( 255, 255, 255, 255, 255, 255, 255, 61 )
p_menu:setSizes( 0, 1, 1 )
p_menu:setSpeed( 5, 12  )
p_menu:setDirection( math.rad(360) )
p_menu:setSpread( math.rad(360) )
p_menu:setLinearAcceleration( 0, 0 )
p_menu:setRotation( math.rad(0), math.rad(0) )
p_menu:setSpin( math.rad(0), math.rad(1), 1 )
p_menu:setRadialAcceleration( 50 )
p_menu:setTangentialAcceleration( 80 )

p_powerup = love.graphics.newParticleSystem(star, 200 )
p_powerup:setPosition( 544, 332 )
p_powerup:setOffset( 0, 0 )
p_powerup:setBufferSize( 1206 )
p_powerup:setEmissionRate( 200 )
p_powerup:setEmitterLifetime( -1 )
p_powerup:setParticleLifetime( 1.05 )
p_powerup:setColors( 113, 225, 0, 255, 22, 226, 97, 61 )
p_powerup:setSizes( 1, 1, 1 )
p_powerup:setSpeed( 5, 12  )
p_powerup:setDirection( math.rad(360) )
p_powerup:setSpread( math.rad(360) )
p_powerup:setLinearAcceleration( 0, 0 )
p_powerup:setRotation( math.rad(0), math.rad(0) )
p_powerup:setSpin( math.rad(0), math.rad(1), 1 )
p_powerup:setRadialAcceleration( 0 )
p_powerup:setTangentialAcceleration( 31 )
