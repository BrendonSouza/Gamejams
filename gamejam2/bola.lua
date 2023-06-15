Bola = Classe:extend()
function Bola:new()
    self.y = ALTURA_TELA/2
    self.x = LARGURA_TELA/2
    self.raio = 10
    self.curva = false
    self.velocidade_rotacao = 0 
    self.direcao = Vetor(-1,0)
    self.velocidade_maxima = 2
    self.aceleracao = 0
    self.direcaoPlayer = 0
    self.lastPlayerTouched = 0
    self.spriteSheet = love.graphics.newImage("assets/ball2.png")

    self.animations = {}
    self.grid = Anim8.newGrid(198, 198, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations.rollForward = Anim8.newAnimation(self.grid('1-2', 1, '1-2', 2), 0.2)
    self.animation = self.animations.rollForward
    self.statusBola ="movimento"
    -- self.direcaoInicial = love.math.random(1,2)


end

function Bola:update(dt)
    

    if self.statusBola == "movimento" then


    if self.aceleracao < self.velocidade_maxima then
        self.aceleracao = self.aceleracao + dt
    end

    if self.curva and self.velocidade_rotacao > 0 then
        local angulo = self.velocidade_rotacao * dt
        self.direcao:rotate(angulo *self.direcaoPlayer)
        self.aceleracao = self.velocidade_maxima

    end

    self.x = self.x + self.direcao.x * self.aceleracao
    self.y = self.y + self.direcao.y * self.aceleracao
    self.animation:update(dt)
end
end



function Bola:draw()
    -- love.graphics.circle("fill",self.x,self.y,self.raio)
    self.animation:draw(self.spriteSheet, self.x-18, self.y-18, nil, 0.2)
end



function Bola:reset()
    self.x = LARGURA_TELA/2
    self.y = ALTURA_TELA/2
    self.aceleracao = 0
    self.velocidade_rotacao = 0
    self.direcao = Vetor(-1,0)
    self.statusBola = "movimento"
end
