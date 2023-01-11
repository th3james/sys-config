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

vim.cmd("colorscheme gruvbox")

vim.o.background = "dark" -- assume dark background

vim.o.linespace = 0 -- No extra spaces between rows
vim.o.wildmode = "list:longest,full" -- Command-line completion mode
vim.o.whichwrap = "b,s,h,l,<,>,[,]" -- backspace and cursor keys wrap to

vim.o.scrolljump = 5 -- lines to scroll when cursor leaves screen
vim.o.scrolloff = 3 -- minimum lines to keep above and below cursor

vim.o.nu = true -- Line numbers on

vim.o.expandtab = true -- Spaces instead of tabs
vim.o.tabstop = 2 -- Number of spaces per tab
vim.o.shiftwidth = 2 -- Number of spaces per tab
vim.o.softtabstop = 2 -- Number of spaces per tab

vim.o.showmatch = true -- show matching brackets/parenthesis
vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true -- case sensitive when uc present
vim.o.gdefault = true -- the /g flag on :s substitutions by default

vim.o.undofile = true              -- Persistent undo (across files)

vim.cmd([[

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
