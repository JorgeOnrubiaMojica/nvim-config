local package_root = vim.fn.stdpath('data') .. '/site/pack'
local mini_deps = package_root .. '/deps/opt/mini.nvim'

if not vim.uv.fs_stat(mini_deps) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_deps
  })
end

vim.cmd('packadd mini.nvim')

require('mini.deps').setup({ path = { package_root = package_root } })

local indentscope = require('mini.indentscope')
indentscope.setup({
  draw = { animation = indentscope.gen_animation.none() },
})


require('mini.ai').setup()
require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.misc').setup()
require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bg = '#89b4fa', fg = '#1e1e2e', bold = true })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { bg = '#f5c2e7', fg = '#1e1e2e', bold = true })
require('mini.completion').setup()
require('mini.trailspace').setup()
require('mini.clue').setup({
  clues = {
    -- Leader key triggers
    { mode = 'n', keys = '<leader>', desc = 'Leader prefix' },
    { mode = 'n', keys = 'g', desc = 'Goto prefix' },
    { mode = 'n', keys = '<Tab>', desc = 'Buffer navigation' },
    { mode = 'i', keys = 'jk', desc = 'Exit insert mode' },
    { mode = 'x', keys = '<leader>', desc = 'Visual leader prefix' },
  },
  window = { config = { border = 'rounded' } },
})

local add, later = require('mini.deps').add, require('mini.deps').later
add('stevearc/oil.nvim')
require('oil').setup({ view_options = { show_hidden = true } })

add('nvim-treesitter/nvim-treesitter')
later(function()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
  require('nvim-treesitter').setup()
end)

add('ibhagwan/fzf-lua')
require('fzf-lua').setup({})

add('tpope/vim-fugitive')

add('MeanderingProgrammer/render-markdown.nvim')
require('render-markdown').setup({})

add('catppuccin/nvim')
require('catppuccin').setup({ flavour = 'mocha' })

add('neovim/nvim-lspconfig')
add('williamboman/mason.nvim')
add('williamboman/mason-lspconfig.nvim')

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'sqlls', 'jsonls' },
  automatic_installation = true,
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('DisableSemanticTokens', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

add('mfussenegger/nvim-lint')
require('lint').linters_by_ft = {
  php = { 'phpstan' },
}
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})
