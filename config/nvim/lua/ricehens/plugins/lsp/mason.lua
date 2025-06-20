return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "mason-org/mason-registry",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "bashls",
                "clangd",
                "html",
                "jdtls",
                "pyright",
                "ts_ls",
                "cssls",
                "texlab",
                "hls",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint", -- python linter
                "eslint_d", -- js linter
                -- "clang-tidy", -- c/c++ linter
                "clang-format", -- c/c++ formatter
                "hlint", -- haskell linter
                "ormolu", -- haskell formatter
                "java-debug-adapter", -- java debugger
                -- "checkstyle", -- java linter
            },
        })
    end,
}
