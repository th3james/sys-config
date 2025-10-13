vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")

-- brew install vscode-langservers-extracted
vim.lsp.config("jsonls", {
	json = {
		schemas = {
			{
				fileMatch = { "package.json" },
				url = "https://json.schemastore.org/package.json",
			},
			{
				fileMatch = { "tsconfig*.json" },
				url = "https://json.schemastore.org/tsconfig.json",
			},
			{
				fileMatch = { ".eslintrc", ".eslintrc.json" },
				url = "https://json.schemastore.org/eslintrc.json",
			},
		},
	},
})
vim.lsp.enable("jsonls")

vim.lsp.enable("basedpyright")
-- brew install terraform-ls
vim.lsp.enable("terraformls")
-- brew install yaml-language-server
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			validate = true,
			-- disable the schema store
			schemaStore = {
				enable = false,
				url = "",
			},
			-- manually select schemas
			-- source: https://www.schemastore.org/api/json/catalog.json
			schemas = {
				["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
				["https://json.schemastore.org/dependabot-2.0.json"] = "dependabot*.{yml,yaml}",
				["https://json.schemastore.org/github-action.json"] = "actions*.{yml,yaml}",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
})
vim.lsp.enable("yamlls")
vim.lsp.enable("zls")

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

vim.keymap.set("n", "<Space>ld", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.keymap.set("n", "<Space>lf", function()
	vim.lsp.buf.format({
		timeout_ms = 10000,
		filter = function(client)
			return client.name ~= "tsserver"
		end, -- don't format with tsserver
	})
end, {})
vim.keymap.set("n", "<Space>lr", vim.lsp.buf.rename, {})
