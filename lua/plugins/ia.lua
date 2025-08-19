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
	}
}
