local lspconfig = require("lspconfig")

if not lspconfig then
	print("Could not find lspconfig")
	return nil
end

local null_ls = require("null-ls")

local log_warning = function(msg)
	vim.notify("[th3james config] " .. msg, vim.log.levels.WARN)
end

local trim_whitespace = function(str)
	return str:gsub("^%s*(.-)%s*$", "%1")
end

local get_npx_path = function(executable_name)
	local npx_path = vim.fn.system("npx which " .. executable_name)
	if npx_path == "" then
		log_warning("Could not find " .. executable_name .. " in npx, falling back to global")
		return executable_name
	else
		return trim_whitespace(npx_path)
	end
end

local get_venv_path = function(executable_name)
	local executable_path = vim.fn.system("veex which " .. executable_name)
	if executable_path == "" then
		log_warning("Could not find " .. executable_name .. " in virtual environment, will try system path")
		return executable_name
	else
		return trim_whitespace(executable_path)
	end
end

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
					return get_npx_path("eslint")
				end,
			}),
			null_ls.builtins.formatting.eslint.with({
				command = function(params)
					return get_npx_path("eslint")
				end,
			}),
			null_ls.builtins.formatting.black.with({
				command = function(params)
					return get_venv_path("black")
				end,
			}),
			null_ls.builtins.diagnostics.ruff,
			null_ls.builtins.diagnostics.mypy.with({
				command = function(params)
					return get_venv_path("mypy")
				end,
			}),
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.goimports,
			null_ls.builtins.diagnostics.golangci_lint,
			null_ls.builtins.formatting.jq,
		},
	})
else
	print("Could not find null-ls")
	return nil
end

local rt = require("rust-tools")

rt.setup()
