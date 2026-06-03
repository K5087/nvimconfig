vim.api.nvim_create_user_command("Moke", require("cfcc").code_action, { desc = "test functions" })
