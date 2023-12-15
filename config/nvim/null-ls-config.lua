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
			command = local_tools.eslint,
		}),
		null_ls.builtins.formatting.eslint.with({
			command = local_tools.eslint,
		}),
		null_ls.builtins.formatting.black.with({
			command = local_tools.black,
		}),
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.mypy.with({
			command = local_tools.mypy,
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
