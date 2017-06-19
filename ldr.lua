
Ldr = { level = 0, minLevel = 200, maxLevel = 800, percentage = 100 }

function Ldr.startPolling()
    tmr.alarm(0, 1000, 1, function()
        local value = adc.read(0)
        if math.abs(Ldr.level - value) > 30 then
            Ldr.level = value
            if Ldr.level < Ldr.minLevel then
                Ldr.percentage = 1
            elseif Ldr.level > Ldr.maxLevel then
                Ldr.percentage = 0.1
            else
                Ldr.percentage = 0.5
            end

            Clock.repaint(function()
                print("[INFO] Repainted with new level")
            end)
        end
    end)
end