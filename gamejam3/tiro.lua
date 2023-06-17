Tiro = Classe:extend()


function Tiro:new(x,y,direcao)
    self.posicao = Vetor(x,y)
    self.direcao = Vetor(direcao.x,direcao.y)*10
    self.velocidade = 2
  
end

function Tiro:update(dt)
    self.posicao = self.posicao + self.direcao * dt 

end

function Tiro:draw()
    love.graphics.circle("fill", (self.posicao.x*64)-32, (self.posicao.y*64)-32, 8)
end














