local Debug = {}

function Debug.log(level, message)
    print("["..level.."] " .. message )
end

function Debug.heap()
    Debug.log("INFO", "Heap: " .. node.heap())
end
return Debug