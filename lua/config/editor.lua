local add = require('mini.deps').add

-- Core editing
local indentscope = require('mini.indentscope')
indentscope.setup({
  draw = { animation = indentscope.gen_animation.none() },
})

require('mini.ai').setup()
require('mini.comment').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.trailspace').setup()
require('mini.misc').setup()
require('mini.statusline').setup()

local bufremove = require('mini.bufremove')
bufremove.setup()

-- Which-key (leader key popup)
add('folke/which-key.nvim')
require('which-key').setup({})

-- Oil (file explorer)
add('stevearc/oil.nvim')
require('oil').setup({ view_options = { show_hidden = true } })

-- Snippets
require('mini.snippets').setup({
  snippets = require('config.snippets'),
})
MiniSnippets.start_lsp_server()

local map = vim.keymap.set
map('i', '<C-j>', function() MiniSnippets.expand() end, { desc = 'Expand snippet' })
map('i', '<C-l>', function() MiniSnippets.jump() end, { desc = 'Jump to next tabstop' })
map('i', '<C-h>', function() MiniSnippets.jump({ backwards = true }) end, { desc = 'Jump to prev tabstop' })
map('i', '<C-x>', function() MiniSnippets.stop() end, { desc = 'Stop snippet session' })

-- Copilot
add('zbirenbaum/copilot.lua')
require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = '<Right>',
      accept_word = false,
      accept_line = false,
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<C-]>',
    },
  },
})
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
map('n', '<leader>w', ':w!<CR>', { desc = 'Save', silent = true })
map('n', '<Leader>x', bufremove.delete, { desc = 'Delete buffer' })
map('n', '<Leader>bD', bufremove.wipeout, { desc = 'Wipeout buffer' })
map('n', '<Tab>', ':bn<cr>', { desc = 'Next buffer', silent = true })
map('i', 'jk', '<ESC>', { noremap = true, silent = true })
