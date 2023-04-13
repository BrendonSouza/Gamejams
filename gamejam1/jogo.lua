Jogo = Classe:extend()
--import cenario
require "cenario"
require "personagem"
function Jogo:new()
    self.cenario = Cenario()
    self.player1 = Personagem(30,350,1)
    self.player2 = Personagem(470,350,2)
end

function Jogo:update(dt)
    self.cenario:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)
end

function Jogo:draw()
    self.cenario:draw()
    self.player1:draw()
    self.player2:draw()
end
