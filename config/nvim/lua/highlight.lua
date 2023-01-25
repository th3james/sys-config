local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"c",
		"dockerfile",
		"diff",
		"fish",
		"gitcommit",
		"gitignore",
		"go",
		"help",
		"html",
		"htmldjango",
		"javascript",
		"json",
		"lua",
		"make",
		"markdown",
		"python",
		"ruby",
		"rust",
		"terraform",
		"toml",
		"tsx",
		"yaml",
	},
	highlight = {
		enable = true,
	},
})
