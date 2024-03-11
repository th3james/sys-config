-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Searching
vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true -- case sensitive when uc present
vim.o.showmatch = true -- show matching brackets/parenthesis
vim.o.gdefault = true -- the /g flag on :s substitutions by default

vim.o.signcolumn = "yes" -- Always show sign column

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.o.scrolljump = 10 -- lines to scroll when cursor leaves screen
vim.o.scrolloff = 10 -- minimum lines to keep above and below cursor

vim.o.linespace = 0 -- No extra spaces between rows
vim.o.wildmode = "list:longest,full" -- Command-line completion mode
vim.o.whichwrap = "b,s,h,l,<,>,[,]" -- backspace and cursor keys wrap to

vim.o.expandtab = true -- Spaces instead of tabs
vim.o.tabstop = 2 -- Number of spaces per tab
vim.o.shiftwidth = 2 -- Number of spaces per tab
vim.o.softtabstop = 2 -- Number of spaces per tab

vim.o.numberwidth = 4 -- Always show 4 digits for line numbers
vim.o.winwidth = 84 -- Force windows to be 80 char wide

vim.o.statusline = [[%f%<:%l %h%m%r%=%-14.(%l,%c%V%) %P]]

vim.o.background = "dark" -- assume dark background

vim.opt.rtp:append("/opt/homebrew/bin/fzf")
