local skynet = require "skynet"
local crypt = require "skynet.crypt"
local sformat = string.format

local M = {}

function M.gen_accesstoken(username)
    local now = skynet.time()
    local rnd = math.random(1, 1000)
    local sign = crypt.sha1(now .. username .. rnd)
    local str = sformat("%s,%s,%s", now, username, sign)
    return crypt.base64encode(str)
end

return M
