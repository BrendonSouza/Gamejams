Jogo = Classe:extend()

function Jogo:new()
    player = Player()
    Enemy = Enemy(1030,155)
    gameStatus = "menu"
    grounds = {}
    traps = {}
    -- self:loadingLayers()
    peixes = {}
   
    serras = {}
    self.fase = 1
    self.timer = 60
    self.cronometro = 0
    self.gameOver = false
    self.vezesJogada = 0
    self:carregaPeixes()
    self.reset = false
end

function Jogo:update(dt)
    
   
    if (gameStatus == "loading") then
        

        if(self.fase ==1) then
            gameMap =  sti("maps/mapa_duas_fases.lua")
            
        elseif(self.fase == 2) then
            gameMap =  sti("maps/mapa_serras.lua")
            table.insert(serras,1, Serra(100,100,50,610))
            table.insert(serras,2, Serra(550,100,600,1300))
            self:resetPlayer()

        end
        
        self:loadingLayers()
        gameStatus = "jogando"
    end
    if(gameStatus == "jogando") then
        player:update(dt)
        if player.health <= 0 then
            gameStatus = "gameOver"
        end
    
        local h = love.graphics.getHeight()

        cam:lookAt(player.position.x + 200, h/2 )

        local w = love.graphics.getWidth()
        if(cam.x < w/2) then
            cam.x = w/2
        end

        local mapw = gameMap.width * gameMap.tilewidth
        if(cam.x > (mapw - w/2)) then
            cam.x = mapw - w/2
        end
        if(self.fase == 1) then
            Enemy:update(dt)
            self:capturouPeixe()
            for i, peixe in ipairs(peixes) do
                peixe:update(dt)
            end
            
            if player.quantidadePeixes >=5 then
                self.fase = 2
                gameStatus = "loading"
                loadWorld()
            end
        end
        if(self.fase == 2) then
            self:fase2(dt)
            for i, serra in ipairs(serras) do
                serra:update(dt)
            end
        end
    end
    if gameStatus == "gameOver" then
        if self.reset == true then
            gameStatus = "loading"
            self.gameOver = false
            self.timer = 60
            self.cronometro = 0
            world:destroy()
            loadWorld()
            
            if(self.fase == 1) then
                Enemy.collider =  world:newBSGRectangleCollider(Enemy.posicao.x, Enemy.posicao.y, 20, 15,3)
                Enemy.collider:setType('static')
                Enemy.collider:setFixedRotation(true)
                self:resetPlayer()
                peixes = {}
                player.quantidadePeixes = 0
                print(player.quantidadePeixes)
                self:carregaPeixes()
            end

            if self.fase == 2 then
                serras ={}
            end
            self.reset = false
        end
    end

end

function Jogo:draw()
    if(gameStatus == "menu") then
        self:drawMenu()
    elseif(gameStatus == "jogando") then
        gameMap:drawLayer(gameMap.layers["background"])
        gameMap:drawLayer(gameMap.layers["caminho"])
        gameMap:drawLayer(gameMap.layers["objetos"])
        player:draw()
        if(self.fase == 1) then   
            Enemy:draw()
            for i, peixe in ipairs(peixes) do
                peixe:draw()
            end
        end
        if(self.fase == 2) then
            for i, serra in ipairs(serras) do
                serra:draw()
            end

        end
    end
end





function Jogo:loadingLayers()
    if gameMap.layers["chao"] then
        for i, obj in pairs(gameMap.layers["chao"].objects) do
            grounds[i] = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            grounds[i]:setCollisionClass("Chao")
            grounds[i]:setType('static')
            table.insert(grounds, grounds[i])
        end
    end
    if gameMap.layers["armadilhas"] then
        for i, obj in pairs(gameMap.layers["armadilhas"].objects) do
            traps[i] = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            traps[i]:setType('static')
            traps[i]:setCollisionClass("Armadilha")
            table.insert(traps, traps[i])

        end
    end
    if gameMap.layers["bombas"] then
        for i, obj in pairs(gameMap.layers["bombas"].objects) do
            traps[i] = world:newCircleCollider(obj.x + (obj.width/2), obj.y + (obj.height/2), obj.width/2)
            traps[i]:setType('static')
            traps[i]:setCollisionClass("Bomba")
            table.insert(traps, traps[i])
        end
    end
end

function Jogo:destroyLayers()
    for i, ground in ipairs(grounds) do
        grounds[i]:destroy()
        table.remove(grounds, i)

    end
    for i, trap in ipairs(traps) do
        traps[i]:destroy()
        table.remove(traps, i)
    end
end


function Jogo:capturouPeixe()
    for i, peixe in ipairs(peixes) do
        if not peixe.isCapturado and player.collider:isTouching(peixe.collider.body) then
            peixe.isCapturado = true
            player.quantidadePeixes = player.quantidadePeixes + 1
            peixe.collider:destroy()
            table.remove(peixes, i)
        end
    end
end


function Jogo:carregaPeixes()
    table.insert(peixes,Peixe(13,210))
    table.insert(peixes,Peixe(279,535))
    table.insert(peixes,Peixe(827,263))
    table.insert(peixes,Peixe(1150,569))
    table.insert(peixes,Peixe(1207,172))
end


function Jogo:fase2(dt)
    --sort a number between 100 and 1300
    self.timer = self.timer - dt
    local x = math.random(100,1300)
    if x< 1300 then
        x = x-100
    end
    self.cronometro = self.cronometro + dt
    if(self.cronometro > 40) then
        table.insert(serras, Serra(x,100,50,1300))
        self.cronometro = -200
    end

    if self.timer <0 then
        gameStatus = "Win"
    end
end



function Jogo:resetPlayer()
    love.graphics.setDefaultFilter("nearest", "nearest")
    player.position = Vetor(LARGURA_TELA/2, ALTURA_TELA/2)

    player.collider = world:newBSGRectangleCollider(player.position.x, player.position.y, 20, 13,1)
    player.collider:setFixedRotation(true)
    player.collider:setLinearDamping(2)

    player.truePosition = Vetor(player.position.x, player.position.y)
    player.lastDirection = "right"
    player.collider:setCollisionClass('Player')
    player.estaNoChao = true
    player.quantidadePeixes = 0
    player.health =7
end

