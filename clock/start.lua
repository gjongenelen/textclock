
print("[INFO] Heap: " .. node.heap())
Settings = require "Settings"


print("[INFO] Heap: " .. node.heap())
Ldr = require "Ldr"
Ldr.startPolling()


print("[INFO] Heap: " .. node.heap())
Wifi = require "Wifi"
Wifi.startAp()


print("[INFO] Heap: " .. node.heap())
Clock = require "Clock"
Clock.init()


print("[INFO] Heap: " .. node.heap())
Rtc = require "Rtc"
Rtc.registerAlarm(function()
    Clock.repaint()
end)

print("[INFO] Heap: " .. node.heap())
tmr.alarm(4, 50, 1, function()
    if package.loaded["Definitions"] ~= nill and require("Definitions").safeToUnload then
        package.loaded["Definitions"] = nil
    end
end)