Jogo = Classe:extend()

function Jogo:new()
    self.player1 = Player(1)
    self.player2 = Player(2)
    self.player3 = Player(3)
    self.player4 = Player(4)
    self.bola =  Bola()    
end

function Jogo:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)
    self.player3:update(dt)
    self.player4:update(dt)
    self.bola:update(dt)
    self:detectaColisaoComPlayers()

end

function Jogo:draw()
    self.player1:draw()
    self.player2:draw()
    self.player3:draw()
    self.player4:draw()
    self.bola:draw()
end

function Jogo:detectaColisaoComPlayers()
    if (self.bola.x > self.player2.x and  self.bola.x < self.player2.x +self.player2.width and self.bola.y > self.player2.y and  self.bola.y < self.player2.y +self.player2.height)  then
        self.bola.x= self.player2.x + self.player2.width
        if (self.bola.direcao.y + self.player2.direcao)^2 ~= 4  then
            self.bola.direcao.y = self.player2.direcao
        end
        if(self.player2.curve)then
            print("xd curva")
        end

        self.bola.direcao.x = -(self.bola.direcao.x)
        
        print(self.bola.direcao.y, self.player2.direcao)
    elseif (self.bola.x > self.player1.x and  self.bola.x < self.player1.x +self.player1.width and self.bola.y > self.player1.y and  self.bola.y < self.player1.y +self.player1.height)or (self.bola.x > self.player1.x and  self.bola.x < self.player1.x +self.player1.width and self.bola.y > self.player1.y and  self.bola.y < self.player1.y +self.player1.height) then
        self.bola.y= self.player1.y + self.player1.height

        if (self.bola.direcao.x + self.player1.direcao)^2 ~= 4  then
            self.bola.direcao.x = self.player1.direcao
        end

        self.bola.direcao.y = -(self.bola.direcao.y)
    elseif (self.bola.x > self.player3.x and  self.bola.x < self.player3.x +self.player3.width and self.bola.y > self.player3.y and  self.bola.y < self.player3.y +self.player3.height)or (self.bola.x > self.player3.x and  self.bola.x < self.player3.x +self.player3.width and self.bola.y > self.player3.y and  self.bola.y < self.player3.y +self.player3.height) then
        self.bola.y= self.player3.y - self.player3.height

        if (self.bola.direcao.x + self.player3.direcao)^2 ~= 4  then
            self.bola.direcao.x = self.player3.direcao
        end

        self.bola.direcao.y = -(self.bola.direcao.y)
    elseif (self.bola.x > self.player4.x and  self.bola.x < self.player4.x +self.player4.width and self.bola.y > self.player4.y and  self.bola.y < self.player4.y +self.player4.height) then
        self.bola.x= self.player4.x - self.player4.width
        if (self.bola.direcao.y + self.player4.direcao)^2 ~= 4  then
            self.bola.direcao.y = self.player4.direcao
        end

        self.bola.direcao.x = -(self.bola.direcao.x)
    
    end
end