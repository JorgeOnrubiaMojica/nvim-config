local add = require('mini.deps').add

require('mini.git').setup()
require('mini.diff').setup()

add('tpope/vim-fugitive')

vim.keymap.set('n', '<leader>G', '<CMD>Git<CR>', { desc = 'Git' })
