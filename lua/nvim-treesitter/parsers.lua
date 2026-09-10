-- Shim for nvim-treesitter.parsers removed in new nvim-treesitter rewrite.
local M = {}

function M.ft_to_lang(filetype)
  return vim.treesitter.language.get_lang(filetype) or filetype
end

function M.get_parser(bufnr, lang)
  return vim.treesitter.get_parser(bufnr, lang)
end

-- Empty list — callers fall back to vim.bo.filetype when lang not found
M.list = {}

return M
