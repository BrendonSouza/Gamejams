Enemy = Classe:extend()

function Enemy:new()
    self.height = 50
    self.width = 50
    self.position = Vetor(LARGURA_TELA/2, ALTURA_TELA/2)
    self.collider = world:newBSGRectangleCollider(self.position.x, self.position.y, self.width, self.height,1)
    self.collider:setFixedRotation(true)
    self.collider:setLinearDamping(2)
    self.spriteSheet = love.graphics.newImage("crab-sprite.png")
    self.granades = {}
    self.temporizadorAtack = 0
    -- self.collider:setCollisionClass("Enemy")

end

function Enemy:update(dt)
    self.temporizadorAtack = self.temporizadorAtack + dt
    if(self.temporizadorAtack > 1) then
        self:disparaGranada()
        self.temporizadorAtack = 0
    end
    self.position.x, self.position.y = self.collider:getPosition()
end


function Enemy:draw()
    love.graphics.rectangle("fill", self.position.x- self.width/2, self.position.y - self.height/2, self.width, self.height)
end

function Enemy:disparaGranada()
    local granada = world:newCircleCollider(self.position.x, self.position.y, 5)
    --faz umm lançamento oblíquo
    granada:setLinearVelocity(100, -500)
    granada:applyAngularImpulse(7000)
end


