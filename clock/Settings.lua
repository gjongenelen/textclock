local Settings = {}

local setting = {}

function Settings.set(name, value)
    setting[name] = value
    file.remove("setting."..name)
    if file.open("setting."..name, "a+") then
        file.write(value)
        file.close()
    end
end

function Settings.get(name, default)
    if setting[name] ~= nil then
        return setting[name]
    end

    if file.open("setting."..name) then
        local var = file.read()
        file.close()
        setting[name] = var
        return var
    else
        return default
    end
end

return Settings