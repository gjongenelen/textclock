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

    conn:send('HTTP/1.1 200 OK\n\n')

    local epoch = {
        string.find(payload, "epoch=")
    }
    local minutes = {
        string.find(payload, "minutes=")
    }
    local red = {
        string.find(payload, "red=")
    }
    local green = {
        string.find(payload, "green=")
    }
    local blue = {
        string.find(payload, "blue=")
    }
    if epoch[2] ~= nil then
        local epoch = string.sub(payload, epoch[2] + 1, #payload)
        local tm = rtctime.epoch2cal(string.sub(epoch, 1, 10))
        Rtc.setTime(tm['sec'], tm['min'], tm['hour'], 1, tm['day'], tm['mon'], string.sub(tm['year'], 3, 4));
        print("[INFO] Set time (" .. epoch .. ")")
        conn:close()
        return
    end
    if red[2] ~= nil then
        local red = string.sub(payload, red[2] + 1, #payload)
        Settings.set("red", red)
        print("[INFO] Set red (" .. red .. ")")
        conn:close()
        Clock.signalFail()
        return
    end
    if green[2] ~= nil then
        local green = string.sub(payload, green[2] + 1, #payload)
        Settings.set("green", green)
        print("[INFO] Set green (" .. green .. ")")
        conn:close()
        Clock.signalFail()
        return
    end
    if blue[2] ~= nil then
        local blue = string.sub(payload, blue[2] + 1, #payload)
        Settings.set("blue", blue)
        print("[INFO] Set blue (" .. blue .. ")")
        conn:close()
        Clock.signalFail()
        return
    end
    if minutes[2] ~= nil then
        local minutes = string.sub(payload, minutes[2] + 1, #payload)
            Settings.set("minutes", minutes)
        print("[INFO] Set showMinutes (" .. minutes .. ")")
        conn:close()
        return
    end


    response = {}

    file.open("web.html", "r")
    for counter = 1, 96 do
        response[#response + 1] = file.readline()
    end
    file.close()
    collectgarbage()

    local function send(socket)
        if #response > 0 then
            socket:send(table.remove(response, 1))
        else
            socket:close()
            response = nil
        end
    end

    conn:on("sent", send)
    send(conn)
end

return Web