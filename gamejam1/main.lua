Classe = require "classic"

require "jogo"

function love.load()
  jogo = Jogo()
end

function love.update(dt)
  jogo:update(dt)
end

function love.draw()
  jogo:draw()
end