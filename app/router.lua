local user_router = require("app.routes.user")
local todo_router = require("app.routes.todo")

return function(app)
    user_router(app:group("/user"))
    todo_router(app:group("/todo"))
end
