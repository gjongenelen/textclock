require("ds3231")

Rtc = { pinSDA = 2, pinSCL = 3 }

function Rtc.init()
    i2c.setup(0, Rtc.pinSDA, Rtc.pinSCL, i2c.SLOW)
    print("[INFO] DS3231 initialized")
end

function Rtc.print()
    local second, minute, hour, _, date, month, year = ds3231.getTime();
    print(string.format("Time & Date: %s:%s:%s %s/%s/%s", hour, minute, second, date, month, year))
end

function Rtc.getTime()
    return ds3231.getTime()
end
function Rtc.setTime(second, minute, hour, date, month, year)
    return ds3231.setTime(second, minute, hour, 1, date, month, year)
end

function Rtc.reloadAlarms()
    return ds3231.reloadAlarms()
end
