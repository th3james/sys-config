require("options")
require("plugins")
require("formatters")
require("linters")
require("lsp")

require("keymaps")

vim.cmd.colorscheme("night-owl")

-- require("commands")

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
