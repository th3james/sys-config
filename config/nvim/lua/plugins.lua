local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  print("In packer start up")
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'

  use 'morhetz/gruvbox'

  use 'github/copilot.vim'

  use {
    "nvim-telescope/telescope.nvim", tag = '0.1.0',
    requires = {
      "nvim-lua/plenary.nvim",

      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    print("Packer needs bootstrapping")
    require('packer').sync()
    print("Synced packer")
  end
end)


-- Plugin list to port to packer.nvim
-- Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
-- "Plug 'rust-lang/rust.vim'
-- Plug 'tpope/vim-fugitive'
-- "Plug 'airblade/vim-gitgutter'
-- Plug 'tpope/vim-rhubarb'
-- "Plug 'christoomey/vim-tmux-navigator'
-- Plug 'hashivim/vim-terraform'
-- "Plug 'leafgarland/typescript-vim'
-- Plug 'chr4/nginx.vim'
-- Plug 'ekalinin/Dockerfile.vim'
-- Plug 'cespare/vim-toml'
-- Plug 'dag/vim-fish'
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'fatih/vim-go'

