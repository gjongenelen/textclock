local Clock = {
    signalFail = true
}

local buffer

function Clock.init()
    ws2812.init()
end

function Clock.createBuffer()
    buffer = ws2812.newBuffer(116, 3)
end

function Clock.signalFail()
    print("[INFO] Marking signalFail")
    Clock.createBuffer()
    buffer:fill(0, 0, 0)
    buffer:set(Definitions.Words["wifi"], 0, 255, 0)
    ws2812.write(buffer)
end

function displayWord(word)
    local word = require("Definitions").Words[word]
    for _, value in pairs(word) do
        buffer:set(value, (240 / 100) * Ldr.percentage, (168 / 100) * Ldr.percentage, (229 / 100) * Ldr.percentage)
    end
end

function printTime(minute, hour)
    print("[INFO] Repainting (" .. hour .. ":" .. minute .. ")")
    print("[INFO] Heap: " .. node.heap())
    buffer:fill(0, 0, 0)

    print("[INFO] Heap: " .. node.heap())

    displayWord("het")
    displayWord("is")

    if minute < 18 then
        displayWord(require("Definitions").Hours["h" .. (hour % 12)])
    else
        displayWord(require("Definitions").Hours["h" .. ((hour + 1) % 12)])
    end

    for _, value in pairs(require("Definitions").Minutes["m" .. minute]) do
        if value ~= "minuten" or Settings.get("minutes") then
            displayWord(value)
        end
    end

    require("Definitions").safeToUnload = true
    ws2812.write(buffer)
end

function Clock.repaint()
    if not Wifi.serving then
        local _, minute, hour, _, _, _, _ = Rtc.getTime()
        printTime(minute, hour)
    end
end

return Clock