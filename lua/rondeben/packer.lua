-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
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

	-- use { "loctvl842/monokai-pro.nvim", config = function()
	--     require("monokai-pro").setup()
	-- end }

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
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
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" }, -- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use("folke/zen-mode.nvim")
	-- use("github/copilot.vim")
	use("eandrju/cellular-automaton.nvim")
	use("laytan/cloak.nvim")

	--     -- used for formatting on save
	--     use('jose-elias-alvarez/null-ls.nvim')

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
	use("lukas-reineke/lsp-format.nvim")

	use("nvim-tree/nvim-web-devicons")

	use({
		"nvim-lualine/lualine.nvim",
		-- requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- assuming you meant this devicons plugin
		-- config = function()
		--     require('lualine').setup {
		--         -- your lualine config here
		--     }
		-- end
	})

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
		-- optional lazy-loading below
		-- module = {
		--     'rainbow_csv',
		--     'rainbow_csv.fns'
		-- },
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

	-- Add YAML plugins
	-- use 'nvim-treesitter/nvim-treesitter-textobjects'
	-- use 'nvim-treesitter/nvim-treesitter-refactor'
	-- use 'nvim-treesitter/nvim-treesitter-highlight'
	-- use 'vim-scripts/yaml.vim'
	use("lukas-reineke/indent-blankline.nvim")

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
				-- keymaps = {
				-- 	["<CR>"] = "actions.select", -- Open file or directory
				-- 	["<C-s>"] = "actions.select_vsplit", -- Open in vertical split
				-- 	["<C-h>"] = "actions.select_split", -- Open in horizontal split
				-- 	["<C-t>"] = "actions.select_tab", -- Open in new tab
				-- 	["-"] = "actions.parent", -- Go to parent directory
				-- 	["<C-c>"] = "actions.close", -- Close Oil buffer
				-- 	["<C-l>"] = "actions.refresh", -- Refresh the directory
				-- 	["g?"] = "actions.show_help", -- Show help
				-- },
				-- use_default_keymaps = false, -- Disable default keymaps
                skip_confirm_for_simple_edits = true,
			})
		end,
	})
end)
