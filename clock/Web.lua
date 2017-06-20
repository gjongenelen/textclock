local Web = {
    safeToUnload = false,
    minutes = false
}

local port = 80
local srv

function Web.startServer()
    if srv == nill then
        Clock.signalFail()
        print("[INFO] Starting server")
        srv = net.createServer(net.TCP, 30)
        srv:listen(port, function(conn)
            conn:on("receive", handleConnection)
        end)
    end
end

function Web.stopServer()
    if srv ~= nill then
        print("[INFO] Stopping server")
        srv:close()
        srv = nil
        collectgarbage()
    end
end

function handleConnection(conn, payload)

    local epoch = {
        string.find(payload, "epoch=")
    }
    local minutes = {
        string.find(payload, "minutes=")
    }
    if epoch[2] ~= nil then
        local epoch = string.sub(payload, epoch[2] + 1, #payload)
        local tm = rtctime.epoch2cal(string.sub(epoch, 1, 10))
        Rtc.setTime(tm['sec'], tm['min'], tm['hour'], 1, tm['day'], tm['mon'], string.sub(tm['year'], 3, 4));
        print("[INFO] Set time ("..epoch..")")
    end
    if minutes[2] ~= nil then
        local minutes = string.sub(payload, minutes[2] + 1, #payload)
        if minutes == "0" then
            Settings.set("minutes", false)
        else
            Settings.set("minutes", true)
        end
        print("[INFO] Set showMinutes ("..minutes..")")
    end

    conn:send('HTTP/1.1 200 OK\n\n')

    if epoch[2] == nil and minutes[2] == nil then

        file.open("web.html", "r")
        for counter = 1, 53 do
            conn:send(file.readline() .. "\n");
        end
        file.close()
    end

    conn:on("sent", function(c)
        c:close()
        collectgarbage()
    end)
end

return Web