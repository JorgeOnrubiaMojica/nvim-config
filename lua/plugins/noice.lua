return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        view = "messages_box",
        view_error = "messages_box",
        view_warn = "messages_box",
        view_history = "messages",
      },
      notify = {
        view = "mini",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
          ["vim.lsp.util.show_line_diagnostics"] = false,
        },
        progress = {
          enabled = true,
          format = "lsp",
          throttle = 1000 / 30,
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          border = {
            style = "rounded",
            padding = { 1, 2 },
          },
        },
        messages_box = {
          backend = "popup",
          position = { row = 0, col = "100%" },
          anchor = "NE",
          size = { width = "auto", height = "auto", max_width = 60 },
          border = { style = "rounded" },
          timeout = 4000,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
