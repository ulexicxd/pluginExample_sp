local RunService = fetch("RunService")

print("Started.")

--// Timer
local timerDefaults = {
    target = 0,
    countdown = true,
    start = 5,
    running = false,
    callback = function(counter)
        print("Finished.")
    end,
    onTick = function(counter)
        print("Ticked.")
    end
}

local timer = {}
timer.__index = timer

function timer.new(data)
    local self = setmetatable(timerDefaults, timer)

    for key, value in pairs(data or {}) do
        self[key] = value
    end

    self.current = self.start
    self._connection = RunService.Heartbeat:Connect(function(delta: number)
        if not self.running then return end

        if self.countdown and (self.current <= self.target) or not self.countdown and (self.current >= self.target) then
            self.running = false
            self.callback(self)
            return
        else
            self.current += (self.countdown and -delta or delta)
            self.onTick(self)
        end
    end)

    return self
end

function timer:Start()
    self.running = true
end

function timer:Stop()
    self.running = false
end

function timer:IncrementTarget(value)
    self.target += value
end

function timer:IncrementTick(value)
    self.current += value
end

--// Plugin
local module = {
    Timer = timer
}



export(module)