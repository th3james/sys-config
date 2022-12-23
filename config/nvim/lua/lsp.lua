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
				args = { "--formatter", "plain", "--codes", "--ranges", "--filename", "$FILENAME", "-" , "--globals", "vim" },
			}),
		},
	})
else
	print("Could not find null-ls")
	return nil
end
