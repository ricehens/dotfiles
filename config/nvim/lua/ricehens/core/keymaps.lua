local keymap = vim.keymap

-- set leader
-- vim.g.mapleader = ","

keymap.set("n", "<Tab>", "<Esc>")
keymap.set("n", "r<Tab>", "r<Esc>")
keymap.set("v", "<Tab>", "<Esc>gV")
keymap.set("o", "<Tab>", "<Esc>")
keymap.set("i", "<Tab>", "<Esc>`^")
-- keymap.set("i", "<Leader><Tab>", "<C-v><Tab>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) 
keymap.set("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontally" }) 
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" }) 
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) 
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to left window" }) 
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to upper window" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to right window" })
keymap.set("n", "<leader>sH", "<C-w>H") 
keymap.set("n", "<leader>sJ", "<C-w>J")
keymap.set("n", "<leader>sK", "<C-w>K")
keymap.set("n", "<leader>sL", "<C-w>L")

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) 
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) 
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) 
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) 

