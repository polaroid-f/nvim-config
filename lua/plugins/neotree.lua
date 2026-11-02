-- 快捷键
-- 1. enter 打开文件，或展开收起文件夹，打开的文件是以buffer形式打开，需要 :ls :bnext :bprevious 等命令切换
--	  enter 保留光标在 neotree 中，o 光标在新打开的文件中
-- 2. backspace 将文件树根目录切换到上一级
-- 3. C 收起光标所在的文件夹节点
-- 4. a 创建新文件
-- 5. A 创建新文件夹
-- 6. d 删除文件或文件夹
-- 7. r 重命名
-- 8. R 刷新文件树
-- 9. q 关闭文件树
-- 10. ？ 显示快捷键帮助
-- 11. <> 用于切换不同数据源的视图
   -- tree 有三种默认的数据源：filesystem，buffers（已经打开的buffer列表），gitstatus（git 修改，新增，删除的状态）通过三种数据源可以快速筛选
   -- 12 s 可以在新的窗口打开文件，而不是覆盖当前文件，垂直打开，S 是水平打开
   -- 13 t 新的tab中打开
   -- 14 . 设该文件夹为 根目录
   -- 15 b 修改当前文件文件名，但只修改名不改类型，r 是全部修改
   -- 16 一系列 oc od ot og(git status) om(modify) os(size) 等 都是 order by 
   -- 17. P 预览文件内容


return {
	{
		"nvim-neo-tree/neo-tree.nvim",
    	branch = "v3.x",
    	dependencies = {
    	  "nvim-lua/plenary.nvim",
    	  "MunifTanjim/nui.nvim",
    	  "nvim-tree/nvim-web-devicons", -- optional, but recommended
    	},
    	lazy = false, -- neo-tree will lazily load itself

		-- 打开文件树的快捷键
		keys = {
			{ "<leader>t", "<cmd>Neotree toggle filesystem left<CR>", desc = "open tree"},
		},

		opts = {
			-- 设置文件树的位置和宽度
			window = {
				position = "left",
				width = 25,
			},

			-- 设置文件显示
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- 是否隐藏 . 开头的文件
					hide_hidden = false, -- 是否隐藏 neotree 认为的隐藏文件
					hide_gitignored = false, -- 是否隐藏 .gitignore 等文件中排除的文件
					hide_ignored = false, -- 是否隐藏 .gitignore 等文件中排除的文件
					
				},
				group_empty_dirs = true, -- 将空目录合并显示

				follow_current_file = {
					enabled = true, -- 自动展开并选中当前文件
				},

				-- 自定义文件打开
				commands = {
				        open_keepfocus = function(state)
				            -- 记录当前 Neo-tree 窗口
				            local tree_win = vim.api.nvim_get_current_win()
				
				            -- 执行默认打开操作
				            state.commands.open(state)
				
				            -- 将焦点重新切换回 Neo-tree
				            if vim.api.nvim_win_is_valid(tree_win) then
				                vim.api.nvim_set_current_win(tree_win)
				            end
				        end,
				},

				window = {
    			    mappings = {
    			        ["<CR>"] = "open_keepfocus",
    			        ["o"] = "open",
    			    },
    			},
			},

			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						added = " ", -- 新增
						modified = "  ", -- 修改
						deleted = "󱂥 ", -- 删除
						renamed = "󰑕 ", -- 重命名
						untracked = " ", -- 未跟踪
						unstaged = " ", -- 未暂存
						staged = "󰩍 ", -- 已暂存
						ignored = "  ", -- 忽略
						conflict = " ", -- 冲突（更醒目）
					},
				},
			},
			close_if_last_window = false, -- 如果是最后一个窗口则自动关闭，可能该功能反而更有用，先设为 false，如果以后没用再设为 true
		},
	},
}
