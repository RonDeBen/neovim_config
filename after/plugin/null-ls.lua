--https://github.com/jose-elias-alvarez/null-ls.nvim
--https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	--[[ formatting ]]
	formatting.stylua,
	formatting.eslint_d.with({
		command = "pnpm",
		args = { "exec", "eslint_d", "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
		cwd = function(params)
			return require("lspconfig").util.root_pattern("package.json")(params.bufname)
		end,
	}),
	formatting.prettier.with({
		command = "pnpm",
		args = { "exec", "prettier", "--stdin-filepath", "$FILENAME" },
	}),
    formatting.taplo,
	-- formatting.rustfmt,
	formatting.nixfmt,
	formatting.yamlfmt,
	formatting.sqlfluff.with({
		extra_args = { "--dialect", "postgres" },
	}),
	--TODO: Add dprint for speed
	--formatting.dprint,

	--[[ code actions ]]
	code_actions.eslint_d.with({
		command = "pnpm",
		args = { "exec", "eslint_d", "--stdin", "--stdin-filename", "$FILENAME" },
	}),
	code_actions.statix,

	--[[ diagnostics ]]
	-- diagnostics.eslint_d.with({
	--     command = "pnpm",
	--     args = { "exec", "eslint_d", "--stdin", "--stdin-filename", "$FILENAME" },
	-- }),
	diagnostics.eslint_d.with({
		command = "pnpm",
		args = { "exec", "eslint_d", "--stdin", "--stdin-filename", "$FILENAME", "--format=json" },
	}),
	diagnostics.statix,
	diagnostics.yamllint,
}

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
