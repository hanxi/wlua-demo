local auth_router = require("app.routes.auth")
local user_router = require("app.routes.user")
local todo_router = require("app.routes.todo")

return function(app)
    auth_router(app:group("/auth"))
    user_router(app:group("/user"))
    todo_router(app:group("/todo"))
end
