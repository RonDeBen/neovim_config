require("conform").setup({
	formatters_by_ft = {
		-- Formatters for specific filetypes
		elixir = { "mix_format" }, -- Elixir formatter
		lua = { "stylua" }, -- Lua formatter
		json = { "prettier_pnpm" }, -- JSON formatter with pnpm prettier
		yaml = { "yamlfmt", "prettier_pnpm", stop_after_first = true }, -- YAML formatter
		typescript = { "prettierd", "eslint_d", stop_after_first = true }, -- TypeScript
		javascript = { "prettierd", "eslint_d", stop_after_first = true }, -- JavaScript
		rust = { "rustfmt" }, -- Rust formatter
		toml = { "taplo" }, -- TOML formatter
		sql = { "pgformatter" }, -- Postgres SQL formatter
		sh = { "shfmt" }, -- Shell script formatter
		nix = { "nixfmt" }, -- Nix formatter
		css = { "prettier_pnpm" }, -- Tailwind/CSS formatter
	},

	-- Automatically format files on save
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback", -- Use LSP formatting if no conform formatter exists
	},

	-- Custom formatter definitions for special cases
	formatters = {
		prettier_pnpm = {
			cmd = "pnpm",
			args = { "exec", "prettier", "--stdin-filepath", "%filepath" },
			stdin = true,
		},
	},
})

-- Use Conform's formatexpr for manual formatting
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Keybinding to format on demand
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Format file with Conform" })
