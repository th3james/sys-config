-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- jk instead of esc
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
-- colemak alternative
vim.keymap.set("i", "uu", "<Esc>", { noremap = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Space>ff", builtin.find_files, {})
vim.keymap.set("n", "<Space>fF", function()
	builtin.find_files({ hidden = true })
end, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fG", function()
	builtin.live_grep({ hidden = true })
end, {})
vim.keymap.set("n", "<Space>fb", builtin.buffers, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})
vim.keymap.set("n", "<Space>fd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<Space>fr", builtin.lsp_references, {})
vim.keymap.set("n", "<Space>fe", builtin.diagnostics, {})
