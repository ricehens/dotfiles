return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "显示 LSP 引用"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "跳转到声明"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) 

                opts.desc = "显示 LSP 定义"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) 

                opts.desc = "显示 LSP 实现"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "显示 LSP 类型定义"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) 

                opts.desc = "查看可用的代码操作"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "智能重命名"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) 

                opts.desc = "显示缓冲区诊断"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) 

                opts.desc = "显示行诊断"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) 

                opts.desc = "跳转到上一个诊断"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) 

                opts.desc = "跳转到下一个诊断"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) 

                opts.desc = "显示光标下的文档"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) 

                opts.desc = "重启 LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) 
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["bashls"] = function()
                lspconfig["bashls"].setup({
                    capabilities = capabilities,
                    filetypes = { "sh", "bash" },
                })
            end,
            ["clangd"] = function()
                lspconfig["clangd"].setup({
                    capabilities = capabilities,
                    filetypes = { "c", "h", "cpp" },
                })
            end,
            ["html"] = function()
                lspconfig["html"].setup({
                    capabilities = capabilities,
                    filetypes = { "html" },
                })
            end,
            ["jdtls"] = function()
                lspconfig["jdtls"].setup({
                    capabilities = capabilities,
                    filetypes = { "java" },
                })
            end,
            ["pyright"] = function()
                lspconfig["pyright"].setup({
                    capabilities = capabilities,
                    filetypes = { "py", "python" },
                })
            end,
            ["ts_ls"] = function()
                lspconfig["ts_ls"].setup({
                    capabilities = capabilities,
                    filetypes = { "ts" },
                })
            end,
            ["cssls"] = function()
                lspconfig["cssls"].setup({
                    capabilities = capabilities,
                    filetypes = { "css" },
                })
            end,
            ["hls"] = function()
                lspconfig["hls"].setup({
                    capabilities = capabilities,
                    filetypes = { "haskell", "lhaskell", "cabal" },
                })
            end,
        })
    end,
}
