-- This file replaces your previous packer.lua
return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Monokai theme
	{
		"tanvirtin/monokai.nvim",
		config = function()
			require("monokai").setup({
				palette = require("monokai").pro,
			})
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- 'run' in Packer becomes 'build' in Lazy
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-context",

	-- ThePrimeagen plugins
	"theprimeagen/harpoon",
	"theprimeagen/refactoring.nvim",

	-- Utils
	"mbbill/undotree",
	"tpope/vim-fugitive",

	-- LSP setup
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",

			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- Focus mode
	"folke/zen-mode.nvim",

	-- Fun
	"eandrju/cellular-automaton.nvim",

	-- Secret hiding
	"laytan/cloak.nvim",

	-- Auto-pairing
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Rust
	"simrat39/rust-tools.nvim",

	-- UI
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"vimpostor/vim-tpipeline",

	-- Comments
	"tpope/vim-commentary",

	-- Todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- CSV handling
	{
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
	},

	-- Database
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",

	-- Open in web
	"rondeben/webify.nvim",

	-- Oil file explorer
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {
					"icon",
				},
				view_options = {
					show_hidden = true,
				},
				skip_confirm_for_simple_edits = true,
			})
		end,
	},

	-- Linting and formatting
	"mfussenegger/nvim-lint",
	"stevearc/conform.nvim",

	-- You can add any other plugins you were using here
}
