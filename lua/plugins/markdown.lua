return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'markdown' },
    opts = {
      -- Configuración para hacer los encabezados más grandes visualmente
      heading = {
        -- Habilitar renderizado de encabezados
        enabled = true,
        -- Iconos para cada nivel de encabezado
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        -- Colores de fondo para cada nivel
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
        -- Colores de texto para cada nivel
        foregrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        },
      },
      -- Renderizar bloques de código con fondo
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        width = 'block',
        left_pad = 2,
        right_pad = 2,
      },
      -- Renderizar listas con bullets bonitos
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
      },
      -- Checkboxes interactivos
      checkbox = {
        enabled = true,
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰱒 ' },
      },
      -- Renderizar tablas
      pipe_table = {
        enabled = true,
        style = 'full',
      },
    },
  },
}
