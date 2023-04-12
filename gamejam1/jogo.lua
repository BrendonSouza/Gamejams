Jogo = Classe:extend()
require "cowboy"
require "cowboy2"

function Jogo:new()
  cowboy = Cowboy()
  cowboy2 = Cowboy2()
end

function Jogo:update(dt)
  cowboy:update(dt)
  cowboy2:update(dt)
end

function Jogo:draw()
  cowboy:draw()
  cowboy2:draw()
end
