---- 按键映射
-- 在当前行的上下方粘贴复制的内容，并且返回原位置
vim.keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
vim.keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- ctrl + s 的作用
vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })

-- 按实际行移动光标，而不是逻辑行，如果想按逻辑行，则添加数字
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })


-- 使用 c 修改时不让被修改的内容进行默认寄存器，以免造成覆盖
-- 注意：如果想要用 p 找回删除的内容，就用 d 删除，c 不会找回
vim.keymap.set("n", "c", '"_c') -- change t
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("x", "c", '"_c')

-- 在 visual 模式下粘贴覆盖所选内容时，被覆盖内容会污染寄存器导致粘贴的内容消失
-- 用此映射防止插件一定要下载能把光标所在行上下移动的那个插件
vim.keymap.set("x", "p", '"_c<Esc>p')

-- 行移动（但是这个移动方式不习惯）
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- 窗口
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- 还有可以调整窗口大小的快捷键
vim.keymap.set("n", "<up>", ":res +5<cr>", { desc = "" })
vim.keymap.set("n", "<down>", ":res -5<cr>", { desc = "" })
vim.keymap.set("n", "<left>", ":vertical resize+5<cr>", { desc = "" })
vim.keymap.set("n", "<right>", ":vertical resize-5<cr>", { desc = "" })


-- no highlight search
vim.keymap.set("n", "<leader><cr>", ":nohlsearch<cr>", { desc = "No highlight search" })

-- 缩进
vim.keymap.set("n", "<", "<<", { desc = "Indent" })
vim.keymap.set("n", ">", ">>", { desc = "Deindent" })

-- buffer switcher
vim.keymap.set("n", "bh", ":bp<cr>", { desc = "" })
vim.keymap.set("n", "bl", ":bn<cr>", { desc = "" })
