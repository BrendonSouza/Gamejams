Tiro = Classe:extend()

function Tiro:new(x,y,player)
    self.x = x
    self.y = y
    self.player = player
end

function Tiro:update(dt)
    if(self.player == 1) then
        self.x = self.x + 5
    else
        self.x = self.x - 5
    end
end

function Tiro:draw()
   
    love.graphics.circle("fill", self.x, self.y, 5)

end

function Tiro:estaNaTela()
    if(self.x > 0 and self.x < 780) then
        return true
    else
        return false
    end
end