local wlua = require "wlua"
local config = require "config"
local log = require "log"
local token_middleware = require "app.middleware.token"
local check_login_middleware = require "app.middleware.check_login"
local router = require "app.router"

local app = wlua:default()
app:use(token_middleware())

-- filter: add response header
app:use(function(c)
    c:set_res_header('X-Powered-By', 'wlua framework')
    c:next()
end)

-- intercepter: login or not
local whitelist = config.get_tbl("app_whitelist")
app:use(check_login_middleware(whitelist))

router(app) -- business routers and routes

app:static_file("/favicon.ico", "favicon.ico")
app:static_file("/", "index.html")
app:static_dir("/static", "./")

app:get("/t.txt", function (c)
    log.debug("in t.txt")
    c:file("t.txt")
end)

app:get("/x.jpg", function (c)
    c:file("x.jpg")
end)

app:run()

