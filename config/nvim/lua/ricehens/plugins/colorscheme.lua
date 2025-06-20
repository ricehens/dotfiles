return {
    { "shaunsingh/nord.nvim", name = "nord", priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme nord]])
        end,
    },
    { "AlexvZyl/nordic.nvim", name = "nordic", priority = 1000,
        config = function()
            require('nordic').setup({
                after_palette = function(palette)
                    local U = require("nordic.utils")
                    palette.bg_visual = U.blend(palette.blue0, palette.bg, .2)
                    -- palette.comment = palette.gray5
                    palette.comment = U.blend(palette.gray4, palette.white0, .6)
                end,
                swap_backgrounds = true,
                -- cursorline = {
                    -- blend = 2,
                -- }
            })
            -- vim.cmd([[colorscheme nordic]])
        end,
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            -- load the colorscheme here
            --vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "folke/tokyonight.nvim",
        name = "modified_tokyonight",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            local bg = "#011628"
            local bg_dark = "#011423"
            local bg_highlight = "#143652"
            local bg_search = "#0A64AC"
            local bg_visual = "#275378"
            local fg = "#CBE0F0"
            local fg_dark = "#B4D0E9"
            local fg_gutter = "#627E97"
            local border = "#547998"

            require("tokyonight").setup({
                style = "night",
                on_colors = function(colors)
                    colors.bg = bg
                    colors.bg_dark = bg_dark
                    colors.bg_float = bg_dark
                    colors.bg_highlight = bg_highlight
                    colors.bg_popup = bg_dark
                    colors.bg_search = bg_search
                    colors.bg_sidebar = bg_dark
                    colors.bg_statusline = bg_dark
                    colors.bg_visual = bg_visual
                    colors.border = border
                    colors.fg = fg
                    colors.fg_dark = fg_dark
                    colors.fg_float = fg
                    colors.fg_gutter = fg_gutter
                    colors.fg_sidebar = fg_dark
                end,
            })
            -- load the colorscheme here
            -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        name = "vscode",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme vscode]])
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                -- flavour = "mocha",
                no_italic = true,
                integrations = {
                    mason = true,
                    which_key = true,
                }
            })
            -- vim.cmd([[colorscheme catppuccin]])
        end,
    }
}
