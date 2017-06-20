local Settings = {}

local setting = {
    minutes = false
}

function Settings.set(name, value)
    setting[name] = value
end

function Settings.get(name)
    return setting[name]
end

return Settings