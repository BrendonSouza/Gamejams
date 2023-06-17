Mapa = Classe:extend()

TERRA =1
GRAMA = 2
function Mapa:new()
    self.img = love.graphics.newImage("assets/mapa-militar2.png")
    self.largura = math.floor(800/64)
    self.altura = math.floor(600/64)+1
    self.selecao_cor = {1,0,0,0.5}


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
  
    if self.area[mouse.y][mouse.x] == 1 then
       
        self.selecao_cor = {0,1,0,0.5}
    else
        self.selecao_cor = {1,0,0,0.5}
    end
end

function Mapa:draw()

    love.graphics.draw(self.img, 0, 0)
    love.graphics.setColor(self.selecao_cor)
    love.graphics.rectangle("fill", ((mouse.x-1)*64), (mouse.y-1)*64, 64, 64)
    love.graphics.setColor(1,1,1)
   
end









