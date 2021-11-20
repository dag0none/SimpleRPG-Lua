Path = {}

function Path:enter()

end

function Path:update()
    mouseOverCard = false
    updateCards(cardField)
    if mouseOverCard then
        textBoxes.cardStats.health.xTo = 4
        textBoxes.cardStats.cd.xTo = 4
        textBoxes.cardStats.atk.xTo = 4
        textBoxes.cardStats.description.xTo = 4
    else
        resetTextBoxPosition()
    end
    updatePlayer()
    updateTextBox(textBoxes.cardStats)
end

function Path:draw()
    love.graphics.setFont(smallFont)
    drawCards(cardField, 86, 24)
    drawPlayer("cell")
    love.graphics.printf("health: " .. tostring(player.health) .. "/" .. tostring(player.totalHealth), player.x - 20, player.y + player.h - 6, player.w + 37, "center")
    drawTextBox(textBoxes.cardStats)
end