-- 设置 leader 键为空格
vim.g.mapleader = " "

-- nvim 基本配置
vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号


-- 缩进设置
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false -- 不将 tab 替换为 空格，tab 党!!!!
vim.opt.smartindent = true
vim.opt.autoindent = true -- 复制当前行的缩进

-- 真色彩
vim.o.termguicolors = true

-- 边框样式
vim.opt.winborder = "rounded"

-- 共享系统剪切板
vim.opt.clipboard = "unnamedplus" 

-- 搜索
vim.opt.ignorecase = true -- 搜索忽略大小写
vim.opt.smartcase = true -- 如果包含大写字符，则区分大小写
vim.opt.incsearch = true -- 增量搜索

-- 窗口获得焦点时，短暂高亮当前行
vim.opt.cursorline = false

vim.api.nvim_create_autocmd({"WinEnter", "FocusGained"}, {
    callback = function()
        local win = vim.api.nvim_get_current_win()

        vim.wo[win].cursorline = true

        vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(win) then
                vim.wo[win].cursorline = false
            end
        end, 400)
    end,
})

-- 复制时闪烁当前行
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator ~= "y" then
            return
        end

        local win = vim.api.nvim_get_current_win()

        -- 开启当前行高亮
        vim.wo[win].cursorline = true

        -- 300 毫秒后关闭
        vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(win) then
                vim.wo[win].cursorline = false
            end
        end, 400)
    end,
})

-- 取消自动换行注释
vim.api.nvim_create_autocmd("FileType", {
	desc = "取消自动换行注释",
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r" })
	end,
})

-- 自动保存当前缓冲区或切换缓冲区时保存
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	pattern = "*",
	callback = function()
		-- 检查缓冲区类型是否为普通文件
		if vim.bo.buftype == "" and vim.bo.modified and vim.fn.expand("%") ~= "" then
			local success, err = pcall(function()
				vim.cmd("write")
			end)

			if not success then
				vim.notify("保存文件时出错: " .. err, vim.log.levels.ERROR)
			end
		end
	end,
})

-- 按键映射
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


-- 暂时用不到的配置
-- 关闭位置列表（location list）和快速修复列表窗口（quickfix list）
-- 快捷键是 \x,用[[]] 包裹这是lua的长字符串语法，[[]]是lua提供的一种字符串定义方式
-- 等价于  keymap.set("n", "\\x", "<cmd>windo lclose <bar> cclose <cr>, \ 还需要用\ 转义
-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
-- keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
--  silent = true,
--  desc = "close qf and location list",
-- })
-- 但目前感觉没用，所以先不用
