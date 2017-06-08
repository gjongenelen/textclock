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
    'clock.lua',
    'definitions.lua',
    'ds3231.lua',
    'rtc.lua',
    'web.lua',
    'wifi.lua',
}
for _, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()


dofile("rtc.lc")
dofile("wifi.lc")
dofile("web.lc")
dofile("clock.lc")


Rtc.init()
Clock.init()
Wifi.startAp()


collectgarbage()


Web.startServer(Web.handleConnection)

Clock.setClockTimeout()