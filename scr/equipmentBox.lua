function createEquipmentBox(_name, _x, _y)
    local this = {
        spr = assets.equipmentBox[1], 
        x = _x,
        y = _y,
        xTo = _x,
        yTo = _y,
        yToOver = _y,
        sY = _y + 18,
        w = 20,
        h = 21,
        xTo = _x,
        yTo = _y,
        name = _name
    }

    return this
end

function updateEquipmentBox(_tbl)
    for i, eqBox in pairs(_tbl) do
        if onMouseOver(eqBox) then
            eqBox.spr = assets.equipmentBox[2]
            eqBox.yTo = eqBox.yToOver - 1
        else
            eqBox.spr = assets.equipmentBox[1]
            eqBox.yTo = eqBox.yToOver
        end
        eqBox.y = smoothApproach(eqBox.y, eqBox.yTo, 0.2)
    end
end

function drawEquipmentBox(_tbl)
    for i, eqBox in pairs(_tbl) do
        love.graphics.setFont(smallFont)
        love.graphics.printf(eqBox.name, eqBox.x - 20, eqBox.y - 10, eqBox.w + 40, "center")
        love.graphics.draw(assets.shadowEquipment, eqBox.x, eqBox.sY)
        love.graphics.draw(eqBox.spr, eqBox.x, eqBox.y)
    end
end