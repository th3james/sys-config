local lint = require('lint')

lint.linters_by_ft = {
  lua = {'luacheck',}
}

local luacheck = lint.linters.luacheck
luacheck.args = {
  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "--filename",
  "$FILENAME",
  "-",
  "--globals",
  "vim",
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
