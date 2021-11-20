function createCardEnemy(_enemy, _x, _y)
    local this = {
        name = _enemy[1],
        health = _enemy[2],
        cd = _enemy[3],
        min_atk = _enemy[4],
        max_atk = _enemy[5],
        description = _enemy[6],
        spr = assets.cardEmpty[1],
        x = _x,
        y = _y,
        sY = _y,
        xTo = 0,
        yTo =0,
        offX = 0,
        offY = 0,
        w = assets.cardEmpty[1]:getWidth(),
        h = assets.cardEmpty[1]:getHeight(),
    }

    return this
end

function loadCards()
    local this = {}
    for i = 0, 5 do
        local index = love.math.random(#enemiesDataBase)
        table.insert(this, createCardEnemy(enemiesDataBase[index], 160, 200))
    end
    return this
end

function updateCards(_tbl)
    local index = 0
    for i, card in ipairs(_tbl) do
        if onMouseOver(card) then
            index = 1
            mouseOverCard = true
            printCardText(card)
            if mousePressed == 1 then 
                if (i == player.cell or i == player.cell + 1 or i == player.cell - 1) and i < 4 then
                    enemyData.index = i
                    enemyData.x = card.xTo
                    enemyData.y = card.yTo
                    GameState.switch(Battle)
                end
            end
        else
            index = 0
        end
        card.xTo = (i - 1) % 3 * 56 + card.offX
        card.yTo = math.floor(i / 4) * -52 - (index * 2) + card.offY + math.floor(#_tbl/4) * 52
        card.sY = smoothApproach(card.sY, card.yTo + 37 + (index * 2), 0.2)
        card.spr = assets.cardEmpty[index + 1]
        card.x = smoothApproach(card.x, card.xTo, 0.2)
        card.y = smoothApproach(card.y, card.yTo, 0.2)
    end
end

function drawCards(_tbl, _x, _y)
    for i, card in ipairs(_tbl) do
        card.offX = _x
        card.offY = _y
        love.graphics.draw(assets.shadowCard, card.x, card.sY)
        love.graphics.draw(card.spr, card.x - 1, card.y - 1)
    end
end

function printCardText(_card)
    textBoxes.cardStats.health.text = 'health: ' .. _card.health
    textBoxes.cardStats.cd.text = 'c.d: ' .. tostring(_card.cd)
    textBoxes.cardStats.atk.text = 'attack: ' .. tostring(_card.min_atk) .. '-' .. tostring(_card.max_atk)
    textBoxes.cardStats.description.text = '"' .. _card.description .. '"'
end