Jogo = Classe:extend()

function Jogo:new()
    self.mouse = Vetor()
    mapa = Mapa()
    p1 = Personagem()
    wave = {}
    start = { x = 1, y =8 }
    goal = { x = 12, y = 8 }
    path = requestPath()
    self.towers = {}
    -- tower = nil
    self.waveProperties = {enemiesCount = 0 , enemiesSpawned =0}
    self.clickou = false
end

function Jogo:update(dt)
    self.mouse.x = math.floor(love.mouse.getX()/64) + 1
    self.mouse.y = math.floor(love.mouse.getY()/64) + 1
    if(love.mouse.isDown(1) and not self.clickou and not mapa.posicaoInvalida) then
        self.clickou = true
        -- tower = Torre(self.mouse.x, self.mouse.y)
     
        local torre = Torre(self.mouse.x, self.mouse.y)
        table.insert(self.towers, torre)

    elseif (not love.mouse.isDown(1)) then
        self.clickou = false
    end
    --Faz um for de 0 a 10, e a cada iteração, chama a função spawnEnemy
    if #wave==0 then
        for i = 1, 2 do
            self:spawnEnemy()
        end
    end
   
    mapa.posicaoMouse = self.mouse
    mapa:update(dt)

    if wave then
        for i, enemy in ipairs(wave) do
            enemy:update(dt)
        end
    end

    for i, torre in ipairs(self.towers) do
        torre:update(dt,wave)
    end

end


function Jogo:draw()
    
    mapa:draw()
    -- if path then
    --     for i, node in ipairs(path) do
    --         love.graphics.setColor(0, 0, 255)
    --         print(#path)

    --         if mapa.area[node.y-1][node.x] == TERRA then
    --             love.graphics.rectangle("fill", ((node.x-1)*64)-32, ((node.y-1)*64)-32, 64, 64)
    --         elseif mapa.area[node.y+1][node.x] == TERRA then
    --             love.graphics.rectangle("fill", ((node.x-1)*64)-32, ((node.y-1)*64)+32, 64, 64)
    --         else
    --             love.graphics.rectangle("fill", ((node.x-1)*64)+32, ((node.y-1)*64), 64, 64)
    --         end
    --     end
    --     love.graphics.setColor(1, 1, 1)
    -- end

    if wave then
        for i, enemy in ipairs(wave) do
            enemy:draw()
        end
    end

    for i, torre in ipairs(self.towers) do
        torre:draw()
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

function Jogo:spawnEnemy()
    local enemy = Personagem()
    table.insert(wave, enemy)
end
