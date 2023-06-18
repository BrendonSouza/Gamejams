LARGURA_TELA, ALTURA_TELA = 800, 600

function love.load()
    love.window.setTitle("Tanques, aviões e musicas")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false, vsync = true})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    Lua_star = require "libs/lua-star"
    require "mapa"
    require "jogo"
    require "inimigo"
    require "torre"
    require "tiro"

  
    jogo = Jogo()


end


function love.update(dt)
    jogo:update(dt)
  
end

function love.draw()

    jogo:draw()
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end
