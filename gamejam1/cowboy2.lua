Cowboy2 = Classe:extend()

function Cowboy2:new()
  anim8 = require "anim8"
  self.x = 550
  self.y = 450


end

function Cowboy2:update(dt)

    if(love.keyboard.isDown("up")) then
      self.y = self.y - 100 * dt
    end
    if(love.keyboard.isDown("down")) then
      self.y = self.y + 100 * dt
    end
end


function Cowboy2:draw()
--desenha um retangulo
  love.graphics.rectangle("fill", self.x, self.y, 100, 100)

end