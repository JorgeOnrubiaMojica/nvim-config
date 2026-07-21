return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = {
      -- Integración con treesitter para detectar contexto
      pre_hook = function(ctx)
        -- Para JSX/TSX comentarios correctos
        local U = require("Comment.utils")
        local location = nil
        if ctx.ctype == U.ctype.blockwise then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end
        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
          location = location,
        })
      end,
    },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}
