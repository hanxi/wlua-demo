return function(router)

local config = require "config"
local utils = require "app.utils"
local ipairs = ipairs

local users = config.get_tbl("app_users")

router:get("/info", function(c)
    local username = c.token.get('username')
    local info = users[username]

    c:send_json({
        code = "OK",
        msg = "登录成功",
        data = info,
    })
end)

router:post("/login", function(c)
    local username = c.req.body.username
    local password = c.req.body.password

    local info = users[username]
    if info and info.password == password then
        local accesstoken = utils.gen_accesstoken(username)
        c.token.set(accesstoken, username)
        c:send_json({
            code = "OK",
            msg = "登录成功",
            data = {
                token = accesstoken,
            }
        })
        return
    end

    c:send_json({
        code = "LOGIN_FAILED",
        msg = "Wrong username or password! Please check.",
    })
    return
end)

router:post("/logout", function(c)
    c.token.destroy()
    c:send_json({
        code = "OK",
        msg = "登出成功",
    })
end)

end

