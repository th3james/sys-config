local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"neovim/nvim-lspconfig",
	"mfussenegger/nvim-lint",
	"mhartington/formatter.nvim",
	"oxfist/night-owl.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},
	"jaawerth/fennel.vim",
	--
	{
		"Olical/conjure",
		dependencies = {
			"tpope/vim-dispatch",
			"clojure-vim/vim-jack-in",
			"radenling/vim-dispatch-neovim",
		},
	},
	--
	"ziglang/zig",
})
-- Plugin list to port to packer.nvim
-- Plug 'chr4/nginx.vim'

--
--	-- themes
--	use("morhetz/gruvbox")
--
--
--	use({
--		"nvim-telescope/telescope.nvim",
--		tag = "0.1.4",
--		requires = {
--			"nvim-lua/plenary.nvim",
--			{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
--
--			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
--		},
--	})
--
--	use("simrat39/rust-tools.nvim")
--
