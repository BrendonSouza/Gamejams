Jogo = Classe:extend()

function Jogo:new()
    player = Player()
    ground = world:newRectangleCollider(100,400,600,10)
    ground:setType('static')
end

function Jogo:update(dt)
    player:update(dt)
end


function Jogo:draw()
    player:draw()

end
