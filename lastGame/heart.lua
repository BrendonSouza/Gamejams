heart = Classe:extend()

function heart:new(x,y)
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.position = Vetor(x,y)
    self.heartCheio = love.graphics.newImage("assets/heart.png")
    self.heartVazio = love.graphics.newImage("assets/heartVazio.png")
    self.isCheio = true
 
end

function heart:update(dt)

end


function heart:draw()
    if self.isCheio then
        love.graphics.draw(self.heartCheio, self.position.x, self.position.y,0,2,2)
    else
        love.graphics.draw(self.heartVazio, self.position.x, self.position.y,0,2,2)
    end

end




