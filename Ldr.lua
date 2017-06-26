local Ldr = {
    percentage = 100
}

local level = 0
local minLevel = 10
local maxLevel = 100

function Ldr.startPolling()
    tmr.alarm(1, 100, 1, function()
        if not Wifi.serving then
            local value = adc.read(0)
            if math.abs(level - value) > 30 then
                level = value
                Ldr.percentage = value / 9
                if Ldr.percentage < minLevel then
                    Ldr.percentage = minLevel
                elseif Ldr.percentage > maxLevel then
                    Ldr.percentage = maxLevel
                end

                print("[INFO] Repainting with new level (".. Ldr.percentage .."%)")
                Clock.repaint()
            end

        end
    end)
end

return Ldr