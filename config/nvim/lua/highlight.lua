local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"fish",
		"help",
		"javascript",
		"lua",
		"make",
		"markdown",
		"python",
		"yaml",
	},
	highlight = {
		enable = true,
	},
})
