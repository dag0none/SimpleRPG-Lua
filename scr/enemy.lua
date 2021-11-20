function createEnemy()
    local this = {
        spr = assets.cardEmpty[1],
        x = enemyData.x,
        y = enemyData.y,
        xTo = 141,
        yTo = 27,
        health = cardField[enemyData.index].health,
        cd = cardField[enemyData.index].cd,
        min_atk = cardField[enemyData.index].min_atk,
        max_atk = cardField[enemyData.index].max_atk,
        description = cardField[enemyData.index].description
    }

    return this
end

function updateEnemy(_enemy)
    _enemy.x = smoothApproach(_enemy.x, _enemy.xTo, 0.2)
    _enemy.y = smoothApproach(_enemy.y, _enemy.yTo, 0.2)
end

function drawEnemy(_enemy)
    love.graphics.draw(assets.shadowCard, _enemy.x + 1, _enemy.y + 38)
    love.graphics.draw(_enemy.spr, _enemy.x, _enemy.y)
    love.graphics.print("health: " .. tostring(_enemy.health), _enemy.x + 40, _enemy.y + 8)
    love.graphics.print("c.d: " .. tostring(_enemy.cd), _enemy.x + 40, _enemy.y + 17)
    love.graphics.print("attack: " .. tostring(_enemy.min_atk) .. "-" .. tostring(_enemy.max_atk), _enemy.x + 40, _enemy.y + 26)
    love.graphics.printf('"' .. _enemy.description .. '"', _enemy.x - 55, _enemy.y + 11, 52, "center")
end