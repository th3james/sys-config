local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

lspconfig.tsserver.setup({})
-- lspconfig.terraformls.setup({})
lspconfig.clangd.setup({})
lspconfig.gopls.setup({})
-- brew install vscode-langservers-extracted
lspconfig.jsonls.setup({
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
lspconfig.pyright.setup({})
-- brew install yaml-language-server
lspconfig.yamlls.setup({
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
lspconfig.zls.setup({})

-- local rt = require("rust-tools")

-- rt.setup()

vim.keymap.set("n", "<Space>ld", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.keymap.set("n", "<Space>lf", function()
	vim.lsp.buf.format({
		timeout_ms = 10000,
		filter = function(client)
			return client.name ~= "tsserver"
		end, -- don't format with tsserver
	})
end, {})
vim.keymap.set("n", "<Space>lh", vim.lsp.buf.hover, {})
