vim.opt.clipboard = 'unnamedplus' -- 剪贴板设置：使用系统剪贴板 (需要环境支持如 xclip/pbcopy)
vim.g.mapleader = ' '          -- 将主引导键 (Leader key) 设置为空格键
vim.g.VM_show_warnings = 0     -- 禁用 Visual Multi (多光标插件) 的警告信息
vim.opt.laststatus = 0         -- 状态栏设置：0 为不显示状态栏
vim.opt.backspace = '2'        -- 退格键行为：'2' 允许在插入模式下退格删除缩进、断行和光标前字符
-- vim.opt.virtualedit ='block'-- (注释状态) 允许光标在可视块模式下移动到没有字符的地方
-- vim.opt.scrolloff = 4       -- (注释状态) 垂直滚动时光标距离顶部/底部的最小行数
vim.opt.textwidth = 0          -- 文本折行宽度：0 表示不自动折行
vim.opt.ttimeoutlen = 0        -- 超时等待时间：设置为 0 表示立即响应键位组合 (常用于消除 Esc 键延迟)

-- 自动保存/读取
vim.opt.autowrite = true       -- 切换文件或退出时自动保存
vim.opt.autoread = true        -- 当文件在外部被修改时自动读取

-- 界面反馈
vim.opt.showcmd = true         -- 在状态栏显示正在输入的命令
vim.opt.wildmenu = true        -- 命令行补全时显示增强版菜单
vim.opt.autochdir = true       -- 自动将工作目录切换为当前编辑文件所在的目录
vim.opt.hlsearch = true        -- 高亮显示搜索结果
vim.opt.showmode = true        -- 显示当前所处的模式 (如 -- INSERT --)
vim.opt.ttyfast = true         -- 指示终端连接较快，优化平滑绘制
-- vim.opt.lazyredraw = true   -- (注释状态) 运行宏时延迟重绘以提升性能
vim.opt.visualbell = true      -- 使用可视响铃 (闪烁) 代替声音报警
vim.opt.cursorline = false     -- 不高亮显示当前行
vim.opt.autoindent = false     -- 禁用自动缩进 (通常由插件或 filetype 更精细控制)

-- 窗口分割方向
vim.opt.splitright = true      -- 新水平分割窗口在右侧出现
vim.opt.splitbelow = true      -- 新垂直分割窗口在下方出现

-- 缩进与空格设置
vim.opt.tabstop = 2            -- 1 个 Tab 等于 2 个空格
vim.opt.shiftwidth = 2         -- 每一级自动缩进的空格数
vim.opt.shiftround = true      -- 缩进时取 shiftwidth 的整数倍
vim.opt.expandtab = true       -- 将输入的 Tab 转换为空格

-- 行号设置
vim.wo.number = true           -- 显示绝对行号
vim.wo.relativenumber = true   -- 显示相对行号 (便于配合数字进行跨行跳转)

-- 特殊字符显示 (空格/Tab 可视化)
vim.opt.list = true            -- 显示不可见字符
vim.opt.listchars = 'trail:▫,tab:| ' -- 行尾空格显示为 ▫，Tab 显示为 | 加上空格

-- 搜索大小写敏感性
vim.opt.ignorecase = true      -- 搜索时忽略大小写
vim.opt.smartcase = true       -- 如果搜索词包含大写字母，则开启大小写敏感
