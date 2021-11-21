function createButton(_spr, _x, _y, _func)
    local this = {
        spr = _spr,
        x = _x,
        y = _y,
        w = _spr[1]:getWidth(),
        h = _spr[1]:getHeight(),
        click = _func,
        index = 1,
    }

    return this
end

function updateButton(_button)
    if onMouseOver(_button) then
        _button.index = 2
        if mousePressed == 1 then
            _button.click()
        end
    else
        _button.index = 1
    end
end

function drawButton(_button)
    love.graphics.draw(_button.spr[_button.index], _button.x, _button.y)
end