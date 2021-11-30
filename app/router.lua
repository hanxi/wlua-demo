local auth_router = require("app.routes.auth")
local user_router = require("app.routes.user")

return function(app)
    auth_router(app:group("/auth"))
    user_router(app:group("/user"))
end
