vim.cmd.colorscheme "catppuccin-frappe"

require("catppuccin").setup({
  transparent_background = true,
  flavour = "frappe", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "frappe",
  },
  float = { transparent = true, solid = true },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = false,
    coc_nvim = true,
    fzf = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
    treesitter_context = true,
  },
})

