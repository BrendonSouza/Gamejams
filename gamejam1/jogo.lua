Jogo = Classe:extend()
--import cenario
require "cenario"
require "personagem"
function Jogo:new()
    self.cenario = Cenario()
    self.player1 = Personagem(385,350,1)
    self.player2 = Personagem(390,350,2)
    self.statusGame = "awaiting"
    self.countdown = 3
end

function Jogo:update(dt)

    self.cenario:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)
    for i, tiro in ipairs(self.player1.tiros) do
        if(tiro.x > self.player2.x and tiro.x < self.player2.x + 30 and tiro.y > self.player2.y and tiro.y < self.player2.y + 30) then
            self.player1.pontos = self.player1.pontos + 1
            table.remove(self.player1.tiros, i)
        end
    end
    for i, tiro in ipairs(self.player2.tiros) do
        if(tiro.x > self.player1.x and tiro.x < self.player1.x + 30 and tiro.y > self.player1.y and tiro.y < self.player1.y + 30) then
           self.player2.pontos = self.player2.pontos + 1
            table.remove(self.player2.tiros, i)
        end
    end

    if(self.statusGame == "awaiting") then
        --move the player 1 to rigth
        if(self.player1.x > 20) then
            self.player1.x = self.player1.x - 1
            self.player2.x = self.player2.x + 1
        else
            self.statusGame = "countdown"
        end

    end


end

function Jogo:draw()
    self.cenario:draw()
    self.player1:draw()
    self.player2:draw()    
end


-- function Jogo:contagemRegressiva()
--     for i = self.countdown, 1, -1 do
--         self.countdown = i
--         -- chama uma função para atualizar a tela do jogo e exibir a contagem regressiva
--         -- por exemplo, você pode exibir o valor da contagem no centro da tela
--         love.graphics.print("COYUT"..self.statusGame,50, 50)
--         -- espera um segundo antes de continuar a contagem
        
--     end
-- end


