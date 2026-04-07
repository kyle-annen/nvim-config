-- Format on save with timeout, debounce, and capability checking
--
-- Keeps the "save always formats" behavior but fixes performance:
--   1. timeout_ms prevents slow LSPs (e.g. Solargraph) from freezing Neovim
--   2. debounce skips redundant formats during rapid saves (jk, dd, x sequences)
--   3. capability check skips formatting entirely when no LSP formatter is attached

local vim = vim

local TIMEOUT_MS = 750
local DEBOUNCE_MS = 1000

-- track last format time per buffer to debounce independently
local last_format = {}

-- clean up tracking when buffers are deleted
vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("LspFormatOnSaveCleanup", { clear = true }),
  callback = function(args)
    last_format[args.buf] = nil
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
  callback = function(args)
    local bufnr = args.buf

    -- debounce: skip if we formatted this buffer recently
    local now = vim.uv.now()
    if last_format[bufnr] and (now - last_format[bufnr]) < DEBOUNCE_MS then
      return
    end

    -- only format if an attached LSP actually supports formatting
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local has_formatter = false
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/formatting") then
        has_formatter = true
        break
      end
    end

    if not has_formatter then
      return
    end

    vim.lsp.buf.format({
      async = false,
      timeout_ms = TIMEOUT_MS,
      bufnr = bufnr,
    })

    last_format[bufnr] = vim.uv.now()
  end,
})
