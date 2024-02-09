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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
