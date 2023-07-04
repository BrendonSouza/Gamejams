LARGURA_TELA, ALTURA_TELA = 1200, 600

function love.load()
    love.window.setTitle("Box Boxer")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false, vsync = true})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    require "enemy"
    require "jogo"
    require "player"
    wf = require "libs/windfield"
    sti = require "libs/sti"
    gameMap = sti("maps/mapa.lua")
    camera = require "libs/camera"
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 512)
    grounds = {}
    cam = camera()
    if gameMap.layers["Ground"] then
        for i, obj in pairs(gameMap.layers["Ground"].objects) do
            grounds[i] = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            -- grounds[i]:setCollisionClass("Ground")
            grounds[i]:setType('static')
            table.insert(grounds, grounds[i])
        end
    end
    jogo = Jogo()


end


function love.update(dt)
    jogo:update(dt)
    world:update(dt)

    --lock cam only in x axis
    local h = love.graphics.getHeight()

    cam:lookAt(player.position.x + 200, h/2 )

    local w = love.graphics.getWidth()
    if(cam.x < w/2) then
        cam.x = w/2
    end

    local mapw = gameMap.width * gameMap.tilewidth
    if(cam.x > (mapw - w/2)) then
        cam.x = mapw - w/2
    end
  


end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["blocos"])
        gameMap:drawLayer(gameMap.layers["plataforma"])
        gameMap:drawLayer(gameMap.layers["plataforma2"])
        jogo:draw()
        world:draw()
    cam:detach()
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end
