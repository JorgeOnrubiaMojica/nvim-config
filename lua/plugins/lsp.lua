return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({
        'lua_ls',
        'phpactor',
        'marksman',
        'sqlls',
        'biome',
        'vtsls'
      })
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  }
}
