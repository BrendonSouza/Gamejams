Torre = Classe:extend()


function Torre:new(x,y)
    self.posicao = Vetor(x,y)
    self.tiros = {}
    self.cooldown = 1
    self.enemyInRange = nil
    self.debug = 0
    self.timer = 0
end

function Torre:update(dt)
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

   

end

function Torre:draw()
    love.graphics.circle("fill", ((self.posicao.x-1)*64)+32, ((self.posicao.y-1)*64)+32, 16)
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

    local angulo = math.atan2(
        self.enemyInRange.posicao.y * 64 - self.posicao.y * 64,
        self.enemyInRange.posicao.x * 64 - self.posicao.x * 64
    )
    local tiro = Tiro(self.posicao.x, self.posicao.y, Vetor(math.cos(angulo), math.sin(angulo)))
    table.insert(self.tiros, tiro)
end
