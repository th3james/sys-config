local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

local null_ls = require("null-ls")

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
					local handle = io.popen("npx which eslint")
					local result = handle:read("*a") -- read the output of the command
					handle:close()
					result = result:gsub("%s+", "") -- remove trailing newline
					return result
				end,
			}),
		},
	})
else
	print("Could not find null-ls")
	return nil
end
