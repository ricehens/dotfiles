return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "恢复当前目录的会话" }) -- 恢复当前目录下最近保存的工作区会话
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "保存当前目录的会话" }) -- 保存当前工作目录的会话（自动以会话根目录命名）
    end,
}
