Torre = Classe:extend()


function Torre:new(x,y)
    
    self.base = love.graphics.newImage("assets/towerBase.png")
    self.topo = love.graphics.newImage("assets/tower1.png")
    self.posicao = Vetor(x,y)
    self.tiros = {}
    self.cooldown = 1
    self.enemyInRange = nil
    self.debug = 0
    self.timer = 0
    self.angulo = 0
    self.dano = love.math.random(10, 20)
end

function Torre:update(dt)
    love.math.setRandomSeed(os.time())
    self.dano = love.math.random(15, 30)
    self.cooldown = self.cooldown - dt
    self.timer = self.timer + dt
   
    self:enemyOnRange()
    if   self.cooldown<=0 and self.enemyInRange ~= nil  then

        self:atirar()
        self.cooldown = 1
    end

    
    for i = #self.tiros, 1, -1 do
        self.tiros[i]:update(dt)
        if self.tiros[i].posicao:dist(self.posicao) > 13 then
            table.remove(self.tiros, i)
        end
    end

    self:verificaSeAcertouInimigo()
   

end

function Torre:draw()
    love.graphics.draw(self.base, (self.posicao.x-1)*64, (self.posicao.y-1)*64)
    love.graphics.draw(self.topo, ((self.posicao.x-1)*64)+32, ((self.posicao.y-1)*64)+32,math.atan2(math.cos(-self.angulo), math.sin(-self.angulo)),1,1,32,32)
    -- love.graphics.circle("fill", ((self.posicao.x-1)*64)+32, ((self.posicao.y-1)*64)+32, 16)
    -- love.graphics.print(#self.tiros, ((self.posicao.x-1)*64), ((self.posicao.y-1)*64))

    for i, tiro in ipairs(self.tiros) do
        tiro:draw()
    end

   
    self.debug = 0
end

function Torre:enemyOnRange()
   
    self.enemyInRange = nil
    for i, enemy in ipairs(wave) do
        if math.floor(self.posicao:dist(enemy.posicao)) <3 then
            if self.enemyInRange == nil then
                self.enemyInRange = enemy
            elseif self.enemyInRange.posicao:dist(self.posicao) > enemy.posicao:dist(self.posicao) then
                    self.enemyInRange = enemy
            end
            
        end
    end
end

function Torre:atirar() 

     self.angulo = math.atan2(
        self.enemyInRange.posicao.y * 64 - self.posicao.y * 64,
        self.enemyInRange.posicao.x * 64 - self.posicao.x * 64
    )
    local tiro = Tiro(self.posicao.x, self.posicao.y, Vetor(math.cos(self.angulo), math.sin(self.angulo)))
    table.insert(self.tiros, tiro)
end


function Torre:verificaSeAcertouInimigo()
    for i, enemy in ipairs(wave) do
        for j, tiro in ipairs(self.tiros) do
            if enemy.posicao:dist(tiro.posicao) <0.4 then
                enemy.health = enemy.health - self.dano
                if(enemy.health <= 0) then
                    table.remove(wave, i)
                    moedas = moedas + math.random(2,5)
                end
                table.remove(self.tiros, j)
            end
        end
    end
end

