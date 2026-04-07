# Neovim Config Audit Checklist

## 🔴 Critical Performance Issues

- [x] **Fix the save/format cascade** — Added timeout (750ms), per-buffer debounce (1s), and LSP capability check to `lsp-format-on-save-autocommand.lua`. Auto-save keybindings kept as-is. ⚠️ **Revisit:** formatting is still sync (blocks cursor/edits during the timeout window). Re-evaluate once other LSP noise fixes are in place.
- [x] **Disable or debounce `nvim-lightbulb`** — Restricted to `InsertLeave` event only (was firing on every cursor move). Removed unnecessary `FixCursorHold.nvim` dependency.
- [x] **Fix nvim-test rspec runner** — Added `args = { 'exec', 'rspec' }` to the runner setup so `bundle exec rspec` is invoked correctly.
- [x] **Wire up `on_attach` and `capabilities`** — Wired into mason-lspconfig handler. Removed custom LSP keybindings in favor of Neovim 0.12 built-in defaults (`grr`, `gra`, `grn`, `gd`, `K`, etc.). Fixed deprecated `vim.lsp.buf.formatting()` → `vim.lsp.buf.format()`.
- [x] **Update Neovim to 0.12.1** — Updated from 0.10.4. Built-in LSP keybindings now work reliably.
- [x] **Switch from Solargraph to ruby-lsp** — Replaced `solargraph` with `ruby_lsp` in mason-lspconfig. Shopify's ruby-lsp is significantly faster, uses less memory, and has better Rails support.
- [x] **Fix `<leader>t` keybinding conflict** — Won't fix. The `timeoutlen` delay on `t`-prefixed mappings is acceptable.
- [x] **Fix duplicate Treesitter config and remove `ensure_installed = "all"`** — Consolidated to single config in `treesitter.lua`. Replaced `"all"` with specific languages: ruby, typescript, tsx, javascript, html, css, scss, json, yaml, lua, bash, dockerfile, markdown, terraform, elixir, vim, embedded_template.

## 🟠 Significant Performance Concerns

- [x] **Add lazy-loading to command-only plugins** — Done as part of lazy.nvim migration. Plugins now lazy-load via `cmd`, `event`, `ft`, and `keys`.
- [ ] **Evaluate `codewindow.nvim` (minimap)** — Always active, watches every buffer change. Consider disabling or lazy-loading it behind a toggle command.
- [ ] **Evaluate `cinnamon.nvim` (smooth scrolling)** — Replaces native instant scrolling with animated frames. Can feel sluggish on large files. Consider removing or reducing animation length.
- [ ] **Evaluate `barbecue.nvim` (breadcrumbs)** — Queries LSP for document symbols on every cursor move. Archived — consider `dropbar.nvim` or built-in winbar in 0.11+.
- [x] **Reorder cmp sources** — Moved `nvim_lsp` and `copilot` above `spell` in completion sources.

## 🟡 Deprecated / Archived Plugins

- [x] **Replace `wbthomason/packer.nvim`** with `folke/lazy.nvim` — Full migration complete. All plugins now use lazy.nvim spec format with lazy-loading.
- [x] **Remove `jose-elias-alvarez/null-ls.nvim`** — Dropped during lazy.nvim migration (was never configured, pure dead weight).
- [x] **Remove `p00f/nvim-ts-rainbow`** — Dropped during lazy.nvim migration (archived, breaks with modern treesitter).
- [x] **Remove `antoinemadec/FixCursorHold.nvim`** — Dropped during lazy.nvim migration (unnecessary since Neovim 0.8).
- [x] **Remove `nvim-tree` `tag = 'nightly'`** — Removed during lazy.nvim migration.
- [ ] **Update `rest-nvim/rest.nvim`** — Disabled during migration (`enabled = false`). Old API is gone from main branch; needs migration to the rewrite.
- [ ] **Replace `barbecue.nvim`** — Archived Jan 2025. Use `dropbar.nvim` or built-in winbar in 0.11+.
- [ ] **Evaluate `ray-x/lsp_signature.nvim`** — 0.12 has built-in signature help triggering, may no longer be needed.
- [ ] **Evaluate `gelguy/wilder.nvim`** — Stale (mostly VimScript, no recent activity). Watch for breakage.
- [ ] **Evaluate `sudormrfbin/cheatsheet.nvim`** — Stale, depends on archived `popup.nvim`.

## 🟡 Dead Code / Unused Config

- [x] **Remove `lsp-format.nvim`** — Dropped during lazy.nvim migration (was never wired up).
- [x] **Remove `null-ls.nvim`** — Dropped during lazy.nvim migration.
- [x] **Fix undefined globals in `editor-settings.lua`** — Replaced `LightGrey`, `White`, `Black` with actual color values.
- [x] **Remove redundant `lualine.setup()` call** — Fixed during lazy.nvim migration. Lualine config now only calls `evil_line_lua_line_config`.
- [x] **Delete `auto-packer-compile.lua`** — Packer-only file, removed.
- [x] **Delete `lsp-configs.lua`** — Content merged into lazy.nvim plugin specs.

## 🟡 Bugs / Typos

- [x] **Fix terminal escape mapping typo** — Fixed `<C--\\><C-n>` → `<C-\\><C-n>` in `keybindings.lua`.
- [x] **Fix `<C-k>` conflict** — Resolved: custom LSP keybindings removed in favor of Neovim 0.12 defaults. `<C-k>` is now solely cinnamon scroll. Signature help is `<C-s>` (insert mode) via built-in defaults.
- [x] **Fix deprecated APIs in `evil_line_lua_line_config.lua`** — Updated `nvim_buf_get_option` → `vim.bo[0].filetype` and `get_active_clients` → `vim.lsp.get_clients()`.

## 🟢 Enhancements / New Features

- [ ] **Add `rainbow-delimiters.nvim`** — Replace archived `nvim-ts-rainbow` with `HiPhish/rainbow-delimiters.nvim` for rainbow brackets.
- [ ] **Add `indent-blankline.nvim` with rainbow indents** — Wire up with `rainbow-delimiters.nvim` for rainbow indent guides.

---

## Old TODO — Plugins to Explore

- [ ] JSON Explorer — https://github.com/gennaro-tedesco/nvim-jqx
- [ ] Translation interface — https://github.com/potamides/pantran.nvim
- [ ] Highlight function arguments — https://github.com/m-demare/hlargs.nvim
- [ ] Navigate via Tree-sitter nodes using Telescope — https://github.com/desdic/agrolens.nvim
- [ ] Visual vim registry management — https://github.com/gennaro-tedesco/nvim-peekup / https://github.com/tenxsoydev/karen-yank.nvim
- [ ] Explore using NuShell as shell