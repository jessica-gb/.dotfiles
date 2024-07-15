local opt = vim.opt
opt.termguicolors = true

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes and appearance
  use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  use 'EdenEast/nightfox.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'goolord/alpha-nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup()
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    after = 'tokyonight.nvim',
    config = function()
      require('colorizer').setup()
    end
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- General
  use 'tpope/vim-commentary'
  use 'raimondi/delimitmate'
  use 'dstein64/vim-startuptime'
  use 'github/copilot.vim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
      require('telescope').load_extension('fzf')
      require("telescope").load_extension('file_browser')
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- Neovim LSP
  use { 
    'neovim/nvim-lspconfig',
    config = function()
      require'lspconfig'.pyright.setup{}
    end
  }
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Linting
  use {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        markdown = {'pylint',}
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }

  -- Python
  use 'Vimjas/vim-python-pep8-indent'

  -- Auto dark mode
  use {
    'f-person/auto-dark-mode.nvim',
    config = function()
      local auto_dark_mode = require('auto-dark-mode')
      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option('background', 'dark')
          vim.cmd('colorscheme sonokai')
        end,
        set_light_mode = function()
          vim.api.nvim_set_option('background', 'light')
          vim.cmd('colorscheme dawnfox')
        end,
      })
      auto_dark_mode.init()
    end
  }
end)
