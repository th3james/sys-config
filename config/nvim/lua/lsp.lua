local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

local null_ls = require("null-ls")

local find_local = require("find_local")

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
					return find_local.get_npx_path("eslint")
				end,
			}),
			null_ls.builtins.formatting.eslint.with({
				command = function(params)
					return find_local.get_npx_path("eslint")
				end,
			}),
			null_ls.builtins.formatting.black.with({
				command = function(params)
					return find_local.get_venv_path("black")
				end,
			}),
			null_ls.builtins.diagnostics.ruff,
			null_ls.builtins.diagnostics.mypy.with({
				command = function(params)
					return find_local.get_venv_path("mypy")
				end,
			}),
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.goimports,
			null_ls.builtins.diagnostics.golangci_lint,
			null_ls.builtins.formatting.jq,
			null_ls.builtins.formatting.terraform_fmt,
			null_ls.builtins.formatting.cljstyle,
			null_ls.builtins.diagnostics.clj_kondo,
			null_ls.builtins.formatting.fnlfmt,
		},
	})
else
	print("Could not find null-ls")
	return nil
end

lspconfig.tsserver.setup({})
lspconfig.terraformls.setup({})
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})

local rt = require("rust-tools")

rt.setup()
