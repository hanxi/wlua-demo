local wlua = require "wlua"
local log = require "log"
local app = wlua:default()
local util_json = require "util.json"

app:use(function(c)
    log.debug("in app use")
end)

app:get("/", function (c)
    c:send("Hello wlua!")
end)


local handler = function (c)
    local ret = string.format("the method was %s and index %d", c.req.method, c.index)
    c:send(ret)
end

local v1 = app:group("/v1", function (c)
    c:send("in v1")
end)

local login = v1:group("/login/", function (c)
    c:send("in login/")
end)

v1:use(function(c)
    log.debug("in v1 use")
end)

v1:get("/test", handler)

login:use(function(c)
    log.debug("in login use")
end)

login:get("/test", handler)

app:get("/foo", function (c)
    log.debug("c.req.query:", util_json.encode(c.req.query))
    c:send("bar")
end)

app:post("/foo/", function (c)
    log.debug("c.req.query:", util_json.encode(c.req.query))
    log.debug("c.req.body:", util_json.encode(c.req.body))
    c:send("bar/")
end)

app:get("/json", function (c)
    local tbl = {
        A = "AAA",
        B = 111,
    }
    c:send_json(tbl)
end)

app:set_no_route(function(c)
    c:send("Not found", 404)
end)

app:run()
