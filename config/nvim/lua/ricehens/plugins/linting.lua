return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            java = { "checkstyle" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            python = { "pylint" },
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            haskell = { "hlint" },
        }

        local checkstyle = lint.linters.checkstyle
        checkstyle.cmd = "/opt/homebrew/bin/checkstyle" -- mason is out-of-date
        checkstyle.config_file = vim.fn.expand("$HOME/.checkstyle/checkstyle.xml")

        local clangtidy = lint.linters.clangtidy
        clangtidy.cmd = "/opt/homebrew/opt/llvm/bin/clang-tidy"
        clangtidy.args = {
            "--quiet",                 
            "--checks=bugprone*,performance*,misc*,clang-analyzer*",
            -- "--checks=bugprone*,cppcoreguidelines*,modernize*,performance*,readability*,misc*,clang-analyzer*",
            -- "--checks=bugprone*,modernize*,performance*,misc*,clang-analyzer*",
            -- "%file",              
            -- "--",
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>i", function()
            lint.try_lint()
        end, { desc = "对当前文件执行 lint 检查" })
    end,
}

