Cowboy = Classe:extend()

require "tiro"

function Cowboy:new()
  anim8 = require "anim8"
  self.x = 0
  self.y = 450
  self.z = 0
  self.tiros = {}
  self.maxTiros = 5

end

function Cowboy:update(dt)

    if(love.keyboard.isDown("w")) then
      self.y = self.y - 100 * dt
    end

    if(love.keyboard.isDown("s")) then
      self.y = self.y + 100 * dt
    end

    --dispara um tiro
    self:disparar(dt)

   
end

--função que dispara um tiro quando a tecla espaço é pressionada
function Cowboy:disparar(dt)
  if love.keyboard.isDown("space") then
    if #self.tiros < self.maxTiros then
      local tiro = Tiro(self.x + 100, self.y + 50)
      table.insert(self.tiros, tiro)
    end
  end

  for i = #self.tiros, 1, -1 do
    self.tiros[i]:update(dt)
    if self.tiros[i].x > love.graphics.getWidth() then
      table.remove(self.tiros, i)
    end
  end
end

function Cowboy:draw()
--desenha um retangulo
  love.graphics.rectangle("fill", self.x, self.y, 100, 100)

  for _, tiro in ipairs(cowboy.tiros) do  -- percorre a tabela de tiros do cowboy
    tiro:draw()  -- desenha cada tiro
  end

end