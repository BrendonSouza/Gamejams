Cenario = Classe:extend()

--contem apenas o background
function Cenario:new()
    self.background = love.graphics.newImage("sprites/background.jpg")
   
end

function Cenario:update(dt)

end

function Cenario:draw()
    love.graphics.draw(self.background, 1, 1,0,0.19,0.19)

end
