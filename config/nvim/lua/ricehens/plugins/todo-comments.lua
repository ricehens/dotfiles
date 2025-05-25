return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "]t", function()
            todo_comments.jump_next()  
        end, { desc = "跳转到下一个 TODO 注释" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev() 
        end, { desc = "跳转到上一个 TODO 注释" })

        todo_comments.setup()
    end,
}
