local hotpot_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/hotpot.nvim"
if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
	print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
	vim.fn.system({ "git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpot_path })
	vim.cmd("helptags " .. hotpot_path .. "/doc")
end

-- Enable fnl/ support
require("hotpot")

require("options")
require("plugins")
require("formatters")
require("linters")
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
vim.keymap.set("n", "<Space>fd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<Space>fr", builtin.lsp_references, {})
vim.keymap.set("n", "<Space>fe", builtin.diagnostics, {})

vim.cmd.colorscheme("night-owl")

require("commands")

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
