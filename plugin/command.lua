vim.api.nvim_create_user_command("HotReload", function()
    package.loaded["foo"] = nil
    require("foo")
end
, { desc = "used for hot reload foo.lua" })
