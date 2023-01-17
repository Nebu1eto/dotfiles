-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--  ~/.local/share/nvim/site/pack/packer/start/packer.nvimㄴ

-- Dependencies
vim.cmd [[packadd packer.lua]]

return require("packer").startup(function (use)
  use {"wbthomason/packer.nvim", opt = true}

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use { 'shaunsingh/nord.nvim' }

  use { "lukas-reineke/indent-blankline.nvim" }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use("petertriho/nvim-scrollbar")
  use('lewis6991/gitsigns.nvim')
  use('kevinhwang91/nvim-hlslens')

  use {
    'neoclide/coc.nvim',
     branch = 'release',
  }

  use {
	  "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  -- FZF
  use { 'junegunn/fzf', run = function () vim.api.nvim_eval("fzf#install()") end }
  use { 'junegunn/fzf.vim' }
  
  -- Treesitter
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }

  use {
    'woosaaahh/sj.nvim'
  }
end)
