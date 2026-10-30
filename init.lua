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
vim.opt.hlsearch = false -- 搜索匹配不高亮
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
