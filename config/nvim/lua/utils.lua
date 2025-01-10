local M = {}

function M.yank_file_with_path()
	local filepath = vim.fn.expand("%")
	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	local formatted = filepath .. "\n```\n" .. content .. "\n```"
	vim.fn.setreg("+", formatted)
end

return M
