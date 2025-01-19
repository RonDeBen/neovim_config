require("lint").linters.eslint_d = {
	cmd = "pnpm",
	args = { "exec", "eslint_d", "--stdin", "--stdin-filename", "%filepath" },
	stdin = true,
}

require("lint").linters_by_ft = {
	elixir = { "credo" }, -- Use credo for Elixir
	lua = { "luacheck" }, -- Default luacheck
	json = { "eslint_d" }, -- ESLint for JSON
	javascript = { "eslint_d" }, -- ESLint for JavaScript
	typescript = { "eslint_d" }, -- ESLint for TypeScript
	yaml = { "yamllint" }, -- Yamllint
	sql = { "sqlfluff" }, -- SQLFluff for SQL files
	nix = { "statix" }, -- Statix for Nix files
}

-- Trigger linting on save or read
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	pattern = "*.lua,*.js,*.ts,*.json,*.yaml,*.sql,*.ex,*.exs",
	callback = function()
		require("lint").try_lint()
	end,
})
