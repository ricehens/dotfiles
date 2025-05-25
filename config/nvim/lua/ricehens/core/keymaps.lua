local keymap = vim.keymap

-- 设置 leader 键
-- vim.g.mapleader = ","

keymap.set("n", "<Tab>", "<Esc>")
keymap.set("n", "r<Tab>", "r<Esc>")
keymap.set("v", "<Tab>", "<Esc>gV")
keymap.set("o", "<Tab>", "<Esc>")
keymap.set("i", "<Tab>", "<Esc>`^")
-- keymap.set("i", "<Leader><Tab>", "<C-v><Tab>")

-- 窗口管理
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "垂直分割窗口" }) 
keymap.set("n", "<leader>ss", "<C-w>s", { desc = "水平分割窗口" }) 
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "使所有分割窗口等宽/等高" }) 
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "关闭当前分割窗口" }) 
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "跳转到左侧窗口" }) 
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "跳转到下方窗口" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "跳转到上方窗口" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "跳转到右侧窗口" })
keymap.set("n", "<leader>sH", "<C-w>H", { desc = "将当前窗口移动到最左侧"})
keymap.set("n", "<leader>sJ", "<C-w>J", { desc = "将当前窗口移动到最下方"})
keymap.set("n", "<leader>sK", "<C-w>K", { desc = "将当前窗口移动到最上方"})
keymap.set("n", "<leader>sL", "<C-w>L", { desc = "将当前窗口移动到最右侧"})

-- 标签页管理
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "打开新标签页" }) 
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "关闭当前标签页" }) 
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "跳转到下一个标签页" }) 
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "跳转到上一个标签页" }) 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "在新标签页中打开当前缓冲区" }) 

-- 合并冲突
keymap.set("n", "<leader>dl", "<cmd>diffget LOCAL<CR>", { desc = "从本地版本合并当前缓冲区" })
keymap.set("n", "<leader>dr", "<cmd>diffget REMOTE<CR>", { desc = "从远程版本合并当前缓冲区" })
keymap.set("n", "<leader>db", "<cmd>diffget BASE<CR>", { desc = "从基准版本合并当前缓冲区" })
