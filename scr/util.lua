function math.sign(v)
    return v > 0 and 1 or v < 0 and -1 or 0
end

function smoothApproach(_value, _target, _amount)
    local diff = _target - _value
    if math.abs(diff) < 0.05 then
        return _target
    else 
        return _value + math.sign(diff) * math.abs(diff) * _amount
    end
end

function onMouseOver(obj)
    return not (mouseX < obj.x or mouseY < obj.y or mouseX > obj.x + obj.w or mouseY > obj.y + obj.h)
end

function generateQuads(_img, _w, _h)
    local this = {}
    local wImg = _img:getWidth()
    local hImg = _img:getHeight()
    for y = 0, hImg - _h, _h do
        for x = 0, wImg - _w, _w do
            table.insert(this, love.graphics.newQuad(x, y, _w, _h, _img))
        end
    end
    return this
end