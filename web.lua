
Web = {
    port = 80
}

function Web.startServer(handler)
    local srv = net.createServer(net.TCP, 30)

    srv:listen(Web.port,function(conn)
        conn:on("receive", handler)
    end)
end
print("Available heap: "..node.heap())
function Web.handleConnection(conn, payload)

    local postparse={
        string.find(payload,"epoch=")
    }
    if postparse[2]~=nil then
        local epoch = string.sub(payload,postparse[2]+1,#payload)
        local tm = rtctime.epoch2cal(string.sub(epoch, 1, 10))
        print(string.sub(epoch, 1, 10))
        Rtc.setTime(tm['sec'], tm['min'], tm['hour'], 1, tm['day'], tm['mon'], string.sub(tm['year'], 3, 4));
    end
    print(collectgarbage('count'))

    conn:send('HTTP/1.1 200 OK\n\n')

    file.open("test.html","r")
    for counter=1, 53 do
        conn:send(file.readline().."\n");
    end
    file.close()

    conn:on("sent", function(c)

        c:close()
    end)
end
