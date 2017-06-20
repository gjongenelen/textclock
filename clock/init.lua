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

function startup()
    dofile('start.lua')
end

tmr.alarm(0,5000,0,startup)