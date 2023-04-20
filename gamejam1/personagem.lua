Personagem = Classe:extend()

require "tiro"

function Personagem:new(x,y,player)
    self.x  = x
    self.y = y
    self.player = player
    if(self.player == 1) then
        self.spriteWalk = love.graphics.newImage("sprites/player1walk.png")
        self.spriteIdle = love.graphics.newImage("sprites/player1idle.png")
        
    else
        self.spriteWalk = love.graphics.newImage("sprites/player2walk.png")
        self.spriteIdle = love.graphics.newImage("sprites/player2idle.png")
    end

    self.frames = {}
    self.frames.idle = {}
    self.frames.walk = {}
    self.frames.shoot = {}
    self.frameAtual = 1
    self.spriteAtual = "idle"
    self.tempo=0
    self.tiros = {}

    carregaSprites(self)

end

function Personagem:update(dt)

    animaSprites(self,dt)
    if(self.player == 1) then
        if love.keyboard.isDown("w") then
            self.y = self.y - 1
            self.spriteAtual = "idle"
        end
        if love.keyboard.isDown("s") then
            self.y = self.y + 1
        end
        if love.keyboard.isDown("a") then
            self.x = self.x - 1
           
        end
        if love.keyboard.isDown("d") then
            self.x = self.x + 1
        end

        if(love.keyboard.isDown("space")) and  #self.tiros <= 0 then
            self.spriteAtual = "shoot"
            self.frameAtual = 1
            self.tempo = 0
            table.insert(self.tiros, Tiro(self.x + 30, self.y + 20, self.player))

        end
    end
    if(self.player == 2) then
        if love.keyboard.isDown("up") then
            self.y = self.y - 1
            
        end
        if love.keyboard.isDown("down") then
            self.y = self.y + 1
        end
        if love.keyboard.isDown("left") then
            self.x = self.x - 1
        end
        if love.keyboard.isDown("right") then
            self.x = self.x + 1
        end
    end

    for _, tiro in pairs(self.tiros) do
        tiro:update(dt)

        if not tiro:estaNaTela() then
            table.remove(self.tiros, _)
        end
    end

    self.ColideComBordasDaTela(self)

   
end


function carregaSprites(self)
    if(self.player ==1)then
        self.frames.idle[1] = love.graphics.newQuad(4, 0, 37, 39, self.spriteIdle:getDimensions())
        self.frames.idle[2] = love.graphics.newQuad(54, 0, 37, 39, self.spriteIdle:getDimensions())
        self.frames.idle[3] = love.graphics.newQuad(104, 0, 37, 39, self.spriteIdle:getDimensions())
        self.frames.idle[4] = love.graphics.newQuad(154, 0, 37, 39, self.spriteIdle:getDimensions())
        self.frames.idle[5] = love.graphics.newQuad(204, 0, 37, 39, self.spriteIdle:getDimensions())


        -- self.frames.walk[1] = love.graphics.newQuad(4, 0, 37, 39, self.spriteWalk:getDimensions())
        -- self.frames.walk[2] = love.graphics.newQuad(54, 0, 37, 39, self.spriteWalk:getDimensions())
        -- self.frames.walk[3] = love.graphics.newQuad(104, 0, 37, 39, self.spriteWalk:getDimensions())
        -- self.frames.walk[4] = love.graphics.newQuad(154, 0, 37, 39, self.spriteWalk:getDimensions())
        -- self.frames.walk[5] = love.graphics.newQuad(204, 0, 37, 39, self.spriteWalk:getDimensions())

        self.frames.walk[1] = love.graphics.newQuad(304, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[2] = love.graphics.newQuad(254, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[3] = love.graphics.newQuad(204, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[4] = love.graphics.newQuad(154, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[5] = love.graphics.newQuad(104, 0, 37, 37, self.spriteWalk:getDimensions())

        self.frames.shoot[1] = love.graphics.newQuad(254, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.shoot[2] = love.graphics.newQuad(304, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.shoot[3] = love.graphics.newQuad(354, 0, 37, 37, self.spriteIdle:getDimensions())
    else
        --inverte a ordem dos sprites
        self.frames.idle[1] = love.graphics.newQuad(350, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.idle[2] = love.graphics.newQuad(300, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.idle[3] = love.graphics.newQuad(250, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.idle[4] = love.graphics.newQuad(200, 0, 37, 37, self.spriteIdle:getDimensions())
        self.frames.idle[5] = love.graphics.newQuad(150, 0, 37, 37, self.spriteIdle:getDimensions())

        self.frames.walk[1] = love.graphics.newQuad(304, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[2] = love.graphics.newQuad(254, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[3] = love.graphics.newQuad(204, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[4] = love.graphics.newQuad(154, 0, 37, 37, self.spriteWalk:getDimensions())
        self.frames.walk[5] = love.graphics.newQuad(104, 0, 37, 37, self.spriteWalk:getDimensions())

        self.frames.shoot[1] = love.graphics.newQuad(100, 0, 39, 37, self.spriteIdle:getDimensions())
        self.frames.shoot[2] = love.graphics.newQuad(50, 0, 39, 37, self.spriteIdle:getDimensions())
        self.frames.shoot[3] = love.graphics.newQuad(0, 0, 39, 37, self.spriteIdle:getDimensions())

    end
end


function animaSprites(self,dt)
    local tam
    if(self.spriteAtual == "idle") then
        tam = #self.frames.idle
    elseif(self.spriteAtual == "walk") then
        tam = #self.frames.walk
    elseif(self.spriteAtual == "shoot") then
        tam = #self.frames.shoot
    end
    self.tempo = self.tempo + dt
    if(self.tempo > 0.1) then
        self.tempo = 0
        self.frameAtual = self.frameAtual + 1
        if(self.frameAtual >tam) then
            self.frameAtual = 1
        end
    end
end


function Personagem:draw()

    if(self.spriteAtual == "idle") then
        love.graphics.draw(self.spriteIdle, self.frames.idle[self.frameAtual], self.x, self.y)
    elseif(self.spriteAtual == "walk") then
        love.graphics.draw(self.spriteWalk, self.frames.walk[self.frameAtual], self.x, self.y)
    elseif(self.spriteAtual == "shoot") then
        love.graphics.draw(self.spriteIdle, self.frames.shoot[self.frameAtual], self.x, self.y)
    end
    for _, tiro in pairs(self.tiros) do
        tiro:draw()
    end
    love.graphics.print(self.y,self.x,self.y)
end


function Personagem:ColideComBordasDaTela()
    if(self.x < 0) then
        self.x = 0
    end
    if(self.x > 800 - 30) then
        self.x = 800 - 30
    end
    if(self.y < 490) then
        self.y = 490
    end
    if(self.y > 550) then
        self.y = 550
    end
  
end


