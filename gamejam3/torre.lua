Torre = Classe:extend()


function Torre:new(x,y)
    self.posicao = Vetor(x,y)
    self.tiros = {}
end

function Torre:update(dt)
  

end

function Torre:draw()
    love.graphics.circle("fill", (self.posicao.x-1)*64, (self.posicao.y-1)*64, 16)
   
end









