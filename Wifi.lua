local Wifi = {
    serving = false
}

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
                require("Web").startServer()
            end
        else
            if Wifi.serving then
                require("Web").stopServer()
                Wifi.serving = false
                require("Web").safeToUnload = true

                tmr.alarm(2, 2000, 0, function()
                    Clock.repaint()
                end)
            end
        end
    end)
end

return Wifi