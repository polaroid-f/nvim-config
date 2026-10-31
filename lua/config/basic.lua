-- nvim 基础配置

-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
