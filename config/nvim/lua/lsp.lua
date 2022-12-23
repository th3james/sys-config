local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

local null_ls = require("null-ls")

local trim_whitespace = function(str)
	return str:gsub("^%s*(.-)%s*$", "%1")
end

local get_npx_path = function(executable_name)
	return trim_whitespace(vim.fn.system("npx which " .. executable_name))
end

if null_ls then
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.luacheck.with({
				args = {
					"--formatter",
					"plain",
					"--codes",
					"--ranges",
					"--filename",
					"$FILENAME",
					"-",
					"--globals",
					"vim",
				},
			}),
			null_ls.builtins.diagnostics.eslint.with({
				command = function(params)
					return get_npx_path("eslint")
				end,
			}),
			null_ls.builtins.diagnostics.ruff,
		},
	})
else
	print("Could not find null-ls")
	return nil
end
