-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"tanvirtin/monokai.nvim",
		config = function()
			require("monokai").setup({
				palette = require("monokai").pro,
			})
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("theprimeagen/refactoring.nvim")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("nvim-treesitter/nvim-treesitter-context")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = { -- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/vim-vsnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" }, -- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use("folke/zen-mode.nvim")
	use("eandrju/cellular-automaton.nvim")
	use("laytan/cloak.nvim")

	-- add matching pairs <>, (), {}, []
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Adds extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")

	-- attempt to use prettier for formatting
	-- use("lukas-reineke/lsp-format.nvim")

	use("nvim-tree/nvim-web-devicons")

	use("nvim-lualine/lualine.nvim")

	-- pipes nvim into tmux to combine status bars
	use("vimpostor/vim-tpipeline")

	use("tpope/vim-commentary")

	--https://github.com/folke/todo-comments.nvim
	--highlights todo comments
	use({ "folke/todo-comments.nvim", requires = { "nvim-lua/plenary.nvim" } })

	use({
		"cameron-wags/rainbow_csv.nvim",
		config = function()
			require("rainbow_csv").setup()
		end,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
	})

	-- database management in vim!!
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")

	-- Open current file in gitlab/github
	use("rondeben/webify.nvim")

	-- Manage filesystem with vim-like actions
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				default_file_explorer = true, -- Use oil.nvim as the default file explorer
				columns = {
					"icon", -- Show file icons
				},
				view_options = {
					show_hidden = true, -- Show hidden files
				},
				skip_confirm_for_simple_edits = true,
			})
		end,
	})

	use("mfussenegger/nvim-lint")
	use("stevearc/conform.nvim")
end)
