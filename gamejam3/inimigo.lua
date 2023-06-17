Personagem = Classe:extend()

function Personagem:new()
    self.posicao = Vetor(-1,8)
    self.pos_path = 0
    self.direcao = Vetor()
    self.velocidade = 4
    self.path = nil
end

function Personagem:update(dt)
    if path then
        if self.pos_path == #path then
            return
        end
        local path_vet = Vetor(path[self.pos_path+1].x, path[self.pos_path+1].y)
        self.direcao = path_vet - self.posicao

        if #path == self.pos_path then
            return
        end
        self.posicao = self.posicao + self.direcao:norm()*dt

        if self.posicao:dist(path_vet) < 2/64 then
            self.posicao = path_vet
            self.pos_path = self.pos_path +1
        end

    end
end

function Personagem:draw()
    love.graphics.rectangle("fill", (self.posicao.x-1)*64, (self.posicao.y-1)*64, 64,64)
end