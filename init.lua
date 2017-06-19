print("Available heap: "..node.heap())

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
    'ldr.lua'
}
for _, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil

print("Available heap: "..node.heap())

print("Available heap: "..node.heap())
dofile("rtc.lc")
dofile("wifi.lc")
dofile("web.lc")
dofile("ldr.lc")
dofile("clock.lc")


Rtc.init()
Ldr.startPolling()
Clock.init()
Wifi.startAp()

print("Available heap: "..node.heap())
print("Available heap: "..node.heap())

Web.startServer(Web.handleConnection)

Clock.setClockTimeout()