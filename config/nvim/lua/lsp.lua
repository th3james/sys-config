local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

lspconfig.tsserver.setup({})
-- lspconfig.terraformls.setup({})
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})
lspconfig.zls.setup({})

local rt = require("rust-tools")

rt.setup()

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
