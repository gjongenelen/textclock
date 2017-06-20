local Ldr = {
    percentage = 100
}

local level = 0
local minLevel = 10
local maxLevel = 100

function Ldr.startPolling()
    tmr.alarm(0, 100, 1, function()

        local value = adc.read(0)

        if math.abs(level - value) > 30 then
            level = value
            Ldr.percentage = value / 9
            if Ldr.percentage < minLevel then
                Ldr.percentage = minLevel
            elseif Ldr.percentage > maxLevel then
                Ldr.percentage = maxLevel
            end

            Clock.repaint(function()
                print("[INFO] Repainted with new level (" .. Ldr.percentage .. ")")
            end)
        end
    end)
end

return Ldr