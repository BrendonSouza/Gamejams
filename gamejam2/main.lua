LARGURA_TELA, ALTURA_TELA = 800, 600

function love.load()
    love.window.setTitle("Pong 4X4")
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false})
    Classe = require "libs/classic"
    Vetor = require "libs/vetor"
    require "jogo"
    require "bola"
    require "player"

    jogo = Jogo()


end


function love.update(dt)
    jogo:update(dt)
  
end

function love.draw()
    jogo:draw()
 
end
