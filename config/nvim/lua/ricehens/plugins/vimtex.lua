return {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
            pattern = { "bib", "tex" },
            callback = function()
                vim.wo.conceallevel = 0
            end,
        })
        vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
        vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

        -- vim.g.vimtex_view_method = "zathura" -- <== macos specific, you can use zathura or sumatra or something else.
        vim.g.vimtex_view_method = "zathura_simple" -- <== macos specific, you can use zathura or sumatra or something else.
        -- vim.g.latex_view_general_viewer = "zathura"
        vim.g.vimtex_compiler_progname = "nvr"
        -- vim.g.vimtex_view_skim_sync = 1
        -- vim.g.vimtex_view_skim_activate = 1
        -- vim.g.vimtex_view_skim_reading_bar = 1

        -- vim.g.vimtex_compiler_latexmk = {
            -- aux_dir = "./aux",
            -- out_dir = "./out",
        -- }
        vim.g.vimtex_view_zathura_check_libsynctex = true

        vim.g.vimtex_fold_enabled = true

    end,
}
