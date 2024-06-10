return {
	-- File system browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true, -- display "hidden items" and use a different highlight
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
				},
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
