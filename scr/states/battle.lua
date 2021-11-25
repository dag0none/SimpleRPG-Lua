Battle = {}

function Battle:enter()
    resetTextBoxPosition()
    player.xTo = 142
    player.yTo = 109
    enemy = createEnemy()
    actualTurn = "Choose Weapon"

    dices = {}
    sumDices = 0

    equipmentBoxes = {
        armor = createEquipmentBox("armor", 186, 124),
        weapon = createEquipmentBox("weapon", 112, 124)
    }

    buttonsDice = {
        cdDice = createButton(assets.dice.cd, 152, 82, function()
            buttonsDice.cdDice.xTo = 350
            rollDice(1, 20)
        end),
        atkDice = createButton(assets.dice.atk, 152, 82, function()
            buttonsDice.atkDice.xTo = 350
            rollDice(2, 5)
            newTimer(2, function() 
                enemy.health = enemy.health - sumDices 
                actualTurn = "Enemy CD" 
                dices = {} 
                sumDices = 0 
                hasDiced = false
                once = false
            end)
        end)
    }
 
    hasDiced = false
    once = false
end

function Battle:update(dt)
    updatePlayer()
    updateEnemy(enemy)
    updateTurn[actualTurn](dt)
    updateDices(dices)
end

function Battle:draw()
    love.graphics.draw(assets.versus, 80, 80)
    -- Draw the player
    drawPlayer()
    drawEquipmentBox(equipmentBoxes)
    love.graphics.setFont(smallFont)
    love.graphics.printf("health: " .. tostring(player.health) .. "/" .. tostring(player.totalHealth), player.x - 20, player.y + player.h + 3, player.w + 37, "center")
    -- Draw the enemy
    drawEnemy(enemy)
    -- Draw aditional things of the turn
    drawTurn[actualTurn]()
    drawDices(dices)
    love.graphics.setFont(normalFont)
    love.graphics.print(actualTurn, 2, 20)
end

updateTurn = {
    ["Choose Weapon"] = function()
        if once == false then
            textBoxes.weaponTurn[1].xTo = 122
            once = true 
        end
        updateTextBox(textBoxes.weaponTurn)
        updateEquipmentBox(equipmentBoxes)
        if mousePressed == 1 then
            textBoxes.weaponTurn[1].xTo = 320
        end 
        if textBoxes.weaponTurn[1].x > 310 then
            actualTurn = "Choose Armor"
            once = false
        end
    end,
    ["Choose Armor"] = function()
        if once == false then
            textBoxes.armorTurn[1].xTo = 122
            once = true 
        end
        updateEquipmentBox(equipmentBoxes)
        updateTextBox(textBoxes.armorTurn)
        if mousePressed == 1 then
            textBoxes.armorTurn[1].xTo = 320
        end 
        if textBoxes.armorTurn[1].x > 310 then
            actualTurn = "Roll CD"
            equipmentBoxes.armor.spr = assets.equipmentBox[1]
            equipmentBoxes.weapon.spr = assets.equipmentBox[1]
            equipmentBoxes.armor.y = equipmentBoxes.armor.yToOver
            equipmentBoxes.weapon.y = equipmentBoxes.weapon.yToOver
            once = false
        end
    end,
    ["Roll CD"] = function(dt)
        if once == false then
            buttonsDice.cdDice.xTo = 152
            once = true 
        end
        updateButton(buttonsDice.cdDice)
        if sumDices ~= 0 and sumDices >= enemy.cd then
            newTimer(2, function() 
                dices = {}
                sumDices = 0 
                actualTurn = "Roll Atk"
                once = false end)
        elseif sumDices ~= 0 and sumDices < enemy.cd then
            love.graphics.print("errou", 2, 2)
            newTimer(2, function() sumDices = 0 dices = {} actualTurn = "Enemy CD" once = false end)
        end
    end,
    ["Roll Atk"] = function()
        if once == false then
            buttonsDice.atkDice.xTo = 152
            once = true 
        end
        updateButton(buttonsDice.atkDice)
    end,
    ["Enemy CD"] = function()
        if hasDiced == false then
            rollDice(1,20)
            hasDiced = true
        end
        if sumDices > 0  and once == false then
            newTimer(2, function() 
                if sumDices > player.cd then
                    hasDiced = false
                    sumDices = 0
                    dices = {}
                    actualTurn = "Enemy Atk"
                    once = false
                else
                    actualTurn = "Choose Weapon"
                    dices = {}
                    sumDices = 0
                    hasDiced = false
                    once = false
                end 
            end)
            once = true
        end
    end,
    ["Enemy Atk"] = function()
        if hasDiced == false then
            newTimer(1, function() rollDice(enemy.amount_atk, enemy.value_atk) end)
            hasDiced = true
        end
        if sumDices > 0 and once == false then
            newTimer(2, function()
                player.health = player.health - sumDices 
                sumDices = 0 
                dices = {} 
                actualTurn = "Choose Weapon"
                once = false 
                hasDiced = false
            end)
            once = true
        end
    end
}

drawTurn = {
    ["Choose Weapon"] = function()
        drawTextBox(textBoxes.weaponTurn)
    end,
    ["Choose Armor"] = function()
        drawTextBox(textBoxes.armorTurn)
    end,
    ["Roll CD"] = function()
        love.graphics.print("<roll cd", buttonsDice.cdDice.x + 17, 87)
        drawButton(buttonsDice.cdDice)
    end,
    ["Roll Atk"] = function()
        love.graphics.print("<roll atk", buttonsDice.atkDice.x + 17, 87)
        drawButton(buttonsDice.atkDice)
    end,
    ["Enemy CD"] = function()
        
    end,
    ["Enemy Atk"] = function()

    end
}