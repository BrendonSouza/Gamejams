Player = Classe:extend()

function Player:new()
    self.height = 50
    self.width = 50
    self.position = Vetor(LARGURA_TELA/2, ALTURA_TELA - self.height)
    self.collider = world:newRectangleCollider(350, 100, 80, 80)
  
end

function Player:update(dt)

    local px, py = self.collider:getLinearVelocity()
    if love.keyboard.isDown("left")  and px> -300 then
        self.collider:applyForce(-5000, 0)
    end
    if love.keyboard.isDown("right")and px< 300 then
        self.collider:applyForce(5000, 0)
    end

  
 

end

function love.keypressed(key)
    if key == "up" then
        player.collider:applyLinearImpulse(0, -5000)
    end
end

function Player:draw()
end
