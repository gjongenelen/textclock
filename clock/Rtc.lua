local Ds3231 = require "Ds3231"

local Rtc = {}

local pinSDA = 2
local pinSCL = 3

function Rtc.init()
    i2c.setup(0, pinSDA, pinSCL, i2c.SLOW)
    print("[INFO] DS3231 initialized")
end

almId = 2
function Rtc.registerAlarm(callback)
    Rtc.init()

    gpio.mode(1,gpio.INT)
    gpio.trig(1,'down',function(level)
        if (level == 0) then
            callback()
        end
        Ds3231.reloadAlarms()
    end)

    Ds3231.setAlarm(almId, Ds3231.EVERYMINUTE)
    print("[INFO] Set alarm 2")
    print("[INFO] Heap: "..node.heap())
end

function Rtc.print()
    local second, minute, hour, _, date, month, year = Ds3231.getTime();
    print(string.format("Time & Date: %s:%s:%s %s/%s/%s", hour, minute, second, date, month, year))
end

function Rtc.getTime()
    return Ds3231.getTime()
end

function Rtc.setTime(second, minute, hour, date, month, year)
    return Ds3231.setTime(second, minute, hour, 1, date, month, year)
end

return Rtc;
