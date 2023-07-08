Serra = Classe:extend()

function Serra:new(x,y, rangeX1, rangeX2)
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.position = Vetor(x,y-30)
    self.spritesheet = love.graphics.newImage("assets/serras.png")
    self.grid = Anim8.newGrid(128, 128, self.spritesheet:getWidth(), self.spritesheet:getHeight(),3)
    self.animation = Anim8.newAnimation(self.grid('1-2',1), 0.1)
    self.collider = world:newCircleCollider(self.position.x, self.position.y,25)
    self.collider:setCollisionClass('Serra')
    self.collider:setFixedRotation(true)
    self.rangeInferior = rangeX1
    self.rangeSuperior = rangeX2
    self.direcao = -1
    self.velocidade = 3000

 
end

function Serra:update(dt)

 
    local px, py = self.collider:getLinearVelocity()
    
    self.animation:update(dt)
    if self.position.x>= self.rangeSuperior and px> -600 then
        self.direcao = -1
    elseif self.position.x<=self.rangeInferior and px< 600 then
        self.direcao = 1
    end
    if self.collider:enter("Serra") or self.collider:enter("Parede")  then
        self.direcao = -self.direcao 
        self.collider:setRestitution(0.7)
    end
    if(self.collider:enter("Player")) then
       player.health = player.health - 1
    end

    self.collider:applyForce(self.velocidade*self.direcao,0)
    self.position.x, self.position.y = self.collider:getPosition()

end



function Serra:draw()
 
    self.animation:draw(self.spritesheet, self.position.x-25, self.position.y-25,nil,0.4,0.4)
    

end




