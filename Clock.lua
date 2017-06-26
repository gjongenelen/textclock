local Clock = {
    signalFail = true
}

local buffer

function Clock.init()
    ws2812.init()
end

function Clock.createBuffer()
    buffer = ws2812.newBuffer(116, 3)
    buffer:fill(0, 0, 0)
end

function Clock.signalFail()
    print("[INFO] Marking signalFail")
    Clock.createBuffer()
    buffer:set(116, tonumber(Settings.get("green", 240)), tonumber(Settings.get("red", 168)), tonumber(Settings.get("blue", 229)))
    ws2812.write(buffer)
    buffer = nil
end

function displayWord(word)
    local word = require("Definitions").Words[word]
    for _, value in pairs(word) do
        buffer:set(value, (tonumber(Settings.get("green", 240)) / 100) * Ldr.percentage, (tonumber(Settings.get("red", 168)) / 100) * Ldr.percentage, (tonumber(Settings.get("blue", 229)) / 100) * Ldr.percentage)
    end
end

function printTime(minute, hour)
    print("[INFO] Repainting (" .. hour .. ":" .. minute .. ")")
    Clock.createBuffer()

    displayWord("het")
    displayWord("is")

    if minute < 18 then
        displayWord(require("Definitions").Hours["h" .. (hour % 12)])
    else
        displayWord(require("Definitions").Hours["h" .. ((hour + 1) % 12)])
    end

    for _, value in pairs(require("Definitions").Minutes["m" .. minute]) do
        if value ~= "minuten" or Settings.get("minutes", "1") == "1" then
            displayWord(value)
        end
    end

    require("Definitions").safeToUnload = true
    ws2812.write(buffer)
    buffer = nil
end

function Clock.repaint()
    if not Wifi.serving then
        local _, minute, hour, _, _, _, _ = Rtc.getTime()
        printTime(minute, hour)
    end
end

return Clock