require("plugins")
require("lsp")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Space>ff", builtin.find_files, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fb", builtin.buffers, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})

vim.keymap.set("n", "<Space>d", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<Space>l", function()
	vim.lsp.buf.format({ timeout_ms = 10000 })
end, {})

vim.opt.rtp:append("/opt/homebrew/bin/fzf")

vim.cmd([[

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


let g:fzf_layout = { 'down': '~40%' }

" Example docker transform
"function! DockerTransform(cmd) abort
"  return 'docker-compose run app '.a:cmd
"endfunction

"let g:test#custom_transformations = {'docker': function('DockerTransform')}
"let g:test#transformation = 'docker'

"let test#python#runner = 'pytest'

" jk instead of esc
imap jk <Esc>
" tarmak alternative
imap hh <Esc>

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

let g:copilot_node_command = "~/.asdf/installs/nodejs/17.9.1/bin/node"
]])
