return function(router)

local model_table = require "app.model.table"

router:get("/list", function(c)
    local items = model_table.generate_items()
    c:send_json({
        code = "OK",
        data = {
            items = items,
        },
    })
end)

end
