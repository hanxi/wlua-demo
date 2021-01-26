local wlua = require "wlua"
local log = require "log"
local app = wlua:new()

app:get("/", function (c)
    c:send("Hello wlua!")
end)

app:get("/foo", function (c)
    c:send("bar")
end)

app:run()
