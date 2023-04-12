Tiro = Classe:extend()

function Tiro:new(x, y)
  self.x = x
  self.y = y
end

function Tiro:update(dt, cowboyX)
    self.x = self.x + 100 * dt
  end

function Tiro:draw()
  love.graphics.circle("fill", self.x, self.y, 10)
end
