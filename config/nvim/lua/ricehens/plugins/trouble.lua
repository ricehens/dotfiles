return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "打开 Trouble 中的工作区诊断信息" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "打开 Trouble 中的当前文件诊断信息" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "打开 Trouble 中的快速修复列表" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "打开 Trouble 中的位置列表" },
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "在 Trouble 中查看 TODO 项" },
    }
}
