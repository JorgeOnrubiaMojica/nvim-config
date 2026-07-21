-- Treesitter config.
--
-- Uses the `main` branch of both plugins (the `master` branch is frozen and
-- incompatible with Neovim 0.12+; it crashed on markdown code fences via the
-- legacy `set-lang-from-info-string!` query directive).
--
-- On `main`, highlighting/folding/indentation are provided by Neovim core and
-- enabled here through a FileType autocommand; this plugin just ships the
-- queries and parser installation. Textobjects are configured separately below.
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- nvim-treesitter `main` does not support lazy loading
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },
    config = function()
      local ts = require('nvim-treesitter')

      -- Optional: use default install directory (`stdpath('data')/site`).
      ts.setup {}

      -- On `main`, the bundled queries live under `<plugin>/runtime/queries/`
      -- and are NOT auto-added to runtimepath. Without this, parsers load but
      -- highlighting gets zero captures (code "doesn't paint").
      local plugin_root = vim.fn.fnamemodify(vim.api.nvim_get_runtime_file('lua/nvim-treesitter/config.lua', false)[1] or '', ':h:h:h')
      if plugin_root ~= '' then
        vim.opt.runtimepath:prepend(plugin_root .. '/runtime')
      end

      -- NOTE: parsers are installed on demand with `:TSInstall` / `:TSUpdate`.
      -- The prebuilt parsers already on the runtimepath keep working in the
      -- meantime, so highlighting stays on.
      --
      -- Recommended after switching to `main`:
      --   :TSInstall c cpp go lua php python rust tsx javascript typescript \
      --             vim vimdoc bash elixir markdown markdown_inline html \
      --             json yaml toml regex query

      -- Highlighting and indentation via Neovim core.
      -- Skips filetypes without an installed parser (falls back to regex).
      -- NOTE: treesitter-based folding is intentionally NOT enabled here, to keep
      -- the previous behavior (no automatic folding on open). Enable it with a
      -- `foldmethod='expr'` + `foldexpr='v:lua.vim.treesitter.foldexpr()'`
      -- FileType autocommand if you want it later.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup(' TreesitterStart', { clear = true }),
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if not ok then
            return
          end
          -- Treesitter-based indentation, experimental (buffer-local).
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Textobjects (select / move / swap) via the `main` branch API.
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true, -- jump forward to the textobj, like targets.vim
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true, -- populate the jumplist
        },
      }

      local select_mod = require('nvim-treesitter-textobjects.select')
      local move_mod = require('nvim-treesitter-textobjects.move')
      local swap_mod = require('nvim-treesitter-textobjects.swap')

      local function map(lhs, fn, desc)
        vim.keymap.set({ 'x', 'o' }, lhs, fn, { desc = desc })
      end

      -- select (operator-pending + visual)
      map('aa', function() select_mod.select_textobject('@parameter.outer', 'textobjects') end, 'Select [a]rgument (outer)')
      map('ia', function() select_mod.select_textobject('@parameter.inner', 'textobjects') end, 'Select [a]rgument (inner)')
      map('af', function() select_mod.select_textobject('@function.outer', 'textobjects') end, 'Select [f]unction (outer)')
      map('if', function() select_mod.select_textobject('@function.inner', 'textobjects') end, 'Select [f]unction (inner)')
      map('ac', function() select_mod.select_textobject('@class.outer', 'textobjects') end, 'Select [c]lass (outer)')
      map('ic', function() select_mod.select_textobject('@class.inner', 'textobjects') end, 'Select [c]lass (inner)')

      -- move
      local function map_move(lhs, fn, desc)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, fn, { desc = desc })
      end
      map_move(']m', function() move_mod.goto_next_start('@function.outer', 'textobjects') end, 'Next function start')
      map_move(']]', function() move_mod.goto_next_start('@class.outer', 'textobjects') end, 'Next class start')
      map_move(']M', function() move_mod.goto_next_end('@function.outer', 'textobjects') end, 'Next function end')
      map_move('][', function() move_mod.goto_next_end('@class.outer', 'textobjects') end, 'Next class end')
      map_move('[m', function() move_mod.goto_previous_start('@function.outer', 'textobjects') end, 'Prev function start')
      map_move('[[', function() move_mod.goto_previous_start('@class.outer', 'textobjects') end, 'Prev class start')
      map_move('[M', function() move_mod.goto_previous_end('@function.outer', 'textobjects') end, 'Prev function end')
      map_move('[]', function() move_mod.goto_previous_end('@class.outer', 'textobjects') end, 'Prev class end')

      -- swap parameters
      vim.keymap.set('n', '<leader>a', function() swap_mod.swap_next('@parameter.inner') end, { desc = 'Swap parameter next' })
      vim.keymap.set('n', '<leader>A', function() swap_mod.swap_previous('@parameter.inner') end, { desc = 'Swap parameter previous' })
    end,
  },
}
