local Settings = {}

local setting = {
    minutes = false
}

function Settings.init()
    if file.exists("setting.showMinutes") then
        setting.minutes = true
    else
        setting.minutes = false
    end
end

function Settings.set(name, value)
    if name == "minutes" then
        if value == true then
            if file.open("setting.showMinutes", "a+") then
                -- write 'foo bar' to the end of the file
                file.write('.')
                file.close()
            end
        else
            file.remove("setting.showMinutes")
        end
    end
    setting[name] = value
end

function Settings.get(name)
    return setting[name]
end

return Settings