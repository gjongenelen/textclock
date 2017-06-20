local compileAndRemoveIfNeeded = function(f)
    if file.open(f) then
        file.close()
        print('Compiling:', f)
        node.compile(f)
        file.remove(f)
        collectgarbage()
    end
end

local serverFiles = {
    'Clock.lua',
    'Definitions.lua',
    'Ds3231.lua',
    'Rtc.lua',
    'Web.lua',
    'Wifi.lua',
    'Settings.lua',
    'Ldr.lua'
}
for _, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil

collectgarbage()

---------------------

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
        print("Unloaded Definitions")
    end
end)