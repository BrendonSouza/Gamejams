Peixe = Classe:extend()

function Peixe:new(x,y)
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.position = Vetor(x,y-30)
    self.spritesheet = love.graphics.newImage("assets/peixes.png")
    self.grid = Anim8.newGrid(64, 64, self.spritesheet:getWidth(), self.spritesheet:getHeight(),3)
    self.animation = Anim8.newAnimation(self.grid('1-2',1), 0.5)
    self.collider = world:newBSGRectangleCollider(self.position.x, self.position.y, 35, 20,3)
    self.collider:setCollisionClass('Peixe')
    self.collider:setFixedRotation(true)
    self.collider:setType('static')
    self.isCapturado = false
 
end

function Peixe:update(dt)
    self.animation:update(dt)
end



function Peixe:draw()
 
    self.animation:draw(self.spritesheet, self.position.x-5, self.position.y-15,nil,0.7,0.7)
    

end




