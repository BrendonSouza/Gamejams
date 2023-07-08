
function adicionaColisionClass()
    
    world:addCollisionClass('Player')
    world:addCollisionClass('Chao', {ignores = {'Chao'}})
    world:addCollisionClass('Inimigo', {ignores = {'Inimigo'}})
    world:addCollisionClass('Armadilha', {ignores = {'Armadilha'}})
    world:addCollisionClass('Bomba', {ignores = {'Bomba'}})
    world:addCollisionClass('Peixe', {ignores = {'Peixe','Chao'}})
    world:addCollisionClass('Serra')
    world:addCollisionClass('Parede')
    
end