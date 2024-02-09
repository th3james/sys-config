local lint = require("lint")

lint.linters_by_ft = {
	c = { "cppcheck" },
	cpp = { "cppcheck" },
	clojure = { "clj-kondo" },
	lua = { "luacheck" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

local luacheck = lint.linters.luacheck
luacheck.args = {
	"--formatter",
	"plain",
	"--codes",
	"--ranges",
	"--filename",
	"$FILENAME",
	"-",
	"--globals",
	"vim",
}

local cppcheck = lint.linters.cppcheck
-- https://github.com/mfussenegger/nvim-lint/issues/492
cppcheck.args = {
	"--enable=warning,style,performance,information",
	function()
		if vim.bo.filetype == "cpp" then
			return "--language=c++"
		else
			return "--language=c"
		end
	end,
	"--inline-suppr",
	"--quiet",
	function()
		if vim.fn.isdirectory("build") == 1 then
			return "--cppcheck-build-dir=build"
		else
			return ""
		end
	end,
	"--template={file}:{line}:{column}: [{id}] {severity}: {message}",
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
