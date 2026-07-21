return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      defaults = {
        formatter = "path.filename_first"
      }
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()
    end,
  }
}
