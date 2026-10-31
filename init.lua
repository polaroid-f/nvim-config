
-- 禁用 perl
vim.g.loaded_perl_provider = 0
-- 禁用 ruby
vim.g.loaded_ruby_provider = 0

-- 加载 lazy.nvim
require("config.basic")
require("config.autocmd")
require("config.lazy")
require("config.keymap")

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

























