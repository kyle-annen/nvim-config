-- TODO(Kyle): find a better way to do this
-- prevent lua from yellling about vim not being defined
local vim = vim

-- disable netrw as directed by nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ensure packer
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
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
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
          'solargraph',
          'marksman',
          'terraformls',
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {}
          end
        }
      }
    end
  }

  -- use lsp-format to auto format code
  use {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require('lsp-format')
    end
  }

  -- null-ls for for matters and liter
  use 'jose-elias-alvarez/null-ls.nvim'

  -- copilot.lua for copilot
  use {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  }

  -- cmp framework for auto-completion support
  use 'hrsh7th/nvim-cmp'

  -- snippet engine for snippet support
  use 'hrsh7th/vim-vsnip'

  -- install different completion sources
  use 'f3fora/cmp-spell'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'

  -- use copilot-cmp for copilot completion
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }

  -- use nvim-test as a test runner
  use {
    'klen/nvim-test',
    config = function()
      require('nvim-test').setup()
      require('nvim-test.runners.rspec'):setup {
        command = 'bundle'
      }
    end
  }

  -- use nvim-testnav for test navigation
  use { 'davebrace/vim-testnav' }

  -- use nvim-dap for language agnostic debugging (via LSP)
  -- https://github.com/mfussenegger/nvim-dap#usage
  use 'mfussenegger/nvim-dap'

  -- prevent nested nvim
  use "samjwill/nvim-unception"


  -- bracket auto-pairing
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }

  -- Git commands
  use 'tpope/vim-fugitive'

  -- Git diff viewer
  -- Packer
  use "sindrets/diffview.nvim"

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

  -- use Gruvbox Theme
  use { "ellisonleao/gruvbox.nvim" }

  -- colorize hex color codes
  use {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
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
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true }
      }
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
  use { 'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }

  --  -- use indent-blankline to highlight indentations
  --  use {
  --    'lukas-reineke/indent-blankline.nvim',
  --    config = function()
  --      local highlight = {
  --        "RainbowRed",
  --        "RainbowYellow",
  --        "RainbowBlue",
  --        "RainbowOrange",
  --        "RainbowGreen",
  --        "RainbowViolet",
  --        "RainbowCyan",
  --      }
  --
  --      local hooks = require "ibl.hooks"
  --      -- create the highlight groups in the highlight setup hook, so they are reset
  --      -- every time the colorscheme changes
  --      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --      end)
  --
  --      require("ibl").setup { indent = { highlight = highlight } }
  --    end
  --  }

  -- use min.align to align text
  use { 'echasnovski/mini.align', branch = 'stable' }

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

  -- show a vscode like lightbulb next to code actions
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    end,
  }

  -- use nvim-notify for notifications
  use({
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        background_colour = "#000000"
      })
    end
  })

  -- adds icons to codeactions
  use 'onsails/lspkind.nvim'

  -- improves general neovim ui
  use { 'stevearc/dressing.nvim' }

  -- adds LSP breadcrumbs
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",     -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })

  -- adds an emoji picker
  use {
    'ziontee113/icon-picker.nvim',
    requires = { 'stevearc/dressing.nvim' },
    config = function()
      require('icon-picker').setup({ disable_legacy_commands = true })
    end
  }

  -- timeout LSPs not in use
  --  use {
  --    "hinell/lsp-timeout.nvim",
  --    requires = { "neovim/nvim-lspconfig" }
  --  }

  -- add function signatures to popup on hover
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        fix_pos = true,
        hint_prefix = ""
      })
    end
  }

  -- smooth scrolling
  use {
    'declancm/cinnamon.nvim',
    config = function()
      require('cinnamon').setup {
        keymaps = {
          basic = true,
          extra = true,
        },
      }
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

  --  use {
  --    "kndndrj/nvim-dbee",
  --    requires = {
  --      "MunifTanjim/nui.nvim",
  --    },
  --    run = function()
  --      -- Install tries to automatically detect the install method.
  --      -- if it fails, try calling it with one of these parameters:
  --      --    "curl", "wget", "bitsadmin", "go"
  --      require("dbee").install()
  --    end,
  --    config = function()
  --      require("dbee").setup( --[[optional config]])
  --    end
  --  }

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
