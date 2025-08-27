return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig['lua_ls'].setup {}
      lspconfig['phpactor'].setup {}
      lspconfig['ts_ls'].setup {}
      lspconfig['marksman'].setup {}
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  }
}
