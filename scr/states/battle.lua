Battle = {}

function Battle:enter()
    resetTextBoxPosition()
    player.xTo = 142
    player.yTo = 109
    enemy = createEnemy()
    actualTurn = "Chosse Weapon"
    equipmentBoxes = {
        armor = createEquipmentBox("armor", 186, 124),
        weapon = createEquipmentBox("weapon", 112, 124)
    }
end

function Battle:update()
    updatePlayer()
    updateEnemy(enemy)
    updateEquipmentBox(equipmentBoxes)
    updateTurn[actualTurn]()
end

function Battle:draw()
    love.graphics.draw(assets.versus, 100, 83)
    -- Draw the player
    drawPlayer()
    drawEquipmentBox(equipmentBoxes)
    love.graphics.setFont(smallFont)
    love.graphics.printf("health: " .. tostring(player.health) .. "/" .. tostring(player.totalHealth), player.x - 20, player.y + player.h + 3, player.w + 37, "center")
    -- Draw the enemy
    drawEnemy(enemy)
    -- Draw aditional things of the turn
    drawTurn[actualTurn]()
end

updateTurn = {
    ["Chosse Weapon"] = function()
        updateTextBox(textBoxes.weaponTurn)
    end,
    ["Choose Armor"] = function()
        
    end
}

drawTurn = {
    ["Chosse Weapon"] = function()
        drawTextBox(textBoxes.weaponTurn)
    end,
    ["Choose Armor"] = function()
        
    end
}