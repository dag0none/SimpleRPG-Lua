Battle = {}

function Battle:enter()
    resetTextBoxPosition()
    player.xTo = 142
    player.yTo = 109
    enemy = createEnemy()
    actualTurn = "Choose Weapon"

    equipmentBoxes = {
        armor = createEquipmentBox("armor", 186, 124),
        weapon = createEquipmentBox("weapon", 112, 124)
    }

    dices = {}
    sumDices = 0

    buttonsDice = {
        cdDice = createButton(assets.dice.cd, 152, 82, function()
            love.event.quit()
        end)
    }
end

function Battle:update()
    updatePlayer()
    updateEnemy(enemy)
    updateTurn[actualTurn]()
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
end

updateTurn = {
    ["Choose Weapon"] = function()
        updateTextBox(textBoxes.weaponTurn)
        updateEquipmentBox(equipmentBoxes)
        if mousePressed == 1 then
            textBoxes.weaponTurn[1].xTo = 320
        end 
        if textBoxes.weaponTurn[1].x > 310 then
            actualTurn = "Choose Armor"
        end
    end,
    ["Choose Armor"] = function()
        updateEquipmentBox(equipmentBoxes)
        updateTextBox(textBoxes.armorTurn)
        if mousePressed == 1 then
            textBoxes.armorTurn[1].xTo = 320
            equipmentBoxes.armor.spr = assets.equipmentBox[1]
            equipmentBoxes.weapon.spr = assets.equipmentBox[1]
            equipmentBoxes.armor.y = equipmentBoxes.armor.yToOver
            equipmentBoxes.weapon.y = equipmentBoxes.weapon.yToOver
        end 
        if textBoxes.armorTurn[1].x > 310 then
            actualTurn = "Roll CD"
        end
    end,
    ["Roll CD"] = function()
        updateButton(buttonsDice.cdDice)
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
        love.graphics.print("<roll cd", 169, 87)
        drawButton(buttonsDice.cdDice)
    end
}