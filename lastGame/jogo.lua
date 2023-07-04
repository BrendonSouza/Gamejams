Jogo = Classe:extend()

function Jogo:new()
    player = Player()
    Enemy = Enemy()
    ground = world:newRectangleCollider(100,400,600,10)
    ground:setType('static')

end

function Jogo:update(dt)
    player:update(dt)
    Enemy:update(dt)
end


function Jogo:draw()
    player:draw()
    Enemy:draw()
end
