-- Initialize Mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "efm", "elixirls" }, -- Ensure efm is installed
})

-- LSP Configuration
local lspconfig = require("lspconfig")

-- Define the Efm configuration
local efm_config = {
	init_options = { documentFormatting = true, codeAction = true },
	filetypes = { "lua", "javascript", "typescript", "rust", "nix", "yaml", "sql", "json", "elixir" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			lua = {
				{
					formatCommand = "stylua -",
					formatStdin = true,
				},
			},
			javascript = {
				{
					lintCommand = "pnpm exec eslint_d --stdin --stdin-filename ${INPUT} --format json",
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %m" },
				},
				{
					formatCommand = "pnpm exec prettier --stdin-filepath ${INPUT}",
					formatStdin = true,
				},
			},
			typescript = {
				{
					lintCommand = "pnpm exec eslint_d --stdin --stdin-filename ${INPUT} --format json",
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %m" },
				},
				{
					formatCommand = "pnpm exec prettier --stdin-filepath ${INPUT}",
					formatStdin = true,
				},
			},
			rust = {
				{
					formatCommand = "rustfmt",
					formatStdin = true,
				},
				{
					lintCommand = "clippy",
					lintStdin = true,
				},
			},
			nix = {
				{
					formatCommand = "nixfmt",
					formatStdin = true,
				},
			},
			yaml = {
				{
					formatCommand = "yamlfmt",
					formatStdin = true,
				},
				{
					lintCommand = "yamllint",
					lintStdin = true,
				},
			},
			sql = {
				{
					formatCommand = "sqlfluff fix --dialect postgres -",
					formatStdin = true,
				},
				{
					lintCommand = "sqlfluff lint --dialect postgres --disable_progress_bar",
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %m" },
				},
			},
			json = {
				{
					formatCommand = "prettier --stdin-filepath ${INPUT}",
					formatStdin = true,
				},
			},
			elixir = {
				{
					formatCommand = "mix format -",
					formatStdin = true,
				},
				{
					lintCommand = "mix credo suggest --format=oneline --read-from-stdin",
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %m" },
				},
			},
		},
	},
}

-- Setup Efm
lspconfig.efm.setup(efm_config)
