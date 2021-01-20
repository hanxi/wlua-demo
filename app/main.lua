local wlua = require "wlua"
local log = require "log"
local app = wlua:new()

app:get("/", function (c)
    c:send("Hello wlua!")
end)

app:run()
