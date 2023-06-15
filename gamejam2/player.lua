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
    self.animations = {}

    if player_number == 1 then
        self.width = 96
        self.height = 20
        self.sprite = love.graphics.newImage("assets/fence-hor.png")
        self.x = LARGURA_TELA / 2 - self.width / 2
        self.y = 130
        self.spriteSheet = love.graphics.newImage("assets/NPC12.png")

    elseif player_number == 2 then
        self.width = 20
        self.height = 96
        self.sprite = love.graphics.newImage("assets/fence-vert.png")
        self.spriteSheet = love.graphics.newImage("assets/NPC22.png")
        self.x = 230
        self.y = ALTURA_TELA / 2 - self.height / 2
    elseif player_number == 3 then
      self.width = 96
      self.height = 20
      self.sprite = love.graphics.newImage("assets/fence-hor.png")
      self.spriteSheet = love.graphics.newImage("assets/NPC31.png")

      self.x = LARGURA_TELA / 2 - self.width / 2
      self.y = ALTURA_TELA - 150
  elseif player_number == 4 then
    self.width = 20
    self.height = 96
    self.sprite = love.graphics.newImage("assets/fence-vert.png")
    self.spriteSheet = love.graphics.newImage("assets/NPC31.png")

    self.x = LARGURA_TELA -self.width-230
    self.y = ALTURA_TELA / 2 - self.height / 2
  end
  self.grid = Anim8.newGrid(250, 250, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())

  self.animations.up = Anim8.newAnimation(self.grid('1-4', 2), 0.2)
  self.animations.down = Anim8.newAnimation(self.grid('1-4', 1), 0.2)
  self.animations.right = Anim8.newAnimation(self.grid('1-2', 4), 0.2)
  self.animations.left = Anim8.newAnimation(self.grid:getFrames('1-2', 3), 0.2)
  self.isMoving = false
  self.anim = self.animations.left
  self.anim:gotoFrame(1)

end

function Player:update(dt)
  self.isMoving = false
  self.direcao = 0    
  self.curve = false
  if self.player_number % 2 == 0 then
    if love.keyboard.isDown("space") then
      self.curve =true
    end
    if love.keyboard.isDown("w") then
      self.y = self.y+(-self.aceleracao)*dt
      self.direcao = -1
      self.anim = self.animations.up
      self.isMoving = true
    elseif love.keyboard.isDown("s") then
        self.y = self.y+(self.aceleracao)*dt
        self.direcao = 1
        self.anim = self.animations.down
        self.isMoving = true
    end

  else
    if love.keyboard.isDown("a") then
        self.x = self.x-self.aceleracao*dt
        self.direcao = -1
        self.anim = self.animations.left
        self.isMoving = true
    elseif love.keyboard.isDown("d") then
        self.x = self.x+self.aceleracao*dt
        self.direcao = 1
        self.anim = self.animations.right
        self.isMoving = true
    end
  end

  if self.isMoving == false then
    self.anim:gotoFrame(1)
  end

  self.anim:update(dt)
end

function Player:draw()
  -- love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
  love.graphics.draw(self.sprite, self.x, self.y)
  if(self.player_number ==1) then
    self.anim:draw(self.spriteSheet, self.x+10, self.y-60, nil, 0.3)
  elseif (self.player_number ==2) then
    self.anim:draw(self.spriteSheet, self.x-50, self.y, nil, 0.3)
  else
    self.anim:draw(self.spriteSheet, self.x, self.y, nil, 0.3)
  end
  love.graphics.print(tostring(self.isMoving),self.x,self.y-20)
end
