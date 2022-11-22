-- function to boot strap packer on a new machine
-- TODO: This should be extracted to another lua file
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

  ------------------------ common
  -- TODO: investigate nvim-lsp
  -- https://neovim.io/doc/user/lsp.html
  --
  -- nvim-lspconfig together with nvim-lspinstall and lspsaga.nvim use the new,
  -- built-in LSP in Neovim and provide some useful functions. Together they
  -- allow me to easily install and use language servers (e.g. to display
  -- function documentation or jump to a definition). Together with nvim-compe
  -- (autocompletion) I use them to replace Ale and coc.vim,

  -- packer manages packer
  use 'wbthomason/packer.nvim'

  -- bracket auto-pairing
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end } 

  -- Git commands
  use 'tpope/vim-fugitive'

  -- dev icons for nvim
  use { 'nvim-tree/nvim-web-devicons', config = function() require('nvim-web-devicons').setup( { color_icons = true; }) end }

  -- nvim tree for file tree
  use { 'nvim-tree/nvim-tree.lua', tag = 'nightly', config = function() require('nvim-tree').setup() end }

  -- use treesitter for highlighting, this could cause problems as it is in progress
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  } 

  -- use instead of git gutter, this is not tested so I may revert to git gutters
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end } 

  -- lua lightline replacement, might want to go back to lightline if I don't like this
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup();
      -- require('evil_line_lua_line_config');
    end
  } 

  ------------------------ searching
  -- TODO: investigate different plugins for telescope: 
  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions#different-plugins-with-telescope-integration
  -- TODO: add optional telescope deps to linux packages
  -- sudo apt-get install ripgrep
  -- sudo apt-get install fd-find
  use 'nvim-lua/plenary.nvim'

  -- use telescope for fuzzy finding
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', config = function() require('telescope').load_extension('fzf'); end }   

  -- telescope sorter, native C impl of fzf 
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } 

  -- Automatically set up configuration after cloning packer.nvim
  -- Must be after all plugin declarations
  if packer_bootstrap then
    require('packer').sync()
  end
end)
