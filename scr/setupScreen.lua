function setupScreen()
    core_w = 320
    core_h = 180
    setupScreen = {
        ["Window"] = function()
            scale = 4
            love.window.setMode(core_w * scale, core_h * scale)
        end,
        ["Fullscreen"] = function()
            love.window.setFullscreen(true)
            win_w, win_h = love.graphics.getDimensions()
            scale = win_h / core_h
        end
    }
    setupScreen["Window"]()
end