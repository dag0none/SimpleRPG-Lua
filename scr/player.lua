function createPlayer(_y)
    local this = {
        health = 25,
        totalHealth = 25,
        cd = 0,
        atk = 1,
        x = 320/2,
        y = _y,
        xTo = 142,
        yTo = 127,
        w = assets.cardEmpty[1]:getWidth(),
        h = assets.cardEmpty[1]:getHeight(),
        spr = assets.cardEmpty[1],
        cell = 2
    }
    
    return this
end

function updatePlayer()
    player.x = smoothApproach(player.x, player.xTo, 0.2)
    player.y = smoothApproach(player.y, player.yTo, 0.2)
end

function drawPlayer(_type)
    if _type == "cell" then
        player.xTo = ((player.cell - 1) * 56) + 86
    end
    love.graphics.draw(assets.shadowCard, player.x, player.y + player.h - 9)
    love.graphics.draw(player.spr, player.x - 1, player.y)
end