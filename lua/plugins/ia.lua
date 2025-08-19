return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Right>", -- 👈 aceptar con flecha derecha
          accept_word = false,
          accept_line = false,
          next = "<M-]>", -- opcional: siguiente sugerencia
          prev = "<M-[>", -- opcional: sugerencia anterior
          dismiss = "<C-]>",
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
    },
  },
}
