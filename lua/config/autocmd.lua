-- 自动命令等

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

        -- 400 毫秒后关闭
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
