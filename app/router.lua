local user_router = require("app.routes.user")
local table_router = require("app.routes.table")

return function(app)
    user_router(app:group("/user"))
    table_router(app:group("/table"))
end
