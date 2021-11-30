return function(router)

local ipairs = ipairs
local tremove = table.remove
local tinsert = table.insert
local todos = require "app.model.todo"

router:post("/complete", function(c)
    local id = c.req.body.id
    local completed = c.req.body.completed
    if completed == "true" then
        completed = true
    else
        completed = false
    end

    for _, v in ipairs(todos) do
        if v.id == id then
            v.completed = completed
        end
    end

    c:send_json({
        code = "OK",
        msg = "mark successful",
    })
end)

router:put("/add", function(c)
    local id = c.req.body.id
    local title = c.req.body.title
    local completed = c.req.body.completed
    if completed == "true" then
        completed = true
    else
        completed = false
    end

    tinsert(todos, {
        id = id,
        title = title,
        completed = completed
    })

    c:send_json({
        code = "OK",
        msg = "add successful",
    })
end)

router:post("/update", function(c)
    local id = c.req.body.id
    local title = c.req.body.title

    for _, v in ipairs(todos) do
        if v.id == id then
            v.title = title
        end
    end

    c:send_json({
        code = "OK",
        success = true,
        msg = "update successful",
    })
end)

router:delete("/delete", function(c)
    local id = c.req.body.todoId

    for i=#todos, 1, -1 do
        if todos[i].id == id then
            tremove(todos,i)
        end
    end

    c:send_json({
        code = "OK",
        msg = "delete successful",
        data = {
            deleteId = id,
            todosLength = #todos,
            todos = todos
        }
    })
end)

router:get("/find/{filter}", function(c)
    local todo_type = c.params.filter
    local return_todos = {}

    if todo_type ~= "all" and todo_type ~= "active" and todo_type ~= "completed" then
        c:send_json({
            code = "WRONG_TODO_TYPE",
            msg = "wrong todo type, type must be one of 'all', 'active' or 'completed'",
        })
    else
        for _, v in ipairs(todos) do
            local completed = v.completed
            if todo_type == "all" then
                tinsert(return_todos, v)
            elseif todo_type == "active" and not completed then
                tinsert(return_todos, v)
            elseif todo_type == "completed" and completed then
                tinsert(return_todos, v)
            end
        end

        c:send_json({
            code = "OK",
            data = return_todos
        })
    end
end)

router:get("/index", function(c)
    local accesstoken = c.req.headers["x-access-token"]
    local username = c.token.get(accesstoken)
    c:send_json({
        code = "OK",
        data = {
            username = username,
        },
    })
end)

end
