return function(router)

local config = require "config"
local utils = require "app.utils"
local ipairs = ipairs

local users = config.get_tbl("app_users")

router:get("/login", function(c)
    c:send("login")
end)

router:post("/login", function(c)
    local username = c.req.body.username
    local password = c.req.body.password

    for _, v in ipairs(users) do
        if v.username == username and v.password == password then
            local accesstoken = utils.gen_accesstoken(username)
            c.token.set(accesstoken, username)
            c:send_json({
                code = "OK",
                msg = "登录成功",
                accesstoken = accesstoken,
            })
            return
        end
    end

    c:send_json({
        code = "LOGIN_FAILED",
        msg = "Wrong username or password! Please check.",
    })
    return
end)

router:get("/logout", function(c)
    c.token.destroy()
    c:send_json({
        code = "OK",
        msg = "登出成功",
    })
end)

end

