-- :help vim.lsp.start_client() -> setup config table

-- PYTHON VENV config
-- test

-- local swenv = require("swenv")
-- swenv.setup({
--     venvs_path = require("plenary.path"):new("."):absolute(),
--     post_set_env = function(args)
--         print("activated", vim.inspect(args))
--         vim.cmd("LspRestart")
--     end,
-- })

local lsp = require("lsp-zero")

lsp.preset("recommended")

-- LANGUAGE SERVERS
-- for format/lint use null-ls setup

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"bashls",
	"rust_analyzer",
	"pyright",
	"yamlls",
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
require("lspconfig").pyright.setup(require("lang.python").lspconfig)

lsp.set_preferences({
	sign_icons = {},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>ls", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>la", function() -- lsp actions
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>lsr", function() -- lsp show ref
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>lr", function() -- lsp rename
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "lss", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

-- PYTHON VENV
-- workaround to activate venv (currently using swenv)
-- see: https://github.com/neovim/nvim-lspconfig/issues/500
-- see: https://github.com/VonHeikemen/lsp-zero.nvim/issues/195
-- see: https://github.com/microsoft/pyright/blob/fb62cc9bf835f0ca02d7a2ff925878b191c866c4/docs/import-resolution.md

-- config cmp
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-l>"] = cmp.mapping.confirm({ select = true }),
	["<Enter>"] = cmp.mapping.confirm({ select = true }),
	-- tab as enter instead of select
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then -- `true` when cmp completion window has appeared
			return cmp.confirm({ select = true })
		end
		return cmp.complete()
	end, { "i", "s" }),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	}),
})

lsp.setup()

-- FORMATTING/LINTING (null-ls)
-- there are used by langauge servers
--
-- avaliable sources:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
--
-- see later:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

mason_null_ls.setup({
	ensure_installed = {
		"ruff",
		"black",
		"mypy",
		"isort",
		"shellcheck",
		"stylua",
		"prettierd",
		"shfmt",
		"markdownlint",
		"yamlls",
	},
	automatic_installation = false,
	handler = {},
})

-- TODO see how to bound servers with specific filetypes only
-- TODO see how to set tools usage order as:
-- * venv path (probably ./venv or ./.venv), but could be others
-- * mason managed path: ~/.local/share/nvim/mason/packages
null_ls.setup({
	sources = {
		-- python
		formatting.black,
		formatting.isort,
		diagnostics.ruff,
		diagnostics.mypy.with({
			prefer_local = ".venv/bin",
		}),
		-- http://www.pydocstyle.org/en/stable/ -- static analysis tool for checking compliance with Python docstring conventions.
		-- https://pypi.org/project/pyment/ -- Create, update or convert docstrings in existing Python files, managing several styles.

		-- shell
		diagnostics.shellcheck,
		formatting.shfmt, -- shellharden would not install

		-- lua
		formatting.stylua,

		-- js/ts
		formatting.prettierd,

		-- markdown
		diagnostics.markdownlint,
		formatting.markdownlint,

		-- yaml
	},
})

-- FILETYPE ADDITIONAL CONFIG
-- config related to the editor (not directly lsp)
-- TODO add ftplugin

local filetype_group = vim.api.nvim_create_augroup("filetype_configs", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html,markdown",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
	group = filetype_group,
})

-- fix for weird indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "let g:pyindent_open_paren = shiftwidth()",
	group = filetype_group,
})
