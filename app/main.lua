local wlua = require "wlua"
local log = require "log"
local app = wlua:new()
local util_json = require "util.json"

app:get("/", function (c)
    c:send("Hello wlua!")
end)

app:get("/foo", function (c)
    log.debug("c.req.query:", util_json.encode(c.req.query))
    c:send("bar")
end)

app:post("/foo/", function (c)
    log.debug("c.req.query:", util_json.encode(c.req.query))
    log.debug("c.req.body:", util_json.encode(c.req.body))
    c:send("bar/")
end)

app:set_no_route(function(c)
    c:send("Not found", 404)
end)

app:run()
