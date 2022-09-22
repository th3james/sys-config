set nocompatible          " We're running Vim, not Vi!
filetype off                   " required!

call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-rails'

Plug 'ervandew/supertab'
set rtp+="/opt/homebrew/bin/fzf"
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
"Plug 'thoughtbot/vim-rspec'
"Plug 'rust-lang/rust.vim'
"Plug 'keith/swift.vim'
"Plug 'yodiaditya/vim-pydjango'
"Plug 'nvie/vim-flake8'
"Plug 'janko-m/vim-test'
"Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'hashivim/vim-terraform'
"Plug 'leafgarland/typescript-vim'
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'morhetz/gruvbox'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go'

" vim-scripts repos
"Plug 'vim-scripts/L9'

call plug#end()

let g:vim_markdown_folding_disabled=1

filetype plugin indent on     " required!

" UI stuff
set t_Co=256

syntax on                 " Enable syntax highlighting
color default
colorscheme gruvbox
set background=dark       " Assume a dark background

set backspace=indent,eol,start	" backspace for dummys
set linespace=0		        " No extra spaces between rows
set nu                                " Line numbers on
set showmatch                         " show matching brackets/parenthesis
set incsearch	                        " find as you type search
set hlsearch	                        " highlight search terms
set ignorecase			" case insensitive search
set smartcase                         " case sensitive when uc present
set wildmenu                          " show list instead of just completing
set wildmode=list:longest,full        " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	        " backspace and cursor keys wrap to
set scrolljump=5                      " lines to scroll when cursor leaves screen
set scrolloff=3                       " minimum lines to keep above and below cursor
set gdefault                          " the /g flag on :s substitutions by default

set undofile              " Persistent undo (across files)


" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

set expandtab
set ai sw=2 sts=2 et

" Language specific settings
" Go
autocmd FileType go setlocal noet ts=4 sw=4 sts=4

" Force windows to be 80 char wide
set numberwidth=4
set winwidth=84

nnoremap <C-p> :Files<CR>

let g:fzf_layout = { 'down': '~40%' }

nnoremap <C-s> :Rg<CR>

" vim-test setup
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

"let test#strategy = "vimux"

" Example docker transform
"function! DockerTransform(cmd) abort
"  return 'docker-compose run app '.a:cmd
"endfunction

"let g:test#custom_transformations = {'docker': function('DockerTransform')}
"let g:test#transformation = 'docker'

"let test#python#runner = 'pytest'

" jk instead of esc
imap jk <Esc>

set statusline=%f%<\:%l\ %h%m%r%=%-14.(%l,%c%V%)\ %P

if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source ".path
  endfor
endif

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Custom commands
command PBCFullPath execute "!echo %:p | pbcopy"
command PBCRelativePath execute "!echo % | pbcopy"

" LSP config
lua require('lspconfig').pyright.setup{}
lua require('lspconfig').gopls.setup{}
lua require('lspconfig').tsserver.setup{}
" End LSP config
