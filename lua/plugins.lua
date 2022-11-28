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
  -- packer manages packer
  use 'wbthomason/packer.nvim'

  ------------------------ common
  -- lsp config for language server support
  use 'neovim/nvim-lspconfig'

  -- cmp framework for auto-completion support
  use 'hrsh7th/nvim-cmp'

  -- install different completion sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- snippet engine for snippet support
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'

  -- bracket auto-pairing
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }

  -- Git commands
  use 'tpope/vim-fugitive'

  -- General commenting plugin
  use 'gennaro-tedesco/nvim-commaround'

  ------------------------ UI
  -- lsp config for language server support
  -- dev icons for nvim
  use {
    'nvim-tree/nvim-web-devicons',
    config = function() require('nvim-web-devicons').setup( { color_icons = true; }) end
  }

  -- nvim tree for file tree
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    config = function() require('nvim-tree').setup() end
  }

  -- use treesitter for highlighting, this could cause problems as it is in progress
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }

  -- use instead of git gutter, this is not tested so I may revert to git gutters
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  -- [<leader>?] add cheatsheet
  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }

  -- use JABS for buffer switching
  use {
    'matbme/JABS.nvim',
    requires = {'nvim-tree/nvim-web-devicons'}
  }

  -- adds vscode style lightbulb for code actions
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function() require('nvim-lightbulb').setup({ autocmd = { enabled = true }}) end,
  }

  -- adds icons to codeactions
  use 'onsails/lspkind.nvim'

  -- add function signatures to popup on hover
  use {
    'ray-x/lsp_signature.nvim',
    config = function() require('lsp_signature').setup({}) end
  }

  -- wildmenu additions
  use {
    'gelguy/wilder.nvim',
    config = function()
      require('wilder').setup({ modes = {':', '/', '?'} })
    end
  }

  -- lua lightline replacement, might want to go back to lightline if I don't like this
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup();
      require('evil_line_lua_line_config');
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
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function() require('telescope').load_extension('fzf'); end
  }

  -- telescope sorter, native C impl of fzf
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- nvim rest client
  use {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = true,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = true,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = true,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to nil if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  }

  -- deletes all trailing whitespace on save
  use {
    'mcauley-penney/tidy.nvim',
    config = function()
      require('tidy').setup()
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  -- Must be after all plugin declarations
  if packer_bootstrap then
    require('packer').sync()
  end
end)
