-----------------------------------------------------------
-- Neovim 自动命令配置文件 (MacOS 原生终端极致防闪烁版)
-----------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 1. 基础体验优化
-----------------------------------------------------------
local general_group = augroup('GeneralSettings', { clear = true })

-- 复制高亮
autocmd('TextYankPost', {
  group = general_group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
  end
})

-- 跳转上次编辑位置
autocmd('BufReadPost', {
  group = general_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end
})

-- 持久撤销 (使用 Lua 原生路径处理)
local undo_path = vim.fn.expand("$HOME/.config/nvim/undo")
if vim.fn.isdirectory(undo_path) == 0 then vim.fn.mkdir(undo_path, "p") end
vim.opt.undofile = true
vim.opt.undodir = undo_path

-- 禁用自动延续注释 (在进入缓冲区时强制重置)
autocmd('BufEnter', {
  group = general_group,
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end
})

-- 2. 输入法自动切换 (极致压制原生终端重绘闪烁)
-----------------------------------------------------------
local macism_group = augroup("MacismSwitch", { clear = true })
local EN_IME = "com.apple.keylayout.US"
vim.g.last_insert_ime = EN_IME  -- 初始状态设为英文

-- 退出插入模式：记录状态并切回英文
autocmd("InsertLeave", {
  group = macism_group,
  pattern = "*",
  callback = function()
    if vim.fn.executable("macism") == 1 then
      -- 1. 快速获取当前 ID (同步执行以保证记录准确)
      local current_ime = vim.fn.system("macism"):gsub("%s+", "")
      
      -- 2. 如果当前是中文，则记录 ID 并切换到英文
      if current_ime ~= "" and current_ime ~= EN_IME then
        vim.g.last_insert_ime = current_ime
        -- 仅在此处切换到英文，如果已经是英文则不操作
        vim.fn.jobstart({"macism", EN_IME}, { detach = true })
      else
        -- 如果当前已经是英文，保持记录为英文
        vim.g.last_insert_ime = EN_IME
      end
    end
  end,
})

-- 进入插入模式：只有当上次记录是中文时才执行切换
autocmd("InsertEnter", {
  group = macism_group,
  pattern = "*",
  callback = function()
    -- 核心优化：如果上次记录的就是英文，则完全不执行 macism 命令
    -- 这样在英文模式下按 o 就不会有任何进程启动，彻底消除闪烁
    if vim.fn.executable("macism") == 1 then
      if vim.g.last_insert_ime ~= EN_IME then
        vim.fn.jobstart({"macism", vim.g.last_insert_ime}, { detach = true })
      end
    end
  end,
})

-- 3. 终端 (Terminal) 配置
-----------------------------------------------------------
local term_group = augroup('TerminalSettings', { clear = true })

-- 定义 :Term 用户命令
vim.api.nvim_create_user_command('Term', 'botright vsplit term://$SHELL', {})

-- 终端打开时的界面美化
autocmd('TermOpen', {
  group = term_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end
})

-- 切换回终端缓冲区时自动进入插入模式
autocmd('BufEnter', {
  group = term_group,
  pattern = 'term://*',
  callback = function()
    vim.cmd("startinsert")
  end
})

-- 离开终端时停止插入模式
autocmd('BufLeave', {
  group = term_group,
  pattern = 'term://*',
  callback = function()
    vim.cmd("stopinsert")
  end
})
