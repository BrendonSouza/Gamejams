Player = Classe:extend()

function Player:new()
    self.height = 50
    self.width = 50
    self.position = Vetor(LARGURA_TELA/2, ALTURA_TELA/2)
    self.collider = world:newBSGRectangleCollider(self.position.x, self.position.y, self.width, self.height,1)
    self.collider:setFixedRotation(true)
    self.collider:setLinearDamping(2)
    -- self.collider:setCollisionClass("Player")
  
end

function Player:update(dt)

    local px, py = self.collider:getLinearVelocity()
    if love.keyboard.isDown("left")  and px> -300 then
        self.collider:applyForce(-5000, 0)
    end
    if love.keyboard.isDown("right")and px< 300 then
        self.collider:applyForce(5000, 0)
    end

    self.position.x, self.position.y = self.collider:getPosition()
  
 

end

function love.keypressed(key)
    if key == "up" then
        player.collider:applyLinearImpulse(0, -5000)
    end
end

function Player:draw()
    
    love.graphics.rectangle("fill", self.position.x- self.width/2, self.position.y - self.height/2, self.width, self.height)
end
