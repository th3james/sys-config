  " Somewhat copied from https://github.com/spf13/spf13-vim/blob/master/.vimrc
  set nocompatible          " We're running Vim, not Vi!
  filetype off                   " required!

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let Vundle manage Vundle
  " required! 
  Bundle 'gmarik/vundle'

  " My Bundles here:
  "
  " original repos on github
  Bundle 'tpope/vim-rails.git'
  Bundle 'scrooloose/nerdtree'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'wikitopian/hardmode'
  Bundle 'briancollins/vim-jst'
  Bundle 'nono/vim-handlebars'
  " vim-scripts repos
  Bundle 'L9'
  Bundle 'FuzzyFinder'
  " non github repos
  "Bundle 'git://git.wincent.com/command-t.git'
  " ...

  filetype plugin indent on     " required!
  "
  " Brief help
  " :BundleList          - list configured bundles
  " :BundleInstall(!)    - install(update) bundles
  " :BundleSearch(!) foo - search(or refresh cache first) for foo
  " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
  "
  " see :h vundle for more details or wiki for FAQ
  " NOTE: comments after Bundle command are not allowed..

  " UI stuff
  set t_Co=256

  syntax on                 " Enable syntax highlighting
  set background=dark       " Assume a dark background
  color ir_black

  set backspace=indent,eol,start	" backspace for dummys
  set linespace=0		        " No extra spaces between rows
  set nu                                " Line numbers on
  set showmatch                         " show matching brackets/parenthesis
  set incsearch	                        " find as you type search
  set hlsearch	                        " highlight search terms
  set winminheight=0                    " windows can be 0 line high 
  set ignorecase			" case insensitive search
  set smartcase                         " case sensitive when uc present
  set wildmenu                          " show list instead of just completing
  set wildmode=list:longest,full        " command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]	        " backspace and cursor keys wrap to
  set scrolljump=5                      " lines to scroll when cursor leaves screen
  set scrolloff=3                       " minimum lines to keep above and below cursor
  set foldenable                        " auto fold code
  set gdefault                          " the /g flag on :s substitutions by default

  set spell                 " spell checking on
  set undofile              " Persistent undo (across files)
  

  " Load matchit (% to bounce from do to end, etc.)
  runtime! macros/matchit.vim

  augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  augroup END

  set hidden " allow hiding buffers with changes

  set autoindent
  set smarttab
  set expandtab

  set ai sw=2 sts=2 et
 
  "set omnifunc=csscomplete#CompleteCSS 
  
  " enable hard mode
  autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

  set gfn=DejaVu\ Sans\ Mono:h12

