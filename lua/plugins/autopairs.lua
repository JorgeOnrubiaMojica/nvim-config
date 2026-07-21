return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Usa treesitter para contexto
      ts_config = {
        php = { "string", "comment" }, -- No auto-pair dentro de strings/comments
        lua = { "string", "comment" },
        javascript = { "string", "template_string" },
      },
      -- Deshabilitar para ciertos caracteres si querés
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
}
