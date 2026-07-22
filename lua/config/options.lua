vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  virtual_lines = { current_line = true },
  update_in_insert = false,
  severity_sort = true,
})
