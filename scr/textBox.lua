function createTextBox(_text, _font, _x, _y, _limit)
    local this = {
        text = _text,
        font = _font,
        x = _x,
        y = _y,
        xTo = _x,
        yTo = _y,
        limit = _limit
    }

    return this
end

function updateTextBox(_tbl)
    for i, textBox in pairs(_tbl) do
        textBox.x = smoothApproach(textBox.x, textBox.xTo, 0.2)
        textBox.y = smoothApproach(textBox.y, textBox.yTo, 0.2)
    end
end

function drawTextBox(_tbl)
    for i, textBox in pairs(_tbl) do
        -- Take the width and Height of the text
        textWidth = math.min(textBox.font:getWidth(textBox.text), textBox.limit)
        textHeight = math.ceil(textBox.font:getWidth(textBox.text) / textBox.limit) * textBox.font:getHeight(textBox.text)
        -- Draw the top parts of the box
        love.graphics.draw(assets.textBox, assets.textBoxQuad[1], textBox.x, textBox.y)
        love.graphics.draw(assets.textBox, assets.textBoxQuad[2], textBox.x + textWidth + 2, textBox.y)
        -- Draw the bottom parts of the box
        love.graphics.draw(assets.textBox, assets.textBoxQuad[3], textBox.x, textBox.y + textHeight + 1)
        love.graphics.draw(assets.textBox, assets.textBoxQuad[4], textBox.x + textWidth + 2, textBox.y + textHeight + 1)
        -- Fill the box
        love.graphics.setColor(224/255, 240/255, 241/255)
        love.graphics.rectangle("fill", textBox.x + 1, textBox.y, textWidth + 3, textHeight + 4)
        love.graphics.rectangle("fill", textBox.x, textBox.y + 1, 1, textHeight + 1)
        love.graphics.rectangle("fill", textBox.x + textWidth + 4, textBox.y + 1, 1, textHeight + 1)
        love.graphics.setColor(1, 1, 1)
        -- Print the text
        love.graphics.setFont(textBox.font)
        love.graphics.printf(textBox.text, textBox.x + 2, textBox.y + 2, textBox.limit, "left")
    end
end

function resetTextBoxPosition()
    textBoxes.weaponTurn[1].x = 350 
    textBoxes.cardStats.health.xTo = -65
    textBoxes.cardStats.cd.xTo = -65
    textBoxes.cardStats.atk.xTo = -65
    textBoxes.cardStats.description.xTo = -65
end

textBoxes = {
    cardStats = {
        health = createTextBox("", smallFont, -100, 58, 100),
        cd = createTextBox("", smallFont, -100, 72, 100),
        atk = createTextBox("", smallFont, -100, 86, 100),
        description = createTextBox("", smallFont, -100, 100, 56)
    },
    weaponTurn = {
        createTextBox("choose your weapon", smallFont, 122, 85, 180)
    }
}