Tiro = Classe:extend()

function Tiro:new(x,y,player)
    self.x = x
    self.y = y
    self.player = player
    self.raio = 5
end

function Tiro:update(dt)
    if(self.player == 1) then
        self.x = self.x + 15
    else
        self.x = self.x - 15
    end
end

function Tiro:draw()
   
    love.graphics.circle("fill", self.x, self.y, self.raio)

end

function Tiro:estaNaTela()
    if(self.x > 0 and self.x < 780) then
        return true
    else
        return false
    end
end
