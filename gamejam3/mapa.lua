Mapa = Classe:extend()

TERRA =1
GRAMA = 2

local function ToNumberEx(v)
    if (v == nil) then
       return 0
    else
       return tonumber(v)
    end
end

local function ToList(v)
    if (v == nil) then
       return {}
    else
       return v
    end
end

function Mapa:new()
    self.img = love.graphics.newImage("assets/mapa-militar2.png")
    self.largura = math.floor(800/64)
    self.altura = math.floor(600/64)+1
    self.selecao_cor = {1,0,0,0.5}
    self.posicaoMouse = Vetor()
    self.posicaoInvalida = false

    self.area = {
        {GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA},
        {GRAMA,GRAMA,TERRA,TERRA,TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA},
        {GRAMA,GRAMA,TERRA,TERRA,TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA},
        {GRAMA,GRAMA,TERRA,TERRA,GRAMA,GRAMA,TERRA,TERRA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA},
        {GRAMA,GRAMA,TERRA,TERRA,GRAMA,GRAMA,TERRA,TERRA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA},
        {GRAMA,GRAMA,TERRA,TERRA,GRAMA,GRAMA,TERRA,TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA},
        {TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA,TERRA,TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA},
        {TERRA,TERRA,TERRA,TERRA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,TERRA,TERRA,TERRA,GRAMA},
        {GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,TERRA,TERRA,TERRA,GRAMA},
        {GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA,GRAMA }
    }
    print(#self.area)
end

function Mapa:update(dt)
    if (self.area[self.posicaoMouse.y][self.posicaoMouse.x] ~= TERRA) then 
        if self.posicaoMouse.y >= 1 and ( 
            ToNumberEx(ToList(self.area[self.posicaoMouse.y+1])[self.posicaoMouse.x]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y-1])[self.posicaoMouse.x]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y])[self.posicaoMouse.x+1]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y])[self.posicaoMouse.x-1]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y+1])[self.posicaoMouse.x+1]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y-1])[self.posicaoMouse.x-1]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y+1])[self.posicaoMouse.x-1]) == TERRA or
            ToNumberEx(ToList(self.area[self.posicaoMouse.y-1])[self.posicaoMouse.x+1]) == TERRA
        ) then
            self.selecao_cor = {0,1,0,0.5}
            self.posicaoInvalida = false
        else
            self.selecao_cor = {1,0,0,0.5}
            self.posicaoInvalida = true
        end
    else
        self.selecao_cor = {1,0,0,0.5}
        self.posicaoInvalida = true
    end
end

function Mapa:draw()

    love.graphics.draw(self.img, 0, 0)
    love.graphics.setColor(self.selecao_cor)
    love.graphics.rectangle("fill", ((self.posicaoMouse.x-1)*64), (self.posicaoMouse.y-1)*64, 64, 64)
    love.graphics.setColor(1,1,1)
   
end

function Mapa:retornaMeioDoCaminho()
    
    
end









