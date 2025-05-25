return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "在当前目录中模糊查找文件" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "模糊查找最近打开的文件" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "在当前目录中搜索字符串" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "搜索光标下的字符串（在当前目录）" })
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "查找待办事项（TODO）" })
    end,
}
