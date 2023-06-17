Jogo = Classe:extend()

function Jogo:new()
    mouse = Vetor()
    mapa = Mapa()
    p1 = Personagem()
    start = { x = 1, y =8 }
    goal = { x = 12, y = 9 }
    path = requestPath()
    tower = nil
 
end

function Jogo:update(dt)
    mouse.x = math.floor(love.mouse.getX()/64) + 1
    mouse.y = math.floor(love.mouse.getY()/64) + 1
    if(love.mouse.isDown(1)) then
        tower = Torre(mouse.x, mouse.y)

    end

    mapa:update(dt)
    p1:update(dt)
    if(tower) then
        tower:update(dt)
    end
end


function Jogo:draw()
    mapa:draw()

    if path then
        for i, p in ipairs(path) do
            love.graphics.setColor(0, 1, 0)
            love.graphics.rectangle("fill", (p.x-1)*64, (p.y-1)*64, 64, 64)
        end
    end
    love.graphics.setColor(1,1,1)
    p1:draw()
    if(tower) then
        tower:draw()
    end
end

function positionIsOpenFunc (x, y)
   
    if mapa.area[y][x] == 1 then
        return true
    end
end

function requestPath ()
    return Lua_star:find(mapa.largura, mapa.altura, start, goal, positionIsOpenFunc, false, true)
end
