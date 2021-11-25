function newTimer(_time, _function)
    local timer = {
        time = _time,
        func = _function
    }

    table.insert(timers, timer)
end

function updateTimers(dt)
    for i, timer in pairs(timers) do
        if timer.time <= 0 then
            table.insert(debug, 0)
            timer.func()
            timers = {}
        end
        timer.time = timer.time - dt    
    end
end

timers = {}