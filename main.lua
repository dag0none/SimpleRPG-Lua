function love.load()
    -- Initial Setup
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.math.setRandomSeed(love.timer.getTime())
    normalFont = love.graphics.newFont(20)
    smallFont = love.graphics.newImageFont("assets/smallFont.png", ' "!()+,-./:<=>?0123456789abcdefghijklmnopqrstuvwxyz', -1)
    bigFont = love.graphics.newImageFont("assets/bigFont.png", ' abcdefghijklmnopqrstuvwxyz', -2)
    require "scr/requires"

    -- Setup Screen
    setupScreen()

     -- Assets
     assets = {
        partnerBack = love.graphics.newImage("assets/partner.png"),
        cardEmpty = {
            love.graphics.newImage("assets/cardEmpty.png"),
            love.graphics.newImage("assets/cardEmptyHigh.png"),
        },
        shadowCard = love.graphics.newImage("assets/shadowCard.png"),
        textBox = love.graphics.newImage("assets/textBox.png"),
        textBoxQuad = generateQuads(love.graphics.newImage("assets/textBox.png"), 3, 3),
        versus = love.graphics.newImage("assets/versus.png"),
        equipmentBox = {
            love.graphics.newImage("assets/equipmentEmpty.png"),
            love.graphics.newImage("assets/equipmentEmptyHigh.png"),
        },     
        shadowEquipment = love.graphics.newImage("assets/shadowEquipment.png"),
        dice = {
            pair = love.graphics.newImage("assets/pairDice.png"),
            odd = love.graphics.newImage("assets/oddDice.png"),
            cd = {
                love.graphics.newImage("assets/cdDice.png"),
                love.graphics.newImage("assets/cdDiceHigh.png")
            },
            atk = {
                love.graphics.newImage("assets/atkDice.png"),
                love.graphics.newImage("assets/atkDiceHigh.png")
            }
        }
    }

    -- Enemies Variables
    enemiesDataBase = {
        {"zeus", 20, 10, 1, 3, "i am the god of thunder!"},
        {"hades", 0, 0, 0, 0, "i rule the hell"},
        {"afrodite", 10, 8, 2, 5, "i am love"}
    }

    -- Global Variables
    t = 0
    mousePressed = {}
    cardField = loadCards()
    player = createPlayer(200)
    enemyData = {
        index = 0,
        x = 0,
        y = 0,
    }
    mouseOverCard = false

    -- GameStates
    GameState.registerEvents{"update"}
    GameState.switch(Path)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    -- For test the cell movement
    if key == "left" then
        player.cell = player.cell - 1
    end
    if key == "right" then
        player.cell = player.cell + 1
    end
end

function love.mousepressed(mouseX, mouseY, button)
    if button == 1 then
        mousePressed = 1
    end
end

function love.update(dt)
    -- Mouse Position
    mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX / scale
    mouseY = mouseY / scale

    t = t + dt
    updateTimers(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(scale, scale)
    mousePressed = {}
    drawBackground(20)
    love.graphics.setFont(bigFont)
    love.graphics.printf("olimpio", 0, 5, core_w, "center")
    GameState:draw()
    love.graphics.pop()
    love.graphics.setFont(normalFont)
    love.graphics.print("Demo Version", 10, 180 * scale - 30)
    love.graphics.print("Fps: "..tostring(love.timer.getFPS()), 10, 2)
end

function drawBackground(_speed)
    love.graphics.setBackgroundColor(43/255, 160/255, 177/255)
    love.graphics.draw(assets.partnerBack, 0, ((t * _speed) % (core_h - 3)) - core_h)
end