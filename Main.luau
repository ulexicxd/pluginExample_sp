print("Started.")

--// Timer
local timerDefaults = {
    lenght = 0
}

local timer = {}
timer.__index = timer

function timer.new(data)
    local self = setmetatable(timerDefaults, module)

    for key, value in pairs(data) do
        self[key] = value
    end

    return self
end



return timer


--// Plugin
local module = {
    Timer = timer
}



export(module)