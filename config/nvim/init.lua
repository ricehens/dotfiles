-- BASE VIM SETTINGS
do
    -- faster startup
    vim.loader.enable() 

    -- leader key
    vim.g.mapleader = '\\'
    vim.g.maplocalleader = '\\'

    -- encoding
    vim.opt.encoding = "utf-8"

    -- no sounds
    vim.opt.belloff = "all"

    -- line numbers
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- tabs
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.autoindent = true

    -- line wrapping
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true

    -- search
    vim.opt.ignorecase = true
    vim.opt.smartcase = true  

    -- show command as it is being typed
    vim.opt.showcmd = true

    -- highlight search results as typed
    vim.opt.incsearch = true
    vim.opt.hlsearch = true

    -- command completion menu
    vim.opt.wildmenu = true
    vim.opt.wildmode = "longest,list"

    -- highlight current line
    vim.opt.cursorline = true

    -- colors
    vim.opt.termguicolors = true
    vim.opt.background = "dark"

    -- signs in the left column 
    vim.opt.signcolumn = "auto"

    -- backspace everything
    vim.opt.backspace = "indent,eol,start"

    -- new windows appear to right/below instead of left/above
    vim.opt.splitright = true
    vim.opt.splitbelow = true

    -- swapfiles
    vim.opt.swapfile = true
    vim.opt.undofile = true
    vim.opt.directory = os.getenv("HOME") .. "/.local/share/nvim/tmp//"
    vim.opt.backupdir = os.getenv("HOME") .. "/.local/share/nvim/tmp//"
    vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/tmp//"

    -- spell
    vim.opt.spell = true
    vim.opt.spelllang = { "en_us", "cjk" }

    -- custom filetypes
    vim.filetype.add({
        extension = { dcf = "decaf", ms = "bsv", mit = "mitscript" },
    })

    -- nerd font installed
    vim.g.have_nerd_font = true

    -- mouse mode (e.g. resize splits)
    vim.opt.mouse = 'a'

    -- screen lines to keep below and above cursor
    vim.opt.scrolloff = 10

    -- update time (e.g. for cursor hover)
    vim.opt.updatetime = 250

    -- default do not fold
    vim.opt.foldlevel = 99
end

-- BASE KEYMAPS
do
    -- tab to escape
    vim.keymap.set("n", "r<Tab>", "r<Esc>")
    vim.keymap.set("v", "<Tab>", "<Esc>gV")
    vim.keymap.set("o", "<Tab>", "<Esc>")
    vim.keymap.set("s", "<Tab>", "<Esc>")
    vim.keymap.set("i", "<Tab>", "<Esc>`^")
    -- vim.keymap.set("i", "<Leader><Tab>", "<C-v><Tab>")

    -- clear search
    vim.keymap.set('n', '<Tab>', '<cmd>nohlsearch<CR>')

    -- split navigation
    vim.keymap.set("n", "<C-;>", "<C-w>v", { desc = "新右窗" }) 
    vim.keymap.set("n", "<C-'>", "<C-w>s", { desc = "新下窗" }) 
    vim.keymap.set("n", "<C-x>", "<cmd>close<CR>", { desc = "关此窗" }) 
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "去左窗" }) 
    vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "去下窗" })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "去上窗" })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "去右窗" })
    vim.keymap.set("n", "<C-M-h>", "<C-w>H", { desc = "移窗左" })
    vim.keymap.set("n", "<C-M-j>", "<C-w>J", { desc = "移窗下" })
    vim.keymap.set("n", "<C-M-k>", "<C-w>K", { desc = "移窗上" })
    vim.keymap.set("n", "<C-M-l>", "<C-w>L", { desc = "移窗右" })

    -- tab navigation
    vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "打开新标签页" }) 
    vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "关闭当前标签页" }) 
    vim.keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "跳转到下一个标签页" }) 
    vim.keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "跳转到上一个标签页" }) 
    vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "在新标签页中打开当前缓冲区" }) 
end

-- special plugin that require build
do
 local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

local gh = function(x) return 'https://github.com/' .. x end

-- small ui/ux
do
    -- nerd icons
    if vim.g.have_nerd_font then
        vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }
    end

    -- add git signs to gutter
    vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
    require('gitsigns').setup {
        signs = {
            add = { text = '+' }, 
            change = { text = '~' }, 
            delete = { text = '_' },
            topdelete = { text = '‾' }, 
            changedelete = { text = '~' }, 
        },
    }

    -- show pending keybinds
    vim.pack.add { gh 'folke/which-key.nvim' }
    require('which-key').setup {
        delay = 0,
        icons = { mappings = vim.g.have_nerd_font },
    }

    -- resize pane
    vim.pack.add { gh 'mrjones2014/smart-splits.nvim' }
    local smart_splits = require 'smart-splits'
    vim.keymap.set('n', '<M-h>', smart_splits.resize_left, { desc = '窗左胀' })
    vim.keymap.set('n', '<M-j>', smart_splits.resize_down, { desc = '窗下胀' })
    vim.keymap.set('n', '<M-k>', smart_splits.resize_up, { desc = '窗上胀' })
    vim.keymap.set('n', '<M-l>', smart_splits.resize_right, { desc = '窗右胀' })

    -- infer indentation style
    vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
    require('guess-indent').setup {}

    -- highlight todo comments 
    vim.pack.add { gh 'folke/todo-comments.nvim' }
    require('todo-comments').setup { signs = false }

    -- colorscheme
    vim.pack.add { gh 'shaunsingh/nord.nvim' }
    vim.pack.add { gh 'AlexvZyl/nordic.nvim' }
    vim.pack.add { gh 'Mofiqul/vscode.nvim' }
    vim.pack.add { gh 'catppuccin/nvim' }
    require('catppuccin').setup {
        flavour = 'macchiato'
    }
    vim.pack.add { gh 'rebelot/kanagawa.nvim' }
    require('kanagawa').setup {
        opts = {
            background = {
                dark = 'wave',
                light = 'lotus'
            }
        },
    }
    vim.cmd.colorscheme 'catppuccin-macchiato'

    -- bufferline
    vim.pack.add { gh 'akinsho/bufferline.nvim' }
    require('bufferline').setup {
        options = {
            mode = "tabs",
            separator_style = "slant",
        },
    }

    -- show bar for indentation
    vim.pack.add{ gh 'lukas-reineke/indent-blankline.nvim' }
    require('ibl').setup {
        indent = { char = "┊" },
    }

    -- lualine
    vim.pack.add{ gh 'nvim-lualine/lualine.nvim' }
    local colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        red = "#FF4A4A",
        fg = "#c3ccdc",
        bg = "#112638",
        inactive_bg = "#2c3043",
    }
    local lualine_theme = {
        normal = {
            a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
            a = { bg = colors.green, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
            a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
            a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
            a = { bg = colors.red, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
            a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
            b = { bg = colors.inactive_bg, fg = colors.semilightgray },
            c = { bg = colors.inactive_bg, fg = colors.semilightgray },
        },
    }
    require('lualine').setup({
        options = {
            theme = lualine_theme,
        },
        sections = {
            lualine_x = {
                { "encoding" },
                { "fileformat" },
                { "filetype" },
            },
        },
    })

end

-- file explorer: nvim-tree
do
    vim.pack.add { gh 'nvim-tree/nvim-tree.lua' }
    require('nvim-tree').setup {
        view = {
            width = 35,
            relativenumber = true,
        },
        -- disable window_picker
        -- else bad behavior with window splits
        actions = {
            open_file = {
                window_picker = {
                    enable = false,
                },
            },
        },
        filters = { custom = { ".DS_Store" }, },
        git = { ignore = false, },
    }
    -- do not load default file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "打开 nvim-tree" })
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "打开 nvim-tree 并定位当前文件" }) 
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "折叠 nvim-tree 中的所有目录" }) 
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "刷新 nvim-tree" }) 
end

-- search: fzf, telescope
do
    vim.pack.add {
        gh 'nvim-lua/plenary.nvim',
        gh 'nvim-telescope/telescope.nvim',
        gh 'nvim-telescope/telescope-ui-select.nvim',
        gh 'nvim-telescope/telescope-fzf-native.nvim',
    }
    require('telescope').setup {
        extensions = {
            ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
        defaults = {
            mappings = {
                n = {
                    ["<Tab>"] = require('telescope.actions').close, -- Tab to close in normal mode
                },
                i = {
                    ["<Tab>"] = require('telescope.actions').close, -- Tab to close in insert mode
                },
            },
        },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- keybinds
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '搜文件' })
    vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, { desc = '搜当前词' })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '搜以grep' })
    vim.keymap.set('n', '<leader>D', builtin.diagnostics, { desc = '搜诊断' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '续搜' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '搜最近打开文件' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '搜命令' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '搜现有缓冲区' })
    vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] fzf 当前缓冲区' })
    vim.keymap.set(
        'n',
        '<leader>f/',
        function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end,
        { desc = '搜所有打开文件' }
    )

    -- attach to lsp
    vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf
      vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = 'Goto references' })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = buf, desc = 'Goto implementation' })
      -- 按 <C-t> 以返回
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = 'Goto definition' })
      vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open document symbols' })
      vim.keymap.set('n', 'gw', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open workspace symbols' })
      vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto type definition' })
    end,
  })
end

-- LSP diagonostics
vim.diagnostic.config({
    virtual_text = true, -- shows up at end of line
    virtual_lines = false,
    float = {
        border = "rounded",   
        source = "always",   
        header = "",         
        prefix = "",         
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
        },
    },
    -- auto-open when jumping with [d, ]d
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
})

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = '显示行诊断' }) 
vim.keymap.set('n', 'K', function ()
	vim.lsp.buf.hover({
		border = 'rounded',
	})
end, { desc = '显示光标下的文档' }) 
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '上一个诊断' }) 
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '下一个诊断' }) 

-- LSP setup
do
    -- notifs, incl from lsp
    vim.pack.add { gh 'j-hui/fidget.nvim' }
    require('fidget').setup {}

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
            -- keybinds
            local map = function(keys, func, desc, mode)
                mode = mode or 'n'
                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end
            map('<leader>rn', vim.lsp.buf.rename, 'Rename')
            map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, 'Goto declaration')
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = 'Restart LSP' } ) 

            -- highlight references of when cursor rests on word
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                    end,
                })

                -- toggle inlay hints
                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>gh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle inlay hints')
                end
            end
        end,
    })
end

-- LSP servers
do
    local servers = {
        -- jdtls = {},
        bashls = {},
        clangd = {},
        html = {},
        pyright = {},
        ts_ls = {},
        cssls = {},
        hls = {},
    }

    vim.pack.add {
        gh 'neovim/nvim-lspconfig',
        gh 'mason-org/mason.nvim',
        gh 'mason-org/mason-lspconfig.nvim',
        gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
    }
    require('mason').setup {}

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
        "prettier", -- prettier formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        -- "clang-tidy", -- c/c++ linter
        "clang-format", -- c/c++ formatter
        "hlint", -- haskell linter
        "ormolu", -- haskell formatter
        "jdtls", -- java language server
        "java-debug-adapter", -- java debugger
        "checkstyle", -- java linter
        "latexindent", -- latex formatter
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
    end
end

-- AUTOFORMAT
do
    vim.pack.add { gh 'stevearc/conform.nvim' }
    require('conform').setup {
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
    }

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        require('conform').format({
            lsp_fallback = true,
            async = false,
            -- timeout_ms = 1000,
        })
    end, { desc = "格式化" })
end

-- SNIPPETS
do
    -- snippets
    vim.pack.add { gh 'L3MON4D3/LuaSnip' } 
    local ls = require('luasnip')
    ls.setup {
        history = true,
        delete_check_events = "TextChanged",
    }
    vim.keymap.set({"i"}, "<C-L>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, {silent = true})

    require("luasnip.loaders.from_snipmate").load({paths = "./snippets"})
end

-- AUTOCOMPLETE
do
    vim.pack.add { gh 'saghen/blink.lib' }
    vim.pack.add { gh 'saghen/blink.cmp' }
    vim.pack.add { gh 'saghen/blink.compat' } -- for nvim-cmp plugins
    vim.pack.add { gh 'micangl/cmp-vimtex' } 
    require('cmp_vimtex').setup {}
    require('blink.cmp').setup {
        enabled = function()
            return vim.api.nvim_buf_get_name(0) ~= ''
        end,

        keymap = {
            -- <tab>/<s-tab>: move to right/left of your snippet expansion
            -- <c-space>: Open menu or open docs if already open
            -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
            -- <c-e>: Hide menu
            -- <c-k>: Toggle signature help
            -- preset = 'default', -- <C-y> to accept; 'enter' for enter to accept
            ['<C-y>'] = { 'accept', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },

            -- do not redefine tab >:(
            ['<Tab>'] = {},
            ['<S-Tab>'] = {},
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        -- auto-show documentation
        completion = {
            trigger = {
                show_on_keyword = true,
                show_on_trigger_character = true,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0
            },
            documentation = {
                window = {
                    border = "rounded", 
                },
            },
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'vimtex' },
            providers = {
                vimtex = {
                    name = 'vimtex',
                    module = 'blink.compat.source',
                    score_offset = 200
                },
            },
        },

        snippets = { preset = 'luasnip' },

        -- prefer lua impl of fuzzy-matcher to rust
        fuzzy = { implementation = 'lua' },

        -- function signature help window when calling function
        signature = { enabled = true },
    }
end

-- TREESITTER
do
    vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }

    local parsers = { 
        "java", "c", "cpp", "python", "lua", "vim", "vimdoc", "javascript", "html", "css", "typescript", "csv", "bash", "yaml", "haskell", "pascal",
        "latex", "bibtex", "make", "kotlin"
    }
    require('nvim-treesitter').install(parsers)

    local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)

        -- treesitter-based folds
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        -- treesitter-based indentation
        -- local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
        -- if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
    end

    local available_parsers = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
            local buf, filetype = args.buf, args.match

            local language = vim.treesitter.language.get_lang(filetype)
            if not language then return end

            local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

            if vim.tbl_contains(installed_parsers, language) then
                treesitter_try_attach(buf, language)
            elseif vim.tbl_contains(available_parsers, language) then
                require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
            else
                treesitter_try_attach(buf, language)
            end
        end,
    })
end

-- LINT
do
    vim.pack.add { gh 'mfussenegger/nvim-lint' }

    local lint = require('lint')
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

    -- autocmd to lint
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
            if vim.bo.modifiable then lint.try_lint() end
        end,
    })

    local checkstyle = lint.linters.checkstyle
    -- checkstyle.cmd = "/opt/homebrew/bin/checkstyle" -- mason is out-of-date
    checkstyle.config_file = vim.fn.expand("$HOME/.checkstyle/checkstyle.xml")

    local clangtidy = lint.linters.clangtidy
    clangtidy.cmd = "/opt/homebrew/opt/llvm/bin/clang-tidy"
    clangtidy.args = {
        "--quiet",                 
        "--checks=bugprone*,performance*,misc*,clang-analyzer*",
    }

    local eslint_d = lint.linters.eslint_d
    eslint_d.args = {
        '--no-warn-ignored',
        '--format',
        'json',
        '--stdin',
        '--stdin-filename',
        function()
            return vim.api.nvim_buf_get_name(0)
        end,
    }

    local pylint = lint.linters.pylint
    pylint.cmd = 'python3'
    pylint.args = {
        '-m', 'pylint', '-f', 'json',
        "--from-stdin", function()
            return vim.api.nvim_buf_get_name(0)
        end,
        '--disable=all',
        '--enable=F,E,W0611,W0612,W0621', 
    }
end

-- AUTOPAIRS
do
    vim.pack.add { gh 'windwp/nvim-autopairs' }
    local autopairs = require('nvim-autopairs')
    autopairs.setup {
        check_ts = true, 
        ts_config = {
            lua = { "string" }, 
            javascript = { "template_string" }, 
            java = false, 
        },
    }
    autopairs.get_rules("'")[1].not_filetypes = { "tex", "latex" }
    autopairs.get_rules("`")[1].not_filetypes = { "tex", "latex" }
end

-- LaTeX
do
    vim.pack.add { gh 'lervag/vimtex' }
    vim.g.vimtex_syntax_conceal_disable = 1
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- conflict with LSP 
    vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    vim.g.vimtex_view_general_viewer = "zathura"
    vim.g.vimtex_view_method = "zathura_simple" 
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_view_zathura_check_libsynctex = true
    vim.g.vimtex_fold_enabled = true
end

-- JAVA
do
    vim.pack.add({
        {
            src = 'https://github.com/JavaHello/spring-boot.nvim',
            version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
        },
        'https://github.com/MunifTanjim/nui.nvim',
        'https://github.com/mfussenegger/nvim-dap',
        'https://github.com/nvim-java/nvim-java',
    })

    require('java').setup({
        jdk = {
            auto_install = false,
        },
    })

    local function sdk(jdk)
        return vim.fn.expand('~/.sdkman/candidates/java/' .. jdk)
    end

    vim.lsp.config('jdtls', {
        settings = {
            java = {
                format = {
                    enabled = true,
                    settings = {
                        url = vim.uri_from_fname(vim.fn.expand('~/.config/nvim/lsp/java.xml')),
                    },
                },
                configuration = {
                    runtimes = {
                        {
                            name = 'JavaSE-21',
                            path = sdk('21.0.11-oracle'),
                            default = true,
                        },
                        {
                            name = 'JavaSE-25',
                            path = sdk('25.0.3-oracle'),
                        },
                    },
                },
            },
        },
    })

    vim.lsp.enable('jdtls')
end

-- llama
do
    vim.pack.add { gh 'ggml-org/llama.vim' }
    -- $ llama-server --fim-qwen-3b-default
    vim.g.llama_config = {
        keymap_fim_accept_full = "<C-g>",
        keymap_fim_accept_line = "<C-S-g>",
        keymap_inst_accept     = "<C-g>",
        keymap_inst_cancel     = "<Tab>",
    }
end

-- Codeium
--[[
do
    vim.pack.add { gh 'Exafunction/windsurf.nvim' }
    -- note: :Codeium Toggle to toggle
    require('codeium').setup {
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            key_bindings = {
                accept = "<C-g>",
                next = "<C-.>",
                prev = "<C-,>",
                clear = "<C-x>",
            },
        },
    }
end
]]--
