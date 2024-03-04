local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"neovim/nvim-lspconfig",
	})

	use("mfussenegger/nvim-lint")

	use("mhartington/formatter.nvim")

	-- themes
	use("morhetz/gruvbox")
	use("oxfist/night-owl.nvim")

	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	use("simrat39/rust-tools.nvim")

	use("jaawerth/fennel.vim")

	-- Needed for conjure
	use("tpope/vim-dispatch")
	use("clojure-vim/vim-jack-in")
	use("radenling/vim-dispatch-neovim")

	use("Olical/conjure")

	use("ziglang/zig")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- Plugin list to port to packer.nvim
-- Plug 'chr4/nginx.vim'
