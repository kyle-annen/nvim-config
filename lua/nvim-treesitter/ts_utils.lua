-- Shim for nvim-treesitter.ts_utils removed in new nvim-treesitter rewrite.
local M = {}

function M.get_node_at_cursor(winid)
  local win = (winid and winid ~= 0) and winid or 0
  local cursor = vim.api.nvim_win_get_cursor(win)
  return vim.treesitter.get_node({ pos = { cursor[1] - 1, cursor[2] } })
end

return M
