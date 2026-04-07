# Neovim Config Audit Checklist

## 🔴 Critical Performance Issues

- [x] **Fix the save/format cascade** — Added timeout (750ms), per-buffer debounce (1s), and LSP capability check to `lsp-format-on-save-autocommand.lua`. Auto-save keybindings kept as-is. ⚠️ **Revisit:** formatting is still sync (blocks cursor/edits during the timeout window). Re-evaluate once other LSP noise fixes are in place.
- [x] **Disable or debounce `nvim-lightbulb`** — Restricted to `InsertLeave` event only (was firing on every cursor move). Removed unnecessary `FixCursorHold.nvim` dependency.
- [x] **Fix nvim-test rspec runner** — Added `args = { 'exec', 'rspec' }` to the runner setup in `plugins.lua` so `bundle exec rspec` is invoked correctly.
- [x] **Wire up `on_attach` and `capabilities`** — Exported from `lsp-configs.lua` as a module return table and wired into the mason-lspconfig handler in `plugins.lua`. Removed custom LSP keybindings in favor of Neovim 0.10 built-in defaults (`grr`, `gra`, `grn`, `gd`, `K`, etc.). Also fixed deprecated `vim.lsp.buf.formatting()` → `vim.lsp.buf.format()`.
- [ ] **Fix `<leader>t` keybinding conflict** — `<leader>t` (ToggleTerm) causes a `timeoutlen` delay on all `t`-prefixed mappings (`<leader>ts`, `<leader>tf`, `<leader>tt`, etc.). Move ToggleTerm to a non-conflicting binding like `<leader>T` or `<C-\>`.
- [ ] **Fix duplicate Treesitter config and remove `ensure_installed = "all"`** — Treesitter is configured in both `plugins.lua` and `lsp-configs.lua` (second overwrites first). Consolidate to one location and specify only needed languages (ruby, lua, javascript, html, css, yaml, json, etc.).

## 🟠 Significant Performance Concerns

- [ ] **Add lazy-loading to command-only plugins** — Use Packer's `cmd`, `ft`, `keys`, `event` options for: `nvim-test`, `rest-nvim`, `diffview.nvim`, `vim-fugitive`, `icon-picker.nvim`, `JABS.nvim`, `cheatsheet.nvim`, `toggleterm.nvim`, `nvim-dap`.
- [ ] **Evaluate `codewindow.nvim` (minimap)** — Always active, watches every buffer change. Consider disabling or lazy-loading it behind a toggle command.
- [ ] **Evaluate `cinnamon.nvim` (smooth scrolling)** — Replaces native instant scrolling with animated frames. Can feel sluggish on large files. Consider removing or reducing animation length.
- [ ] **Evaluate `barbecue.nvim` (breadcrumbs)** — Queries LSP for document symbols on every cursor move. With Solargraph this is another stream of constant LSP requests.
- [ ] **Reorder cmp sources** — `spell` is currently highest priority and runs in all contexts. Move `nvim_lsp` and `copilot` above `spell`, and restrict spell to prose filetypes via `enable_in_context`.

## 🟡 Deprecated / Archived Plugins

- [ ] **Replace `wbthomason/packer.nvim`** with `folke/lazy.nvim` (Packer is archived).
- [ ] **Replace `jose-elias-alvarez/null-ls.nvim`** with `nvimtools/none-ls.nvim` or `conform.nvim` + `nvim-lint` (null-ls is archived). Currently loaded but never configured — dead weight.
- [ ] **Replace `p00f/nvim-ts-rainbow`** with `HiPhish/rainbow-delimiters.nvim` (nvim-ts-rainbow is archived).
- [ ] **Remove `antoinemadec/FixCursorHold.nvim`** — Unnecessary in Neovim >= 0.8.
- [ ] **Remove `nvim-tree` `tag = 'nightly'`** — This tag may no longer exist.
- [ ] **Update `rest-nvim/rest.nvim`** — Old API has breaking changes, needs migration.

## 🟡 Dead Code / Unused Config

- [ ] **Remove `lsp-format.nvim`** — Loaded but never wired up to any LSP `on_attach`. Format-on-save is handled separately by the raw autocmd.
- [ ] **Remove or configure `null-ls.nvim`** — `use 'jose-elias-alvarez/null-ls.nvim'` with no setup. Pure dead weight.
- [ ] **Fix undefined globals in `editor-settings.lua`** — `LightGrey`, `White`, `Black` are undefined Lua variables (evaluate to `nil`), making the highlight calls no-ops.
- [ ] **Remove redundant `lualine.setup()` call** — `plugins.lua` calls `lualine.setup()` with defaults, then immediately overwrites it via `evil_line_lua_line_config`. Remove the first call.
- [ ] **Remove unused `on_attach` / `capabilities` definitions if not wiring them up** — Currently defined in `lsp-configs.lua` but never passed to any server.

## 🟡 Bugs / Typos

- [ ] **Fix terminal escape mapping typo** — `tmap('jk', "<C--\\><C-n>")` should be `<C-\\><C-n>` (one hyphen, not two).
- [ ] **Fix `<C-k>` conflict** — Mapped to both cinnamon scroll (keybindings.lua) and LSP signature help (lsp-configs.lua). Decide which one wins.

## 🟢 Enhancements / New Features

- [ ] **Add `rainbow-delimiters.nvim`** — Replace archived `nvim-ts-rainbow` with `HiPhish/rainbow-delimiters.nvim` for rainbow brackets.
- [ ] **Add `indent-blankline.nvim` with rainbow indents** — Uncomment and fix the commented-out `indent-blankline` config in `plugins.lua`, wiring it up with `rainbow-delimiters.nvim` for rainbow indent guides.
- [ ] **Consider `folke/lazy.nvim` migration** — Better lazy-loading, lockfile support, UI, and active maintenance vs archived Packer.

---

## Old TODO — Plugins to Explore

- [ ] JSON Explorer — https://github.com/gennaro-tedesco/nvim-jqx
- [ ] Translation interface — https://github.com/potamides/pantran.nvim
- [ ] Highlight function arguments — https://github.com/m-demare/hlargs.nvim
- [ ] Navigate via Tree-sitter nodes using Telescope — https://github.com/desdic/agrolens.nvim
- [ ] Visual vim registry management — https://github.com/gennaro-tedesco/nvim-peekup / https://github.com/tenxsoydev/karen-yank.nvim
- [ ] Explore using NuShell as shell
