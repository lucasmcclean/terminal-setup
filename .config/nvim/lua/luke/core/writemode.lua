local writing_mode_enabled = false
local og_scrolloff = vim.o.scrolloff
local og_columns = vim.o.columns

local scroll_margin = 7

_G.toggle_write_mode = function()
  if writing_mode_enabled then
    vim.o.textwidth = 80
    vim.o.wrapmargin = 2
    vim.o.wrap = false
    vim.o.linebreak = false
    vim.o.columns = og_columns
    vim.o.scrolloff = og_scrolloff
    vim.api.nvim_del_keymap('n', 'j')
    vim.api.nvim_del_keymap('n', 'k')
    vim.cmd [[autocmd! CursorMoved * lua _G.visual_scrolloff()]]
    writing_mode_enabled = false
    print '~ Writing mode disabled ~'
  else
    vim.o.textwidth = 0
    vim.o.wrapmargin = 0
    vim.o.wrap = true
    vim.o.linebreak = true
    vim.o.scrolloff = 0
    vim.o.columns = 90
    vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
    vim.cmd [[autocmd CursorMoved * lua _G.visual_scrolloff()]]
    writing_mode_enabled = true
    print '- Writing mode enabled -'
  end
end

vim.api.nvim_set_keymap('n', '<leader>w', ':lua toggle_write_mode()<CR>', { noremap = true, silent = true })

_G.visual_scrolloff = function()
  local cursor_row = vim.fn.winline()
  local window_height = vim.api.nvim_win_get_height(0)
  local topline = vim.fn.line 'w0'

  if cursor_row < scroll_margin then
    vim.fn.winrestview { topline = topline - 1 }
  elseif cursor_row > window_height - scroll_margin then
    vim.fn.winrestview { topline = topline + 1 }
  end
end
