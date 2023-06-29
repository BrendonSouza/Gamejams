LARGURA_TELA, ALTURA_TELA = 1200, 720

function love.load()
    love.window.setTitle("Box Boxer")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false, vsync = true})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    require "jogo"
    require "player"
    wf = require "libs/windfield"
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 1024)
  
    jogo = Jogo()


end


function love.update(dt)
    jogo:update(dt)
    world:update(dt)

end

function love.draw()

    jogo:draw()
    world:draw()
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end
