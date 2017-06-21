Settings = require "Settings"

Ldr = require "Ldr"
Ldr.startPolling()

Wifi = require "Wifi"
Wifi.startAp()

Clock = require "Clock"
Clock.init()

Rtc = require "Rtc"
Rtc.registerAlarm(function()
    Clock.repaint()
end)

tmr.alarm(4, 50, 1, function()
    if package.loaded["Definitions"] ~= nill and require("Definitions").safeToUnload then
        package.loaded["Definitions"] = nil
        collectgarbage()
    end
    if package.loaded["MinuteDef"] ~= nill and require("MinuteDef").safeToUnload then
        package.loaded["MinuteDef"] = nil
        collectgarbage()
    end
    if package.loaded["Web"] ~= nill and require("Web").safeToUnload then
        package.loaded["Web"] = nil
        collectgarbage()
    end
end)