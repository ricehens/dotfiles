return {
    "L3MON4D3/LuaSnip",
    opts = {
        history = true,
        delete_check_events = "TextChanged",
    },
    config = function()
        local ls = require("luasnip")

        vim.keymap.set({"i"}, "<C-L>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})

        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})

        require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets"})
    end,
}
