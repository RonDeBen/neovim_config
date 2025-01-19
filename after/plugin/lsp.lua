local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"ts_ls",
	"rust_analyzer",
	"elixirls",
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)

		-- Disable ElixirLS formatting to let conform handle it
		client.server_capabilities.documentFormattingProvider = false
	end,
})

-- Fix Undefined global 'vim'
lsp.configure("lua-language-server", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.configure("ts_ls", { -- updated from 'tsserver'
	cmd = { "pnpm", "exec", "typescript-language-server", "--stdio" },
	root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
})

local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
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
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
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

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- LSP-related keymaps
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

	-- Format on save using conform
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("ConformFormatting", { clear = false }),
		buffer = bufnr,
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})
end

-- Update your LSP setup to include on_attach
require("lsp-zero").on_attach(function(client, bufnr)
	on_attach(client, bufnr)
end)

lsp.on_attach(function(client, bufnr)
	on_attach(client, bufnr)

	--automatically picks servers for formatting
	-- lsp.buffer_autoformat()
	-- lsp.require("lsp-format").on_attach(client)
end)

--lsp.setup_servers({ 'eslint' })

lsp.skip_server_setup({ "rust-analyzer" })

lsp.setup()

local function rust_on_attach(client, bufnr)
	on_attach(client, bufnr) -- Call the common on_attach function

	vim.cmd([[
        augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost <buffer> lua vim.lsp.buf.format()
        augroup END
    ]])
end

local opts = {
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		on_attach = rust_on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
				cargo = {
					allFeatures = true,
				},
			},
		},
	},
}

require("rust-tools").setup(opts)

vim.diagnostic.config({
	virtual_text = true,
	-- signs = true,
	-- underline = true,
	-- update_in_insert = false,
})
