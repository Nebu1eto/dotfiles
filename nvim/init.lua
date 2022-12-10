local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local keyset = vim.keymap.set

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.fzf_preview_window = {}

local fzf_action = {}
fzf_action["ctrl-t"] = "tab split"
fzf_action["ctrl-h"] = "split"
fzf_action["ctrl-v"] = "vsplit"
g.fzf_action = fzf_action

local fzf_colors = {}
fzf_colors["fg"] = { 'fg', 'Normal' }
fzf_colors["bg"] = { 'bg', 'Normal' }
fzf_colors["hl"] = { 'fg', 'Comment' }
fzf_colors["fg"] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' }
fzf_colors["bg"] = { 'bg', 'CursorLine', 'CursorColumn' }
fzf_colors["hl"] = { 'fg', 'Statement' }
fzf_colors["info"] = { 'fg', 'PreProc' }
fzf_colors["border"] = { 'fg', 'Ignore' }
fzf_colors["prompt"] = { 'fg', 'Conditional' }
fzf_colors["pointer"] = { 'fg', 'Exception' }
fzf_colors["marker"] = { 'fg', 'Keyword' }
fzf_colors["spinner"] = { 'fg', 'Label' }
fzf_colors["header"] = { 'fg', 'Comment' }
g.fzf_colors = fzf_colors

g.fzf_history_dir = '~/.local/share/fzf-history'

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.number = true

opt.foldminlines = 50
opt.foldnestmax = 2
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- Set colorscheme as nord
vim.cmd [[colorscheme nord]]

-- Plugins Initialization
require('hlslens').setup()

-- initialize hlslens
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

-- Use F to format code with coc.
function _G.format_code()
  if vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocCommandAsync('editor.action.formatDocument')
  end
end

-- Use N to lint code with coc.
function _G.lint_code()
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if vim.api.nvim_eval('coc#rpc#ready()') then
    if ft == 'python' then
      vim.fn.CocCommandAsync('python.sortImports')
    end
  end
end

-- Use T to open new tab and toggle NvimTree.
function _G.new_tab()
  vim.api.nvim_command('tabnew')
  vim.api.nvim_command('NvimTreeOpen')
end

function _G.open_terminal_in_left_side()
  vim.api.nvim_command('60 vsplit term://zsh')
  vim.api.nvim_command('set ma')
end

function _G.open_terminal_in_bottom_side()
  vim.api.nvim_command('10 split term://zsh')
  vim.api.nvim_command('set ma')
end

keyset('n', 'F', '<CMD>lua _G.format_code()<CR>', {silent = true})
keyset('n', 'N', '<CMD>lua _G.lint_code()<CR>', {silent = true})
keyset('n', 'T', '<CMD>lua _G.new_tab()<CR>', {silent = true})

-- Use delete works in insert mode.
keyset('i', '<C-d>', '<Del>')

-- Use [ and ] to open terminal in left and bottom side.
keyset('n', '[', '<CMD>lua _G.open_terminal_in_left_side()<CR>', {silent = true})
keyset('n', ']', '<CMD>lua _G.open_terminal_in_bottom_side()<CR>', {silent = true})

-- Use <C-t> to search files with fzf.
keyset('n', '<C-t>', '<CMD>GFiles<CR>', {silent = true})
keyset('n', '<C-y>', '<CMD>GFiles?<CR>', {silent = true})

-- Use <C-d> to duplicate current line.
keyset('n', '<C-d>', '<CMD>yyd<CR>', {silent = true})

-- Use <cr> to autocomplete from coc.
function _G.confirm_coc()
  return vim.api.nvim_eval("coc#pum#visible()") == 1 and vim.api.nvim_eval("coc#pum#confirm()") or "<CR>"
end
keyset('i', '<cr>', 'v:lua.confirm_coc()', { noremap = true, expr = true })

-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end
keyset('n', 'K', '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Use L to toggle tree view.
keyset('n', 'L', '<CMD>NvimTreeOpen<CR>', {silent = true})

-- Initializing NvimTree
require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = false,
    width = 40,
    side = 'right',
    mappings = {
      list = {
        { key = 'u', action = 'dir_up' },
        { key = 'r', action = 'rename' },
        { key = 'd', action = 'delete' },
        { key = 'n', action = 'create' },
	      { key = '.', action = 'expand_all' },
      },
    },
  },
  renderer = {
    group_empty = false,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    expand_all = {
      max_folder_discovery = 5,
      exclude = {},
    },
  },
})

-- Initialize GitSigns
require('gitsigns').setup({
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  word_diff  = true,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
})

-- Initialize BufferLine
require('bufferline').setup({
  options = {
    diagnostics = 'coc',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ' '
      for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and ' '
          or (e == 'warning' and ' ' or '' )
        s = s .. n .. sym
      end
      return s
    end,
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 20,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_buffer_default_icon = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = false,
    persist_buffer_sort = false,
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true,
      delay = 100,
      reveal = { 'close' }
    },
    sort_by = 'tabs',
  },
})

-- Initialize Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'location'},
    lualine_y = {'fileformat'},
    lualine_z = {'filetype'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Initialize Scrollbar
require('scrollbar').setup({
  show = true,
  show_in_active_only = false,
  set_highlights = true,
  folds = 30000,
  max_lines = false,
  hide_if_all_visible = false,
  throttle_ms = 50,
  handle = {
    text = ' ',
    color = nil,
    cterm = nil,
    highlight = 'CursorColumn',
    hide_if_all_visible = false,
  },
  excluded_filetypes = {
    'prompt',
    'TelescopePrompt',
    'noice',
  },
  autocmd = {
    render = {
        'BufWinEnter',
        'TabEnter',
        'TermEnter',
        'WinEnter',
        'CmdwinLeave',
        'TextChanged',
        'VimResized',
        'WinScrolled',
    },
    clear = {
        'BufWinLeave',
        'TabLeave',
        'TermLeave',
        'WinLeave',
    },
  },
  handlers = {
    cursor = true,
    diagnostic = true,
    gitsigns = true, -- Requires gitsigns
    handle = true,
    search = true, -- Requires hlslens
  },
})

-- Setup Treesitter for some languages
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "html",
    "css",
    "python",
    "rust",
    "go", 
    "toml",
    "tsx",
    "yaml",
    "sql",
    "rst",
    "make",
    "markdown",
    "json",
    "jsonc",
    "dockerfile",
    "diff",
    "rego",
    "scss",
  },
  disabled = {
    "lua",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },

})

-- Required Packer Settings **IMPORTANT**
local create_cmd = vim.api.nvim_create_user_command
create_cmd('PackerInstall', function()
  cmd [[packadd packer.nvim]]
  require('plugins').install()
end, {})
create_cmd('PackerUpdate', function()
  cmd [[packadd packer.nvim]]
  require('plugins').update()
end, {})
create_cmd('PackerSync', function()
  cmd [[packadd packer.nvim]]
  require('plugins').sync()
end, {})
create_cmd('PackerClean', function()
  cmd [[packadd packer.nvim]]
  require('plugins').clean()
end, {})
create_cmd('PackerCompile', function()
  cmd [[packadd packer.nvim]]
  require('plugins').compile()
end, {})
