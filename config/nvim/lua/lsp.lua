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

require("arm_intrinsic_lsp")
lspconfig.armlsp.setup({})

local rt = require("rust-tools")

rt.setup()

vim.keymap.set("n", "<Space>d", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
