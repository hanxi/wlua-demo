local wlua = require "wlua"
local log = require "log"
local app = wlua:new()

log.info("fuckkkk")
for k,v in pairs(getmetatable(app)) do
    log.info(k,v)
end

app:run()
