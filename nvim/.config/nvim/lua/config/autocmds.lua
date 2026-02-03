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
vim.g.last_insert_ime = EN_IME
autocmd("InsertLeave", {
  group = macism_group,
  pattern = "*",
  callback = function()
    if vim.fn.executable("macism") == 1 then
      local current_ime = vim.fn.system("macism"):gsub("%s+", "")
      if current_ime ~= "" and current_ime ~= EN_IME then
        vim.g.last_insert_ime = current_ime
        vim.fn.jobstart({"macism", EN_IME}, { detach = true })
      else
        vim.g.last_insert_ime = EN_IME
      end
    end
  end,
})
autocmd("InsertEnter", {
  group = macism_group,
  pattern = "*",
  callback = function()
    if vim.fn.executable("macism") == 1 then
      if vim.g.last_insert_ime ~= EN_IME then
        vim.fn.jobstart({"macism", vim.g.last_insert_ime}, { detach = true })
      end
    end
  end,
})
