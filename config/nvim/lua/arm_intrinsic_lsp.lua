local configs = require("lspconfig.configs")

local server_name = "armlsp"

-- Check if it's already defined for some reason
if not configs[server_name] then
	configs[server_name] = {
		default_config = {
			cmd = { "node", "/Users/jamcox01/src/vscode-arm-lsp/dist/desktop-server.js", "--stdio" },
			filetypes = { "c", "cpp" },
			settings = {},
			root_dir = vim.loop.cwd,
		},
	}
end
