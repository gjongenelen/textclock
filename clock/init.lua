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
    'Debug.lua',
    'Definitions.lua',
    'Ds3231.lua',
    'Ldr.lua',
    'Rtc.lua',
    'Settings.lua'
}
for _, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil

collectgarbage()

---------------------
Debug = require "Debug"

Debug.heap()

Settings = require "Settings"

Ldr = require "Ldr"
Ldr.startPolling()

Clock = require "Clock"
Clock.init()

Rtc = require "Rtc"
Rtc.registerAlarm(function()
    Clock.repaint()
end)
