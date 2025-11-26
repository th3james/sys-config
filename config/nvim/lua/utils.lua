local M = {}

local function log_warn_no_file_buffer()
	vim.notify("Can't yank, buffer has no associated file", vim.log.levels.WARN)
end

function M.yank_path()
	local filepath = vim.fn.expand("%")
	if filepath == "" then return log_warn_no_file_buffer() end

	vim.fn.setreg("+", filepath)
	vim.notify("Path yanked to clipboard: " .. filepath, vim.log.levels.INFO)
end

function M.yank_line()
	local filepath = vim.fn.expand("%")
	if filepath == "" then return log_warn_no_file_buffer() end

	-- Direct integer/string lookup (cheaper than nvim_win_get_cursor allocation)
	local lnum = vim.fn.line(".")
	local content = vim.fn.getline(".")

	local ref = filepath .. ":" .. lnum
	vim.fn.setreg("+", ref .. "\n```\n" .. content .. "\n```\n")
	vim.notify("Line yanked to clipboard: " .. ref, vim.log.levels.INFO)
end

function M.yank_selection()
	local filepath = vim.fn.expand("%")
	if filepath == "" then return log_warn_no_file_buffer() end

	-- 1. Direct memory access: Yank to scratch 'x'
	vim.cmd('normal! "xy')

	-- 2. Data transformation: Strip the single trailing newline byte if present
	-- This handles the difference between 'v' and 'V' modes uniformly
	local content = vim.fn.getreg("x"):gsub("\n$", "")

	-- 3. Direct integer lookups for marks (cheaper/shorter than getpos)
	local s_line = vim.fn.line("'<")
	local e_line = vim.fn.line("'>")

	local ref = filepath .. ":" .. s_line
	if s_line ~= e_line then
		ref = ref .. "-" .. e_line
	end

	vim.fn.setreg("+", ref .. "\n```\n" .. content .. "\n```\n")
	vim.notify("Selection yanked: " .. ref, vim.log.levels.INFO)
end

function M.yank_file_with_path()
	local filepath = vim.fn.expand("%")
	if filepath == "" then return log_warn_no_file_buffer() end

	-- nvim_buf_get_lines is efficient for bulk retrieval
	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	
	vim.fn.setreg("+", filepath .. "\n```\n" .. content .. "\n```\n")
	vim.notify("File content yanked to clipboard: " .. filepath, vim.log.levels.INFO)
end

return M
