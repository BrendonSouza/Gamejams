Jogo = Classe:extend()

function Jogo:new()
    self.player1 = Player(1)
    self.player2 = Player(2)
    self.player3 = Player(3)
    self.player4 = Player(4)
    self.bolas = {}
    self.bola =  Bola()
    self.statusGame = "jogando"
    self.bg = love.graphics.newImage("assets/mapa.png")
    self.timer = 120
    self.count =0
end

function Jogo:update(dt)
    if self.statusGame == "jogando" then
        self.player1:update(dt)
        self.player2:update(dt)
        self.player3:update(dt)
        self.player4:update(dt)
        self.bola:update(dt)
        self:detectaColisaoComAsParedes()
        self:detectaColisaoComPlayers()
        self:detectaPonto()
        self:detectaColisaoPlayersParedes()
    end
    if(self.statusGame =="goal") then
        self.count = self.count + dt
        self.bola:reset()
        if(self.count > 2) then
            self.statusGame = "jogando"
            self.count = 0
        end
    end
    if(self.timer <= 0  or  self.player1.pontos >= 5 or self.player2.pontos >= 5 or self.player3.pontos >= 5 or self.player4.pontos >= 5) then
        self.statusGame = "fim"
    end

    if(self.statusGame == "fim") then
        self.count = self.count + dt
        if(self.count > 2) then
            love.event.quit()
        end
    end
end


function Jogo:draw()
    love.graphics.draw(self.bg, 0, 0)
    self.player1:draw()
    self.player2:draw()
    self.player3:draw()
    self.player4:draw()
    if self.statusGame == "jogando" then
        self.bola:draw()
    end
    if self.statusGame == "goal" then
        love.graphics.print("GOAL", LARGURA_TELA/2, ALTURA_TELA/2)
    end
end

function Jogo:detectaColisaoComPlayers()
    if (self.bola.x > self.player2.x and  self.bola.x < self.player2.x +self.player2.width and self.bola.y > self.player2.y and  self.bola.y < self.player2.y +self.player2.height)  then
        self.bola.x= self.player2.x + self.player2.width
        self.bola.curva = false
        self.bola.lastPlayerTouched = self.player2.player_number
        if (self.bola.direcao.y + self.player2.direcao)^2 ~= 4  then
            self.bola.direcao.y = self.player2.direcao
        end
        if self.player2.curve then
            self.bola.curva = true
            self.bola.direcaoPlayer = self.player2.direcao
            self.bola.velocidade_rotacao = 1.9  -- Ajuste a velocidade de rotação conforme necessário
        end
        self.bola.direcao.x = -(self.bola.direcao.x)

    elseif (self.bola.x > self.player1.x and  self.bola.x < self.player1.x +self.player1.width and self.bola.y > self.player1.y and  self.bola.y < self.player1.y +self.player1.height)or (self.bola.x > self.player1.x and  self.bola.x < self.player1.x +self.player1.width and self.bola.y > self.player1.y and  self.bola.y < self.player1.y +self.player1.height) then
        self.bola.y= self.player1.y + self.player1.height
        self.bola.curva = false
        self.bola.lastPlayerTouched = self.player1.player_number

        if (self.bola.direcao.x + self.player1.direcao)^2 ~= 4  then
            self.bola.direcao.x = self.player1.direcao
        end

        self.bola.direcao.y = -(self.bola.direcao.y)
    elseif (self.bola.x > self.player3.x and  self.bola.x < self.player3.x +self.player3.width and self.bola.y > self.player3.y and  self.bola.y < self.player3.y +self.player3.height)or (self.bola.x > self.player3.x and  self.bola.x < self.player3.x +self.player3.width and self.bola.y > self.player3.y and  self.bola.y < self.player3.y +self.player3.height) then
        self.bola.y= self.player3.y - self.player3.height
        self.bola.curva = false
        self.bola.lastPlayerTouched = self.player3.player_number

        if (self.bola.direcao.x + self.player3.direcao)^2 ~= 4  then
            self.bola.direcao.x = self.player3.direcao
        end
        print(self.bola.direcao.y, self.player3.direcao)

        self.bola.direcao.y = -(self.bola.direcao.y)
    elseif (self.bola.x > self.player4.x and  self.bola.x < self.player4.x +self.player4.width and self.bola.y > self.player4.y and  self.bola.y < self.player4.y +self.player4.height) then
        self.bola.curva = false
        self.bola.lastPlayerTouched = self.player4.player_number

        self.bola.x= self.player4.x - self.player4.width
        if (self.bola.direcao.y + self.player4.direcao)^2 ~= 4  then
            self.bola.direcao.y = self.player4.direcao
        end

        self.bola.direcao.x = -(self.bola.direcao.x)

    end
end

function Jogo:detectaColisaoComAsParedes()
    -- As paredes tem 250px de largura e 150px de altura
    if self.bola.x < 250 and self.bola.y < 150 then
        self.bola.y = 150
        self.bola.direcao.x = -(self.bola.direcao.x)
        self.bola.direcao.y = -(self.bola.direcao.y)
    elseif self.bola.x < 250 and self.bola.y > 450 then
        self.bola.y = 450
        self.bola.direcao.y = -(self.bola.direcao.y)
        self.bola.direcao.x = -(self.bola.direcao.x)
    elseif self.bola.x > 550 and self.bola.y < 150 then
        self.bola.y = 150
        self.bola.direcao.y = -(self.bola.direcao.y)
        self.bola.direcao.x = -(self.bola.direcao.x)
    elseif self.bola.x > 550 and self.bola.y > 450 then
        self.bola.y = 450
        self.bola.direcao.y = -(self.bola.direcao.y)
        self.bola.direcao.x = -(self.bola.direcao.x)
    end

end

function  Jogo:detectaPonto()
    if self.bola.x<220 or self.bola.x>580 or self.bola.y<120 or self.bola.y>480 then
        if self.bola.statusBola ~="scored" and self.statusGame ~= "goal" then
            self.statusGame = "goal"
            if self.bola.lastPlayerTouched == 1 then
                self.player1.pontos = self.player1.pontos + 1
                self.bola.statusBola ="scored"

            end
            if self.bola.lastPlayerTouched == 2 then
                self.player2.pontos = self.player2.pontos + 1
                self.bola.statusBola ="scored"

            end
            if self.bola.lastPlayerTouched == 3 then
                self.player3.pontos = self.player3.pontos + 1
                self.bola.statusBola ="scored"

            end
            if self.bola.lastPlayerTouched == 4 then
                self.player4.pontos = self.player4.pontos + 1
                self.bola.statusBola ="scored"

            end
        end
    end

end

function Jogo:detectaColisaoPlayersParedes()
    if self.player1.x < 250 or self.player3.x <250 then
        self.player1.x = 250
        self.player3.x = 250
    elseif self.player1.x + self.player1.width > 550 or self.player1.x + self.player3.width > 550 then
        self.player1.x = 550 - self.player1.width
        self.player3.x = 550 - self.player3.width
    end  
    if self.player2.y < 150 or  self.player4.y < 150 then
        self.player2.y = 150
        self.player4.y = 150
    elseif self.player2.y + self.player2.height > 450 or  self.player4.y + self.player4.height > 450 then
        self.player2.y = 450 - self.player2.height
        self.player4.y = 450 - self.player4.height
    end

end

