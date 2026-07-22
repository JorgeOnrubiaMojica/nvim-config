local add, later = require('mini.deps').add, require('mini.deps').later

require('mini.icons').setup()
require('mini.notify').setup()
require('mini.tabline').setup()

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bg = '#89b4fa', fg = '#1e1e2e', bold = true })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { bg = '#f5c2e7', fg = '#1e1e2e', bold = true })

-- Colorscheme
add('catppuccin/nvim')
require('catppuccin').setup({ flavour = 'mocha' })

-- Treesitter
add('nvim-treesitter/nvim-treesitter')
later(function()
  require('nvim-treesitter.config').setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
  require('nvim-treesitter').setup()
end)

-- Fzf-lua (search)
add('ibhagwan/fzf-lua')
require('fzf-lua').setup({})

-- Render-markdown
add('MeanderingProgrammer/render-markdown.nvim')
require('render-markdown').setup({})

-- Fzf keymaps
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = 'Live grep current buffer' })
vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ff', fzf.git_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>fc', function()
  fzf.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Search in config directory' })
vim.keymap.set('n', '<leader>fn', function()
  fzf.files({ cwd = vim.fn.expand('~/Notes') })
end, { desc = 'Search in notes directory' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
