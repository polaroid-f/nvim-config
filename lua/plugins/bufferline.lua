-- 1. bh 和 bl <leader>bb 都是在缓冲区之间切换，bh 是切换到上一个缓冲区，bl 切换到下一个缓冲区（不是左右），<leader>bb 是在上一个编辑的缓冲区和该缓冲区之间切换
-- 2. <leader>bo 删除其他缓冲区 , <leader>bd 删除当前缓冲区
-- 3. <leader>bs 选择缓冲区
-- 4. <leader>bp 固定缓冲区
-- 5. group 功能，主要是根据 matcher 函数自动分组

return{
	{

		'akinsho/bufferline.nvim', 
		version = "*",  -- 最新版
		lazy = false,
		dependencies = {'nvim-tree/nvim-web-devicons'},

		-- require("bufferline").setup{},
		opts = {
			options = {
				mode = "buffers",

				always_show_bufferline = true, -- 总是显示 bufferline，即使只有一个 buffer

				buffer_close_icon = "⨉ ", -- 关闭 buffer 的图标，Nerd Font
				close_icon = "⨉ ", -- Tabline 右侧的关闭 buffer 图标
				show_buffer_close_icons = true, -- 是否显示每个 buffer 上的关闭图标
				show_close_icon = true, -- 是否显示 Tabline 右侧的关闭所有 buffer 图标

				close_command = "bdelete %d", -- 关闭buffer时可能有未保存的修改，这样不是强制关闭
				right_mouse_command = "bdelete %d",

				diagnostics = "nvim_lsp", -- 显示 LSP 诊断信息，可选 "nvim_lsp", "coc", "default"
				diagnostics_indicator = function(count, level)
					-- 自定义诊断图标和颜色
					local icon = level:match("error") and " " or " " -- 错误用实心圆，其他用空心圆
					return " " .. icon .. count
				end,

				enforce_regular_tabs = true, -- 强制使用常规标签页样式
				tab_size = 18,
				max_name_length = 25,

				indicator = {
					style = "underline", -- 下划线，可选 "underline", "none"
				},
				left_trunc_marker = "", -- 左侧截断标记，Nerd Font
				right_trunc_marker = "", -- 右侧截断标记，Nerd Font
				modified_icon = "●", -- 未保存文件的修改指示器图标，Nerd Font
				numbers = "none", -- buffer 编号显示，可选 "none", "ordinal", "buffer_id", "custom"
				-- 自定义诊断颜色 (取决于你的 colorscheme)
				-- diagnostics_indicator = function(count, level)
				--   if level:match("error") then
				--     return " " .. vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. count
				--   elseif level:match("warn") then
				--     return " " .. vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. count
				--   end
				--   return " " .. count
				-- end,
				show_tab_indicators = true, -- 是否显示 Tabline 上方的指示器
				sort_by = "insert_after_current", -- buffer 排序方式，把新缓冲区放在当前 buffer 后面
				offsets = {
					{
						filetype = "neo-tree", -- Neo-tree 的文件类型
						text = "File Explorer",
						text_align = "center",
						separator = true,
						padding = 1,
					},
				},
				hover = {
        		    enabled = true,
        		    delay = 100,
        		    reveal = {'close'}
        		},
				groups = {
					options = {
						toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
					},
					items = {
						{
							name = "Tests", -- Mandatory
							highlight = {underline = true, sp = "blue"}, -- Optional
							priority = 2, -- determines where it will appear relative to other groups (Optional)
							icon = " ", -- Optional
							matcher = function(buf) -- Mandatory
								local name = buf.name or ""
								return name:match("_test") or name:match("_spec")
							end,
						},
						{
							name = "Docs",
							highlight = {undercurl = true, sp = "green"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								local name = buf.name or ""
								return name:match('%.md$') or name:match('%.txt$')
							end,
						},
					},
				},
			},
			
		},

		keys = {
			{ "bh", "<cmd>BufferLineCycleNext<cr>", desc = "切换到下一个的缓冲区" },
			{ "bl", "<cmd>BufferLineCyclePrev<cr>", desc = "切换到上一个的缓冲区" },
			{ "<leader>bb", "<cmd>e #<cr>", desc = "和上一个编辑的缓冲区之间来回切换" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "关闭当前缓冲区" },
			{ "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "选择缓冲区" }, -- select
			{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "删除其他缓冲区" },
			{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "固定或取消固定" },
			{ "<leader>bn", "<cmd>BufferLineMoveNext<cr>", desc = "将窗口向右移动" },
			{ "<leader>bl", "<cmd>BufferLineMovePrev<cr>", desc = "将窗口向左移动" },
			{
				"<leader>bP",
				"<cmd>BufferLineGroupClose ungrouped<cr>",
				desc = "删除未分组的缓冲区",
			},
		},



	},
}
