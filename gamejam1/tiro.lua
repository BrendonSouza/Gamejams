Tiro = Classe:extend()

function Tiro:new(x,y,player)
    self.x = x
    self.y = y
    self.player = player
    self.sprite = love.graphics.newImage("sprites/tiro.png")

end

function Tiro:update(dt)
    if(self.player == 1) then
        self.x = self.x + 5
    else
        self.x = self.x - 5
    end
end

function Tiro:draw()
   
    love.graphics.draw(self.sprite, self.x, self.y)
  
end