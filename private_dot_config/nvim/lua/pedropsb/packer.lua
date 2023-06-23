-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use({
		"Mofiqul/dracula.nvim",
		as = "dracula",
		-- config = function()
		-- 	vim.cmd("colorscheme dracula")
		-- end,
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	-- lsp setup
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{
				"neovim/nvim-lspconfig",
			},
			{ -- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "onsails/lspkind.nvim" }, -- Optional
		},

		-- https://github.com/jose-elias-alvarez/null-ls.nvim
		-- :h
		use({ "jose-elias-alvarez/null-ls.nvim" }),
		use({ "jay-babu/mason-null-ls.nvim" }),
	})

	-- use({ "AckslD/swenv.nvim" }) -- python venv

	-- https://github.com/numToStr/Comment.nvim
	-- :h comment-nvim
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- https://github.com/Dkendal/nvim-minor-mode
	-- :h ?
	use({ "Dkendal/nvim-minor-mode" })

	-- https://github.com/stevearc/dressing.nvim
	-- :h dressing-format | dressing_get_config
	use({ "stevearc/dressing.nvim" })

	-- https://github.com/akinsho/bufferline.nvim
	-- :h bufferline-[styling | hover-events | highlights]
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- https://github.com/stevearc/oil.nvim
	-- :h oil-columns | oil-actions
	-- use({
	-- 	"stevearc/oil.nvim",
	-- 	config = function()
	-- 		require("oil").setup()
	-- 	end,
	-- })

	-- https://github.com/folke/zen-mode.nvim
	-- :h ?
	use({ "folke/zen-mode.nvim" })

	-- https://github.com/nvim-tree/nvim-tree.lua
	-- :h nvim-tree[ -mappings | -setup | .CONFIG_NAME ]
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})

	-- https://github.com/nvim-tree/nvim-tree.lua
	-- :h nvim-tree[ -mappings | -setup | .CONFIG_NAME ]
	use({ "folke/lsp-trouble.nvim", requires = "nvim-tree/nvim-web-devicons" })

	-- https://github.com/rmagatti/auto-session
	-- :h
	-- use({
	-- 	"rmagatti/auto-session",
	-- 	config = function()
	-- 		require("auto-session").setup({
	-- 			log_level = "error",
	-- 			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	-- 		})
	-- 	end,
	-- })

	-- https://github.com/famiu/bufdelete.nvim
	-- :h
	use("famiu/bufdelete.nvim")
	use("simrat39/symbols-outline.nvim")
	-- Lua
	use({ "folke/twilight.nvim" })
end)
