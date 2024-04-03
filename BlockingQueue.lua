-- BlockingQueue
function createBlockingQueue()

    local queue = {}

    -- indicates if a thread is waiting to take a value
    local takeThread = nil
    -- a table of queue values
    local q = {}

    queue.put = function(value)
        table.insert(q, value)
        -- If a thread is waiting for a value,
        -- then take it back off the queue and deliver it.
        if takeThread then
            coroutine.resume(takeThread, table.remove(q, 1))
        end
    end

    queue.take = function()
        -- If the queue isn't empty then take a value .. 
        if #q > 0 then
            return table.remove(q, 1)
        end
        -- else wait for a value indefinitely.
        takeThread = coroutine.running()
        local value = coroutine.yield()
        takeThread = nil
        return value
    end

    return queue
end
