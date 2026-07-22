require('config.options')
pcall(require, 'config.local')
require('config.plugins')

vim.cmd('colorscheme minischeme')
