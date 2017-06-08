dofile("definitions.lc")

Clock = { buffer = nil }

function Clock.init()
    ws2812.init()
    Clock.buffer = ws2812.newBuffer(116, 3)
end

function Clock.signalFail()
    print("[INFO] Marking signalFail")
    Clock.buffer:fill(0, 0, 0)
    Clock.buffer:set(116, 0, 255, 0)
    ws2812.write(Clock.buffer)
end

function Clock.displayWord(word)
    local word = Words[word]
    for _, value in pairs(word) do
        Clock.buffer:set(value, 240, 168, 229)
    end
end

function Clock.printTime(minute, hour)
    print("[INFO] Repainting ("..hour..":"..minute..")")
    Clock.buffer:fill(0, 0, 0)

    Clock.displayWord("het")
    Clock.displayWord("is")

    if minute < 18 then
        Clock.displayWord(Hours["h"..(hour % 12)])
    else
        Clock.displayWord(Hours["h"..((hour+1) % 12)])
    end

    for _, value in pairs(Minutes["m"..minute]) do
        Clock.displayWord(value)
    end

    ws2812.write(Clock.buffer)
end



function Clock.repaint(callback)
    local _, minute, hour, _, _, _, _ = Rtc.getTime()
    Clock.printTime(minute, hour)
    callback()
end

almId = 2
function Clock.setClockTimeout()
    gpio.mode(1,gpio.INT)
    gpio.trig(1,'down',function(level)
        if (level == 0) then
            Clock.repaint(function()
                Rtc.reloadAlarms()
            end)
        else
            Rtc.reloadAlarms()
        end

    end)

    ds3231.setAlarm(almId,ds3231.EVERYMINUTE)
    print("[INFO] Set alarm 2")
    Clock.repaint(function()
        print("[INFO] Painted for first time")
    end)
end

