require("BlockingQueue")

local function fork(run)
    local  co = coroutine.create(run) 
    coroutine.resume(co)
end

local q = createBlockingQueue()

local loopCount = 200

fork(function()
    for i = 1, loopCount do 
        q.put(i)
    end
end)

fork(function()
    for i = 1, loopCount do 
        local v = q.take()
        print(v)
    end
end)
