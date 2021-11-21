function newDice(_spr, _x, _number)
    local this = {
        spr = _spr,
        x = _x,
        y = 200,
        yTo = 79,
        number = _number
    }

    return this
end

function rollDice(_amount, _value)
    dices = {}
    local spr, w = 0, 0
    local sum = 0
    for i = 0, _amount - 1 do
        local number = love.math.random(_value)
        if _value % 2 == 0 then
            spr = assets.dice.pair
            w = assets.dice.pair:getWidth()
        else
            spr = assets.dice.odd
            w = assets.dice.odd:getWidth()
        end
        table.insert(dices, newDice(spr, 160 - w/2 - (i * (w + 7)) + (_amount - 1) * (w/2 + 3.5), number))
        sum = sum + number
    end
    sumDices = sum
end

function updateDices(_tbl)
    for i, dice in pairs(_tbl) do
        dice.y = smoothApproach(dice.y, dice.yTo, 0.2)
    end
end

function drawDices(_tbl)
    for i, dice in pairs(_tbl) do
        love.graphics.draw(dice.spr, dice.x, dice.y)
        love.graphics.setFont(smallFont)
        love.graphics.printf(dice.number, dice.x, dice.y + 5, dice.spr:getWidth(), "center")
        if i == 1 then
            love.graphics.print("= " .. tostring(sumDices), dice.x + 21, dice.y + 6)
        else
            love.graphics.print("+", dice.x + 20, dice.y + 6)
        end
    end
end
