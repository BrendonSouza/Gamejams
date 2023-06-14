Player = Classe:extend()

function Player:new(player_number)
    self.player_number = player_number
    self.width = 0
    self.height = 0
    self.x = 0
    self.y = 0
    self.pontos =0
    self.aceleracao = 200
    self.curve = false
    self.direcao = 0
    self.joysticks = love.joystick.getJoysticks()
    if player_number == 1 then
        self.width = 100
        self.height = 20

        self.x = LARGURA_TELA / 2 - self.width / 2
        self.y = 130
    elseif player_number == 2 then
        self.width = 20
        self.height = 100
        
        self.x = 230
        self.y = ALTURA_TELA / 2 - self.height / 2
    elseif player_number == 3 then
      self.width = 100
      self.height = 20

      self.x = LARGURA_TELA / 2 - self.width / 2
      self.y = ALTURA_TELA - 150
  elseif player_number == 4 then
    self.width = 20
    self.height = 100
    
    self.x = LARGURA_TELA -self.width-230
    self.y = ALTURA_TELA / 2 - self.height / 2
  end

end

function Player:update(dt)
  self.direcao = 0    
  self.curve = false
  if self.player_number % 2 == 0 then
    if love.keyboard.isDown("space") then
      self.curve =true
    end
    if love.keyboard.isDown("w") then
      self.y = self.y+(-self.aceleracao)*dt
      self.direcao = -1
    elseif love.keyboard.isDown("s") then
        self.y = self.y+(self.aceleracao)*dt
        self.direcao = 1
    end

  else
    if love.keyboard.isDown("a") then
        self.x = self.x-self.aceleracao*dt
        self.direcao = -1
    elseif love.keyboard.isDown("d") then
        self.x = self.x+self.aceleracao*dt
        self.direcao = 1
    end
    
  end

end

function Player:draw()
  love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
  love.graphics.print(self.pontos,self.x,self.y-20)
end
