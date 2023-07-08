Player = Classe:extend()

function Player:new()
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.position = Vetor(LARGURA_TELA/2, ALTURA_TELA/2)
    self.height = 50
    self.width = 50
    self.scaleX = 4
    self.health = 7
    self.collider = world:newBSGRectangleCollider(self.position.x, self.position.y, 20, 13,1)
    self.collider:setFixedRotation(true)
    self.collider:setLinearDamping(2)

    self.spritesheet = love.graphics.newImage("assets/gato.png")
    self.grid = Anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.animations = {}
    self.animations.run = Anim8.newAnimation(self.grid('1-4',4), 0.1)
    self.status = "idle"
    self.animations.idle = Anim8.newAnimation(self.grid('1-4',1), 0.12)
    self.animations.jump = Anim8.newAnimation(self.grid('1-4',11), 0.1)
    self.aceleracao = Vetor(500,480)
    self.truePosition = Vetor(self.position.x, self.position.y)
    self.lastDirection = "right"
    self.collider:setCollisionClass('Player')
    self.estaNoChao = true
    self.quantidadePeixes = 0
  
end

function Player:update(dt)
    local px, py = self.collider:getLinearVelocity()
    if love.keyboard.isDown("left") and px> -300 then
        self.collider:applyForce(-self.aceleracao.x, 0)
        self.animations.run:update(dt)
        self.scaleX = -4
        self.lastDirection = "left"
        self.status = "runleft"
    elseif love.keyboard.isDown("right") and px< 300 then
        self.collider:applyForce(self.aceleracao.x, 0)
        self.animations.run:update(dt)
        self.status = "runRigth"
        self.lastDirection = "right"
        self.scaleX = 4
    else
            self.status = "idle"    
    end

    if self.status == "idle" then
        self.animations.idle:update(dt)
    end

    self.position.x, self.position.y = self.collider:getPosition()
    self:verificaColisao()
end

function Player:verificaColisao()
    if self.collider:enter("Chao") then
        self.estaNoChao = true
    end
    if self.collider:enter("Armadilha") then
        if(self.lastDirection == "left") then
            self.collider:applyLinearImpulse(100, -300)
        elseif(self.lastDirection == "right") then
            self.collider:applyLinearImpulse(-100, -300)
        end
     
        self.health = self.health - 1
    elseif self.collider:enter("Bomba") then

        if(self.lastDirection == "left") then
            self.collider:applyLinearImpulse(100,30)
      
        elseif(self.lastDirection == "right") then
            self.collider:applyLinearImpulse(-100,30)
        end
        self.health = self.health - 1
    end
    
end

function love.keypressed(key)
    if player.estaNoChao then
        if key == "up" then
            player.collider:applyLinearImpulse(0, -player.aceleracao.y)
            player.estaNoChao = false
        end
    end
end



function Player:draw()
   if self.scaleX == -4 then
        self.truePosition.x = self.position.x+30
        self.truePosition.y = self.position.y-55
    else
        self.truePosition.x = self.position.x-30
        self.truePosition.y = self.position.y-55
    end
    if(self.status == "runleft") then
           self.animations.run:draw(self.spritesheet, self.position.x +32, self.truePosition.y,nil,self.scaleX,4)

    elseif(self.status == "runRigth") then
        self.animations.run:draw(self.spritesheet, self.truePosition.x, self.truePosition.y,nil,self.scaleX,4)
    elseif(self.status == "idle") then
        self.animations.idle:draw(self.spritesheet, self.truePosition.x, self.truePosition.y,nil,self.scaleX,4)
    end


end



