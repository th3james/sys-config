local hotpot_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/hotpot.nvim"
if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
	print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
	vim.fn.system({ "git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpot_path })
	vim.cmd("helptags " .. hotpot_path .. "/doc")
end

-- Enable fnl/ support
require("hotpot")

require("plugins")
require("lsp")
require("highlight")

-- jk instead of esc
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
-- colemak alternative
vim.keymap.set("i", "uu", "<Esc>", { noremap = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Space>ff", builtin.find_files, {})
vim.keymap.set("n", "<Space>fF", function()
	builtin.find_files({ hidden = true })
end, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fG", function()
	builtin.live_grep({ hidden = true })
end, {})
vim.keymap.set("n", "<Space>fb", builtin.buffers, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})

vim.keymap.set("n", "<Space>d", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<Space>l", function()
	vim.lsp.buf.format({
		timeout_ms = 10000,
		filter = function(client)
			return client.name ~= "tsserver"
		end, -- don't format with tsserver
	})
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

vim.o.undofile = true -- Persistent undo (across files)

vim.o.numberwidth = 4 -- Always show 4 digits for line numbers
vim.o.winwidth = 84 -- Force windows to be 80 char wide

vim.o.signcolumn = "yes" -- Always show sign column

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 300

vim.o.statusline = [[%f%<:%l %h%m%r%=%-14.(%l,%c%V%) %P]]

vim.g.copilot_node_command = "~/.asdf/installs/nodejs/17.9.1/bin/node"

function PBCFullPath()
	local full_path = vim.fn.expand("%:p")
	os.execute("echo " .. full_path .. " | pbcopy")
end

function PBCRelativePath()
	local relative_path = vim.fn.expand("%")
	os.execute("echo " .. relative_path .. " | pbcopy")
end

vim.cmd([[
" Language specific settings
" Go
autocmd FileType go setlocal noet ts=4 sw=4 sts=4
]])
