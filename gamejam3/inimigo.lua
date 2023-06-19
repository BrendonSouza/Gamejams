Personagem = Classe:extend()

function Personagem:new(velocidade,health)
    self.healthMax = health
    self.img = love.graphics.newImage("assets/enemyD.png")
    self.posicao = self:sorteiaPosicao()
    self.health = self.healthMax
    self.pos_path = 0
    self.direcao = Vetor()
    self.velocidade = velocidade
    self.path = nil
end

function Personagem:update(dt)
    love.math.setRandomSeed(os.time())

    if path then
        if self.pos_path == #path then
            return
        end
        local path_vet = Vetor(path[self.pos_path+1].x, path[self.pos_path+1].y)
        self.direcao = path_vet - self.posicao

        if #path == self.pos_path then
            return
        end
        self.posicao = self.posicao + self.direcao:norm()*dt*self.velocidade

        if self.posicao:dist(path_vet) < 2/64 then
            self.posicao = path_vet
            self.pos_path = self.pos_path +1
        end
        if(self.direcao == Vetor(1,0)) then
            self.img = love.graphics.newImage("assets/enemyD.png")
        elseif(self.direcao == Vetor(-1,0)) then
            self.img = love.graphics.newImage("assets/enemyE.png")
        elseif(self.direcao == Vetor(0,1)) then
            self.img = love.graphics.newImage("assets/enemyB.png")
        elseif(self.direcao == Vetor(0,-1)) then
            self.img = love.graphics.newImage("assets/enemyC.png")
        end
        
    end

end

function Personagem:draw()
  love.graphics.draw(self.img, (self.posicao.x-1)*64, (self.posicao.y-1)*64)
  if self.health<100 then
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", (self.posicao.x-1)*64, (self.posicao.y-1)*64-5, 64, 5)
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill", (self.posicao.x-1)*64, (self.posicao.y-1)*64-5, 64*(self.health/self.healthMax), 5)
    love.graphics.setColor(255,255,255)
  end

end

function Personagem:sorteiaPosicao()

    return Vetor(love.math.random(-1,-10), 8)
end

