LARGURA_TELA, ALTURA_TELA = 1200, 760

function love.load()
    love.window.setTitle("Box Boxer")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false, vsync = true})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    require "collisions_class"
    require "enemy"
    require "jogo"
    require "player"
    require "heart"
    require "peixe"
    require "serra"
    wf = require "libs/windfield"
    sti = require "libs/sti"
    gameMap = sti("maps/mapa_duas_fases.lua")
    camera = require "libs/camera"
    Anim8 = require "libs/anim8"

    loadWorld()
    cam = camera()
    jogo = Jogo()
    gameStatus = "menu"

end


function love.update(dt)
    if gameStatus == "menu" then
        updateMenu(dt)
    else
        jogo:update(dt)
        world:update(dt)
        looseVida()
    end
  
end

function loadWorld()
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 2600)
    adicionaColisionClass()
    recleft = world:newRectangleCollider(0,0,1,ALTURA_TELA)
    recleft:setType('static')
    recleft:setCollisionClass('Parede')
    recright = world:newRectangleCollider(1400,0,1,ALTURA_TELA)
    recright:setType('static')
    recright:setCollisionClass('Parede')
    vidas = {}
    life()

end



function love.draw()
    if(gameStatus == "menu") then
        drawMenu()
        
    else
    cam:attach()

    jogo:draw()
    world:draw()
    cam:detach()
    if jogo.fase == 2 then
        love.graphics.setColor(0,0,0)
        love.graphics.print(""..jogo.timer,700 , 50)
        love.graphics.setColor(1,1,1)
    end
    for i, v in ipairs(vidas) do
        v:draw()
    end
end
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end


function life()
    for i=1, 7 do
        table.insert(vidas,i, heart(30 * i, 700))
    end
    
end

function looseVida()
 
    if((player.health<7 and player.health>0) or player.health==0) then
        vidas[player.health+1].isCheio = false
    end    
end


function drawMenu()
    love.graphics.print("Pressione Enter para iniciar", 300, 300)
end

function updateMenu(dt)
    if love.keyboard.isDown("return") then
        gameStatus = "loading"
    end
end