--Executa quando o jogo carrega
function love.load()
    button = {}
    button.x = 250
    button.y = 250
    button.size = 100

    score = 0
    timer = 10

    gameState = 1 --1 menu 2 jogando 3 game Win

    myFont = love.graphics.newFont(40)
end

--Game loop, recebe dt = delta time
function love.update(dt)
    if gameState == 2 then
        if timer > 0 then
            timer = timer - dt
        end

        if timer < 0 then
            timer = 0
            gameState = 1
            score = 0
        end
    end
end

--Desenha na tela
function love.draw()
    if gameState == 2 then
        --circle(modo, posicaoTelaX, posicaoTelaY, raio
        love.graphics.setColor(255, 0, 0)
        love.graphics.circle("fill", button.x, button.y, button.size)
    end

    love.graphics.setFont(myFont)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Score: " .. score) --Os caracteres .. e usado como append, no java seria +

    --imprime o tempo que falta pro jogo terminar
    love.graphics.print("Time: " .. math.ceil(timer), 300, 0)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    end
    if gameState == 3 then
        love.graphics.printf("Congratulations you win!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    end
end

function love.mousepressed(x, y, button1, istouch)

    if button1 == 1 and gameState == 2 then
        if distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY()) < button.size then
            score = score + 1

            --Joga o circulo em uma posicao randomica no range da tela
            button.x = math.random(button.size, love.graphics.getWidth() - button.size)
            button.y = math.random(button.size, love.graphics.getHeight()- button.size)

            if score == 15 or score == 30 then
                timer = timer + 10
            end

            if score > 15 and score < 30 then
                button.size = math.random(5, 100)
            end
        end
    end

    if gameState == 1 then
        gameState = 2
        timer = 10
    end

    if gameState == 2 and score >= 30 then
        gameState = 3
    end

end

function distanceBetween( x1, y1, x2, y2 )
    return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end