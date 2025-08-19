
local option = vim.o

-- Set highlight on search
option.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
option.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
option.clipboard = 'unnamedplus'

-- Enable break indent
option.breakindent = true

-- Save undo history
option.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
option.ignorecase = true
option.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes:1'

-- Decrease update time
option.updatetime = 250
option.timeoutlen = 300

-- Set completeopt to have a better completion experience
option.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
option.termguicolors = true

vim.cmd('colorscheme catppuccin-mocha')

