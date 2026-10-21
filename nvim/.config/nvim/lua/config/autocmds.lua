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
local undo_path = vim.fn.stdpath("state") .. "/undo"  -- 放到仓库外，避免 undo 文件落在 dotfiles 里
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

-- 2. 输入法自动切换（中文 → 离开插入模式切英文，进入插入模式恢复）
-----------------------------------------------------------
-- 依赖 ~/.local/bin/im（见 dotfiles/im）。切英文必须尽可能快，
-- 否则 esc 之后紧接着按的 h/l 会被中文输入法截走。
local ime_group = augroup("ImeSwitch", { clear = true })
local EN_IME = "com.apple.keylayout.US"
vim.g.last_insert_ime = EN_IME

-- 异步执行，不阻塞编辑器主线程
local function im_async(...)
  if vim.fn.executable("im") == 1 then
    vim.fn.jobstart({ "im", ... }, { detach = true, stdout_buffered = false })
    return true
  end
  return false
end

autocmd("InsertLeave", {
  group = ime_group,
  pattern = "*",
  callback = function()
    -- 一次调用即可：拿完整 id 后本地判断是否为英文键盘布局
    local current = vim.fn.system({ "im", "get" }):gsub("%s+", "")
    if current == "" or current == EN_IME then
      return
    end
    -- 非英文则记住它，回到插入模式时恢复
    vim.g.last_insert_ime = current
    im_async("en")
  end,
})

autocmd("InsertEnter", {
  group = ime_group,
  pattern = "*",
  callback = function()
    if vim.g.last_insert_ime ~= EN_IME then
      im_async(vim.g.last_insert_ime)
    end
  end,
})
