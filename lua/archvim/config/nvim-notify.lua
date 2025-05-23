return {
    "rcarriga/nvim-notify",
    evnet  = "VeryLazy",
    opt    = {
        background_colour = "#000000",
        render = "minimal",
        minimum_width = 50,
        max_width = 100,
        timout = 1000,
    },
    config = function()
        local old_notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("warning: multiple different client offset_encodings") then
                return
            end
            if msg:match("clipboard: error: Error: target STRING not available") then
                return
            end
            if msg:match("You cannot close the last tab! This will exit neovim") then
                return
            end
            if msg:match("message = \"trying to get preamble for non-added document\"") then
                return
            end
            if msg:match("\"lsp_signatur handler\",") then
                return
            end
            if msg:match("No results for %*%*") then
                -- transform "No results for **qflist**\nBuffer: /home/bate/Codes/cppguidebook/examples/error_code.cpp"
                -- into "No results for **qflist**"
                msg = msg:gsub("No results for %*%*([%w_]+)%*%*\nBuffer: .+", "No results for %1")
            end

            old_notify(msg, ...)
        end
    end
}
