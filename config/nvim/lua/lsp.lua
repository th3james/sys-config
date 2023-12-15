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
