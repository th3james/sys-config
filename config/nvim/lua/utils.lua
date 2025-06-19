local M = {}

local function log_warn_no_file_buffer()
	vim.notify("Can't yank, buffer has no associated file", vim.log.levels.WARN)
end

function M.yank_path()
	local filepath = vim.fn.expand("%")
	if filepath == nil or filepath == "" then
		log_warn_no_file_buffer()
		return
	end

	vim.fn.setreg("+", filepath)
	vim.notify("Path yanked to clipboard: " .. filepath, vim.log.levels.INFO)
end

function M.yank_line()
	local filepath = vim.fn.expand("%")

	if filepath == nil or filepath == "" then
		log_warn_no_file_buffer()
		return
	end

	local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local line_content = vim.api.nvim_get_current_line()

	local path_with_line_number = filepath .. ":" .. line_number
	local result = path_with_line_number .. "\n```\n" .. line_content .. "\n```\n"
	vim.fn.setreg("+", result)
	vim.notify("Line yanked to clipboard: " .. path_with_line_number, vim.log.levels.INFO)
end

function M.yank_selection()
	local filepath = vim.fn.expand("%")
	if filepath == nil or filepath == "" then
		log_warn_no_file_buffer()
		return
	end

	-- Get the visually selected text directly
	vim.cmd('normal! "xy') -- Yank selection to register x
	local selected_content = vim.fn.getreg("x")

	-- Get line numbers for reference
	local start_line = vim.fn.getpos("'<")[2]
	local end_line = vim.fn.getpos("'>")[2]

	local reference_path_with_lines
	if start_line == end_line then
		reference_path_with_lines = filepath .. ":" .. start_line
	else
		reference_path_with_lines = filepath .. ":" .. start_line .. "-" .. end_line
	end

	local result = reference_path_with_lines .. "\n```\n" .. selected_content .. "\n```\n"
	vim.fn.setreg("+", result)
	vim.notify("Selection yanked to clipboard: " .. reference_path_with_lines, vim.log.levels.INFO)
end

function M.yank_file_with_path()
	local filepath = vim.fn.expand("%")
	if filepath == nil or filepath == "" then
		log_warn_no_file_buffer()
		return
	end

	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	local formatted = filepath .. "\n```\n" .. content .. "\n```\n"
	vim.fn.setreg("+", formatted)
	vim.notify("File content yanked to clipboard: " .. filepath, vim.log.levels.INFO)
end

return M
