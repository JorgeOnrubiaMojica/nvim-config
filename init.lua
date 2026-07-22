require('config.options')
pcall(require, 'config.local')
require('config.plugins')
require('config.mappings')

vim.cmd('colorscheme minischeme')
