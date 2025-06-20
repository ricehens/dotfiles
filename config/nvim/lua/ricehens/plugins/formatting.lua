return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                python = { "isort", "black" },
                tex = { "latexindent" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                haskell = { "ormolu" },
            },
            -- format_on_save = {
                -- lsp_fallback = true,
                -- async = false,
                -- timeout_ms = 1000,
            -- },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "格式化整个文件或选中区域（可视模式下）" })
    end,
}
