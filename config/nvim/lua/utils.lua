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

	-- Get selection range using marks. '< and '> marks are set by visual mode.
	-- vim.api.nvim_buf_get_mark(bufnr, name) returns [row, col] (row is 1-based).
	-- Using 0 for current buffer.
	local start_mark = vim.api.nvim_buf_get_mark(0, "<")
	local end_mark = vim.api.nvim_buf_get_mark(0, ">")

	-- If marks are not set (e.g., function called outside visual mode or no selection),
	-- nvim_buf_get_mark returns {0,0}.
	if start_mark[1] == 0 or end_mark[1] == 0 then
		vim.notify("No visual selection detected or marks not set.", vim.log.levels.WARN)
		return
	end

	local start_line = start_mark[1] -- 1-based line number
	local end_line = end_mark[1] -- 1-based line number

	-- Ensure start_line is not greater than end_line (selection can be made upwards)
	if start_line > end_line then
		start_line, end_line = end_line, start_line -- Swap them
	end

	-- Get the content of the selected lines.
	-- vim.api.nvim_buf_get_lines is 0-indexed for lines.
	local selected_lines_table = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local selected_content = table.concat(selected_lines_table, "\n")

	-- Create the reference string (e.g., filepath:10 or filepath:10-12)
	local reference_path_with_lines
	if start_line == end_line then
		reference_path_with_lines = filepath .. ":" .. start_line
	else
		reference_path_with_lines = filepath .. ":" .. start_line .. "-" .. end_line
	end

	-- Format the final string, consistent with other yank functions
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
