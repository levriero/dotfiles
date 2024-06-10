return {
	{ -- Colourscheme
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		opts = {
			style = "night",
		},
		init = function()
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			-- vim.cmd.hi 'Comment gui=none'
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
