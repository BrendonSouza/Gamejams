LARGURA_TELA, ALTURA_TELA = 1200, 760

function love.load()
    love.window.setTitle("Box Boxer")
    love.graphics.setDefaultFilter("nearest", "nearest")
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
    gameFont = love.graphics.newFont("assets/Minecraft.ttf", 35)
    screenGameOver = love.graphics.newImage("assets/game_over.png")
    screenMenu = love.graphics.newImage("assets/menu.png")
    winSprite = love.graphics.newImage("assets/gato.png")
    grandePeixeSprite = love.graphics.newImage("assets/peixes.png")
    gridPeixe = Anim8.newGrid(64, 64, grandePeixeSprite:getWidth(), grandePeixeSprite:getHeight(),3)
    peixeAnimation = Anim8.newAnimation(gridPeixe('1-2',1), 0.5)
    grid = Anim8.newGrid(16, 16, winSprite:getWidth(), winSprite:getHeight())
    playerWinAnimation = Anim8.newAnimation(grid('1-4',1), 0.12)


    loadWorld()
    cam = camera()
    jogo = Jogo()
    gameStatus = "menu"

end


function love.update(dt)
    if gameStatus == "menu" then
        updateMenu(dt)
    elseif gameStatus == "gameOver" then
        if love.keyboard.isDown("return") then
            jogo.reset =true
            jogo:update(dt)
        end
    elseif gameStatus == "Win" then
        playerWinAnimation:update(dt)
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
    elseif gameStatus == "gameOver" then
        love.graphics.draw(screenGameOver, 0, 0)
    elseif gameStatus == "Win" then
        drawWin()
    else
    cam:attach()

    jogo:draw()
    -- world:draw()
    cam:detach()
    if jogo.fase == 2 then
        love.graphics.setColor(0,0,0)
        love.graphics.print(""..math.floor(jogo.timer),600 , 50)
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
    for i, v in ipairs(vidas) do
       v.isCheio = true
    end
    
end

function looseVida()
 
    if((player.health<7 and player.health>0) or player.health==0) then
        vidas[player.health+1].isCheio = false
    end    
end


function drawMenu()
    love.graphics.draw(screenMenu, 0, 0)
    love.graphics.setFont(gameFont)
    love.graphics.print("Pressione Enter para iniciar", 350, 500)
end

function updateMenu(dt)
    if love.keyboard.isDown("return") then
        gameStatus = "loading"
    end
end


function drawWin()
    -- Player:draw()
    -- love.graphics.draw(screenGameOver, 0,0)
    love.graphics.setBackgroundColor(0.95,0.8,1)
    peixeAnimation:draw(grandePeixeSprite, 630, 250, nil,2,2)
    playerWinAnimation:draw(winSprite, 450, 200, nil,10,10)
    love.graphics.print("Parabens, voce venceu!", 400, 500)
   
end