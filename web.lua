
Web = {
    port = 80
}

function Web.startServer(handler)
    local srv = net.createServer(net.TCP, 30)

    srv:listen(Web.port,function(conn)
        conn:on("receive", handler)
    end)
end

function Web.handleConnection(conn, payload)

    local postparse={
        string.find(payload,"epoch=")
    }
    if postparse[2]~=nil then
        local epoch = string.sub(payload,postparse[2]+1,#payload)
        local tm = rtctime.epoch2cal(string.sub(epoch, 1, 10))
        Rtc.setTime(tm['sec'], tm['min'], tm['hour'], 1, tm['day'], tm['mon'], string.sub(tm['year'], 3, 4));
    end

    conn:send('HTTP/1.1 200 OK\n\n')
    conn:send('<!DOCTYPE HTML>\n')
    conn:send('<html>\n')
    conn:send('<head><meta  content="text/html; charset=utf-8">\n')
    conn:send('<title>Clock config</title></head>\n')
    conn:send('<body><h1>Set time please</h1>\n')

    conn:send('<form action="" method="POST">\n')
    conn:send('Epoch:<br><input type="text" readonly name="epoch" id="epoch"><br>\n')
    conn:send('<input type="submit" name="submit" value="Submit"></form>\n')
    conn:send('<script type="text/javascript"> function updateTime() { var d = new Date(); document.getElementById(\'epoch\').value = Math.round(d.getTime() / 1000)+(d.getTimezoneOffset() - (d.getTimezoneOffset() * 2))*60; \n')
    conn:send(' }; setInterval(updateTime, 1000); </script></body></html>\n')

    conn:on("sent", function(conn)
        conn:close()
    end)
end
