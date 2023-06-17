Torre = Classe:extend()


function Torre:new(x,y)
    self.posicao = Vetor(x,y)
    self.tiros = {}
    self.cooldown = 0
end

function Torre:update(dt)
    self.cooldown = self.cooldown - dt
    
    if self:enemyOnRange() and self.cooldown<=0   then
       
        self:atirar()
        self.cooldown = 1
        
    end
    for i = #self.tiros, 1, -1 do
        self.tiros[i]:update(dt)
        if self.tiros[i].posicao:dist(self.posicao) > 6 then
            table.remove(self.tiros, i)
        end
    end

end

function Torre:draw()
    love.graphics.circle("fill", ((self.posicao.x-1)*64)+32, ((self.posicao.y-1)*64)+32, 16)
    for i = 1, #self.tiros do
        self.tiros[i]:draw()
    end
end

function Torre:enemyOnRange()
   if math.floor(self.posicao:dist(p1.posicao)) <3 then
        return true
   end
   return false
end

function Torre:atirar() 
    local angulo = math.atan2(p1.posicao.y*64 - self.posicao.y*64, p1.posicao.x*64 - self.posicao.x*64)
    local tiro = Tiro(self.posicao.x,self.posicao.y, Vetor(math.cos(angulo), math.sin(angulo)))
    table.insert(self.tiros, tiro)
end
