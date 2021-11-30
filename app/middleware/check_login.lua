local util_table = require "util.table"
local log = require "log"

local function is_login(c)
    local login = false
    if c.token then
        local username = c.token.get("username")
        if username and username ~= "" then
            login = true
        end
    end
    return login
end

local function check_login(whitelist)
    local whitehash = util_table.swap_key_value(whitelist)
	return function(c)
		local request_path = c.req.path

	    local in_white_list = false
        if whitehash[request_path] then
            in_white_list = true
        end

        log.debug("check_login:", request_path, in_white_list)

	    if in_white_list then
	        c:next()
	    else
	        if is_login(c) then
	            c:next()
	        else
	            c:send_json({
                    code = "UN_LOGIN",
                    msg = "未登录",
                })
	        end
	    end
	end
end

return check_login
