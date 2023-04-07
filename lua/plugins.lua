local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
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
  -- lsp-config for language server support
  -- mason for LSP downloading
  -- mason-lspconfig to link the other two
  use {
    'williamboman/mason.nvim',
    requires = {
      { 'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- order dependent loading
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'bashls',
          'cssls',
          'dockerls',
          'eslint',
          'elixirls',
          'tsserver',
          'jsonnet_ls',
          'marksman',
          'terraformls'
       },
        automatic_installation = true
      }
    end
  }

  -- use nvim-dap for language agnostic debugging (via LSP)
  -- https://github.com/mfussenegger/nvim-dap#usage
  use 'mfussenegger/nvim-dap'

  -- prevent nested nvim
  use "samjwill/nvim-unception"

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

  -- [<leader>i] nvim-toggler to toggle word cardnality
  use {
    'nguyenvukhang/nvim-toggler',
    config = function()
      require('nvim-toggler').setup()
    end
  }

  ------------------------ UI
  -- lsp config for language server support
  -- dev icons for nvim
  use {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ color_icons = true, })
    end
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

  -- use nvim-scrollbar to add a scroll bar
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  }

  -- use codewindow to get vscode like preview
  use {
    'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end
  }

  -- use nvim-ts-rainbow for rainbow brackets
  use { 'p00f/nvim-ts-rainbow' }

  -- use nvim-ts-autotag for bracket and html tag completion
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }


  -- [<leader>?] add cheatsheet
  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' }
    }
  }


  -- [<leader>b] use JABS for buffer switching
  use {
    'matbme/JABS.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- add biscuits, ghost snippet text to show opposite bracket
  use {
    'code-biscuits/nvim-biscuits',
    config = function()
      require('nvim-biscuits').setup({
        default_config = {
          max_length = 12,
          min_distance = 5,
          prefix_string = ' 📎 '
        }
      })
    end
  }

  -- show a vscode like lightbulb next to code actions
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    end,
  }

  -- use nvim-notify for notifications
  use { 'rcarriga/nvim-notify' }

  -- adds icons to codeactions
  use 'onsails/lspkind.nvim'

  -- add function signatures to popup on hover
  use {
    'ray-x/lsp_signature.nvim',
    config = function() require('lsp_signature').setup({}) end
  }

  -- smooth scrolling
  use {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup()
    end
  }

  -- [<leader>t] toggleterm for terminal
  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require('toggleterm').setup()
    end
  }

  -- wildmenu (bottom menu) additions
  -- this could use further tweaking
  use {
    'gelguy/wilder.nvim',
    config = function()
      require('wilder').setup({ modes = { ':', '/', '?' } })
    end
  }

  -- lua lightline replacement, might want to go back to lightline if I don't like this
  -- this could use further tweaking
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup();
      require('evil_line_lua_line_config');
    end
  }

  ------------------------ searching
  -- dependency for most things, provides better lua abstractions
  use 'nvim-lua/plenary.nvim'

  -- use telescope for fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
      require('telescope').load_extension('fzf');
    end
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
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
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
