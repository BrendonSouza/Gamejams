LARGURA_TELA, ALTURA_TELA = 800, 600

function love.load()
    love.window.setTitle("Tanques, aviões e musicas")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    Lua_star = require "libs/lua-star"
    require "mapa"
    require "jogo"
    require "inimigo"
    require "torre"

  
    jogo = Jogo()


end


function love.update(dt)
    jogo:update(dt)
  
end

function love.draw()
    jogo:draw()
 
end
