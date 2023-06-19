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
    moedas = 100
    self.waveProperties = {velocidade = 0.5, health=100}
    self.clickou = false
    self.countdownWave = 0
    self.countWave =0
    vidas = 10
    self.statusJogo = "Menu Inicial"
end

function Jogo:update(dt)
    if(self.statusJogo == "Menu Inicial") then
        if(love.keyboard.isDown("space")) then
            self.statusJogo = "Jogando"
        end
    elseif(self.statusJogo == "Jogando") then
        self.countdownWave = self.countdownWave - dt
        self.mouse.x = math.floor(love.mouse.getX()/64) + 1
        self.mouse.y = math.floor(love.mouse.getY()/64) + 1
        if(love.mouse.isDown(1) and not self.clickou and not mapa.posicaoInvalida and moedas>30) then
            self.clickou = true     
            local torre = Torre(self.mouse.x, self.mouse.y)
            table.insert(self.towers, torre)
            moedas = moedas - 30
        elseif (not love.mouse.isDown(1)) then
            self.clickou = false
        end
       
        if self.countdownWave<=0 or #wave ==0 then
            self.countWave = self.countWave + 1
            self:spawnWave()
            self.waveProperties.velocidade = (self.waveProperties.velocidade * self.waveProperties.velocidade)+0.5
            self.countdownWave = 50
        end

      
    
        mapa.posicaoMouse = self.mouse
        mapa:update(dt)

        if wave then
            for i, enemy in ipairs(wave) do
                enemy:update(dt)
                if enemy.pos_path == #path then
                    table.remove(wave, i)
                    vidas = vidas - 1
                end
            end
        end

        for i, torre in ipairs(self.towers) do
            torre:update(dt,wave)
        end
    end
       
    if vidas <= 0 or self.countWave > 5 then
        self.statusJogo = "Game Over"
    end

end


function Jogo:draw()
    love.graphics.setFont(love.graphics.newFont("assets/fonte.ttf",15))
    mapa:draw()
    if(self.statusJogo == "Jogando") then
        if wave then
            for i, enemy in ipairs(wave) do
                enemy:draw()
            end
        end
        for i, torre in ipairs(self.towers) do
            torre:draw()
        end
        love.graphics.print("Moedas: "..moedas, 10, 10)
        love.graphics.print("Tempo para próxima wave: "..math.floor(self.countdownWave), 600, 10)
        love.graphics.print("Vidas: "..vidas, 10, 30)
        -- love.graphics.print("velocidade: "..self.waveProperties.velocidade, 10, 50)
        love.graphics.print("Wave: "..self.countWave, 10, 50)
    end
    if(self.statusJogo == "Menu Inicial") then
        love.graphics.print("Pressione espaço para iniciar", 300, 300)
    end
    if(self.statusJogo == "Game Over") then
        if self.countWave == 6 then
            love.graphics.print("Você venceu!", 400, 300)
        else
            love.graphics.print("Game Over", 400, 300)
        end
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

function Jogo:spawnWave()
    if(self.countWave % 2 ==0) then
        self.waveProperties.velocidade = self.waveProperties.velocidade *1.2
        self.countdownWave = 35
    else
        self.waveProperties.velocidade = self.waveProperties.velocidade *0.7
    end
    for i = 1, 10 do
        local enemy = Personagem(self.waveProperties.velocidade, self.waveProperties.health)
        table.insert(wave, enemy)
    end
    self.waveProperties.health = self.waveProperties.health + 20
end

