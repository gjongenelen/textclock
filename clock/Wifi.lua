local Wifi = {
    serving = false
}

local Web = require "Web"

local mode = wifi.SOFTAP
local apConfig = {
    ssid = "Clock-" .. node.chipid(),
    pwd = "itistime"
}
local dhcpConfig = {
    ip = "192.168.4.1",
    netmask = "255.255.255.0",
    gateway = "192.168.4.1"
}

function Wifi.startAp()
    wifi.setmode(mode)
    wifi.ap.config(apConfig)
    wifi.ap.setip(dhcpConfig)
    print("[INFO] AP emitting")

    startWebserverOnDemand()
end

function startWebserverOnDemand()
    tmr.alarm(0, 100, 1, function()
        local count = 0
        for _ in pairs(wifi.ap.getclient()) do count = count + 1 end
        if count > 0 then
            if not Wifi.serving then
                Wifi.serving = true
                Web.startServer()
            end
        else
            if Wifi.serving then
                Web.stopServer()
                Wifi.serving = false
                tmr.alarm(2, 1000, 0, function()
                    Clock.repaint(function()
                        print("[INFO] Updated settings")
                    end)
                end)
            end
        end
    end)
end

return Wifi