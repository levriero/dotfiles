-- [[ Configure and install plugins ]]
require("lazy").setup({
	require("plugins/tokyonight"),
	require("plugins/treesitter"),

	require("plugins/which-key"),

	require("plugins/gitsigns"),

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	require("plugins/todo-comments"),

	require("plugins/telescope"),
	require("plugins/lspconfig"),
	require("plugins/cmp"),

	require("plugins/conform"),

	require("plugins/mini"),

	require("plugins/lualine"),

	require("plugins/neo-tree"),

	require("plugins/dashboard"),
})

-- vim: ts=2 sts=2 sw=2 et
