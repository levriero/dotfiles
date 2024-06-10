return {
	{ -- Statusline
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
					component_separators = "",
					section_separators = { left = "", right = "" },
				},
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
