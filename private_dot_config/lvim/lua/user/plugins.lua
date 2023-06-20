lvim.plugins = {
	-- themes
	"Mofiqul/dracula.nvim",
	"ChristianChiarulli/onedark.nvim",

	-- Symbol Outline
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				autofold_depth = 1,
			})
		end,
	},

	-- Line Wrapping
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},

	-- Definition preview
	"dnlhc/glance.nvim",

	-- Multicursor (ctrl up/down, ctrl-N)
	-- Ctrl Mouse Click
	-- \\ = leader
	-- \\\ = add cursor at position
	-- \\-A = Select all cwords in the file and create a cursor for it
	-- \\-/ = regex search adding cursor for matches
	-- \\-\ = cursor at position
	-- C-N + S-S" (add surround)
	-- C-Up-Down + \\-< + (char)  = align
	-- C-Up-Down + \\-0n (\\-N or \\-n) = Append numbers starting on 0
	-- select `sep`(:) - C-N - (multi cursor on all) -
	--                  \\-a (align)
	--                  \\-d (duplicate)
	--                  \\-C (case conversion)
	-- C-Down - f: (find `:`) - \\a (align)
	-- \\-` = tools menu
	-- C-N - mii - c (select, match inner function, change)
	-- "mg979/vim-visual-multi",

	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",

	-- Group all the problems in a quick fix list (leader-zz)
	-- https://github.com/folke/trouble.nvim
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({
				action_keys = {
					toggle_fold = { "h", "l" },
				},
			})
		end,
	},

	-- highlight TODO:comments
	"folke/todo-comments.nvim",

	-- Surrounds
	--    Old text                    Command         New text
	--------------------------------------------------------------------------------
	-- surr*ound_words             ysiw)           (surround_words)
	-- *make strings               ys$"            "make strings"
	-- [delete ar*ound me!]        ds]             delete around me!
	-- remove <b>HTML t*ags</b>    dst             remove HTML tags
	-- 'change quot*es'            cs'"            "change quotes"
	-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
	-- delete(functi*on calls)     dsf             function calls
	--
	-- S for visualMode
	-- more here: https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- python debugger
	"mfussenegger/nvim-dap-python",

	-- Maximizer (it can be done with C-w | and C-w _ and Ctrl w =)
	-- Other option is opening in a new tab with C-w T
	-- Another useful tip is :tabedit % (to maximize) :tabclose (to get back)
	-- but this plugin remembers the size of multiple windows
	-- <C-w>m or F3
	-- "szw/vim-maximizer",

	-- Persist sessions
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup({
				use_git_branch = true,
				autoload = true,
			})
		end,
	},

	-- :ZenMode for writing
	-- "folke/zen-mode.nvim",

	-- Internal scrollbar
	"petertriho/nvim-scrollbar",

	-- Search and Replace across all files
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup({
				live_update = true,
				is_insert_mode = true,
			})
		end,
	},

	-- HTTP REST client
	-- https://github.com/rest-nvim/rest.nvim
	"rest-nvim/rest.nvim",

	-- Better input popups and UI
	-- "stevearc/dressing.nvim",

	-- File operations like `<l>gd` (duplicate file)
	{
		"chrisgrieser/nvim-genghis",
		dependencies = {
			"stevearc/dressing.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-omni",
		},
	},

	-- A Vim wrapper for running tests on different granularities.
	-- https://github.com/vim-test/vim-test
	"vim-test/vim-test",

	-- https://github.com/AckslD/swenv.nvim
	-- automatic venv for python
	{
		"AckslD/swenv.nvim",
		config = function()
			require("swenv").setup({
				venvs_path = vim.fn.expand("."),
			})
		end,
	},
}
