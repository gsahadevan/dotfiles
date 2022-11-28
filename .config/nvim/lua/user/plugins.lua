-- use a protected call so we don"t error out on first use
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- make packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- allows packer to manage itself
  use "nvim-lua/popup.nvim" -- an implementation of pop api from vim in neovim
  use "nvim-lua/plenary.nvim" -- contains useful lua functions used by many plugins
  use { "nvim-telescope/telescope.nvim", tag = "0.1.0" } -- fuzzy finder | requires plenary.nvim
  use "folke/tokyonight.nvim" -- colorscheme

  use "windwp/nvim-autopairs" -- autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"


  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- lsp - language server protocol
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- LSP diagnostics and code actions
  use "RRethy/vim-illuminate"

  -- git
  use "lewis6991/gitsigns.nvim"

  -- treesitter
  use "nvim-treesitter/nvim-treesitter"

  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "moll/vim-bbye"
  use "akinsho/bufferline.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "folke/which-key.nvim"
  use "goolord/alpha-nvim"
  use "nvim-lualine/lualine.nvim" -- status line | requires nvim-web-devicons
end)
