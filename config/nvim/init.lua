require("ricehens.core")
require("ricehens.lazy")

-- some things that only work here for some reason
local autopairs = require("nvim-autopairs")
autopairs.get_rules("'")[1].not_filetypes = { "tex", "latex" }
autopairs.get_rules("`")[1].not_filetypes = { "tex", "latex" }
