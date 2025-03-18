local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"ts_ls",
	"rust_analyzer",
	"elixirls",
	"clangd",
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- Common LSP Keybindings
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)

	-- Format on save using conform.nvim
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("ConformFormatting", { clear = false }),
		buffer = bufnr,
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})

	-- Language-specific modifications
	if client.name == "elixirls" then
		client.server_capabilities.documentFormattingProvider = false
	elseif client.name == "clangd" then
		client.server_capabilities.documentFormattingProvider = false
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.cmd("silent! !clang-format -i " .. vim.fn.expand("%"))
			end,
		})
	end
end

lsp.configure("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.configure("elixirls", {
	cmd = { "/home/ron.debenedetti/.nix-profile/bin/elixir-ls" },
	capabilities = capabilities,
	root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			fetchDeps = false,
			mixEnv = "dev",
		},
	},
	on_attach = on_attach,
})

lsp.configure("rust_analyzer", {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = { command = "clippy" },
			cargo = { allFeatures = true },
			diagnostics = { enable = true },
		},
	},
})

lsp.configure("tsserver", {
	cmd = { "pnpm", "exec", "typescript-language-server", "--stdio" },
	root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
	on_attach = on_attach,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.setup_nvim_cmp({
	mapping = lsp.defaults.cmp_mappings({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	}),
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	on_attach(client, bufnr)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
