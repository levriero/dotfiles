return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Extend and create a/i textobjects
			require("mini.ai").setup({ n_lines = 500 })

			-- Surround actions
			require("mini.surround").setup()

			-- Autopairs
			require("mini.pairs").setup()
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
