Wifi = {
    mode = wifi.SOFTAP,
    apConfig = {
        ssid = "ESP-"..node.chipid(),
        pwd = "ESP-"..node.chipid()
    },
    dhcpConfig = {
        ip = "192.168.111.1",
        netmask = "255.255.255.0",
        gateway = "192.168.111.1"
    }
}

function Wifi.startAp()
    wifi.setmode(Wifi.mode)
    wifi.ap.config(Wifi.apConfig)
    wifi.ap.setip(Wifi.dhcpConfig)
    print("[INFO] AP emitting")
end