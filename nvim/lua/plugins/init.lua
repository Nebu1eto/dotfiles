return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons" },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  { "petertriho/nvim-scrollbar" },
  { "lewis6991/gitsigns.nvim" },
  { "kevinhwang91/nvim-hlslens" },
  { "neoclide/coc.nvim", branch = "release" },
  { "SmiteshP/nvim-gps" },

  -- FZF
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },

  -- Treesitter
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
  { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
  { "woosaaahh/sj.nvim" },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

