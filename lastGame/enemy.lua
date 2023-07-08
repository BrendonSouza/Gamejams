Enemy = Classe:extend()

function Enemy:new(x,y)
    self.posicao = Vetor(x,y)
    self.aceleracao = Vetor(80,0)
    self.collider = world:newBSGRectangleCollider(self.posicao.x, self.posicao.y, 20, 15,3)
    self.spritesheet = love.graphics.newImage("assets/enemy.png")
    self.collider:setFixedRotation(true)
    self.collider:setType('static')
    self.grid = Anim8.newGrid(24, 24, self.spritesheet:getWidth(), self.spritesheet:getHeight(),3)
    self.animacao = {}
    self.animacao.fly = Anim8.newAnimation(self.grid('1-3',1), 0.13)
    self.direcao = -1

end

function Enemy:update(dt)

    if self.posicao.x >= 1350 then
        self.direcao = -1
    elseif self.posicao.x <= 930 then
        self.direcao = 1
    end
    self.posicao.x = self.posicao.x + self.aceleracao.x*self.direcao * dt
    self.collider:setPosition(self.posicao.x, self.posicao.y)
    self.animacao.fly:update(dt)
end


function Enemy:draw() 
    self.animacao.fly:draw(self.spritesheet, self.posicao.x-(12*self.direcao), self.posicao.y-15,nil,1*self.direcao,1)
end
