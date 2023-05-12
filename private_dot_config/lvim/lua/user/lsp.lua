-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua" },
  { command = "shfmt", filetypes = { "bash" } },
  { command = "isort", filetypes = { "python" } },
  { command = "black", filetypes = { "python" } },
  { command = "remark", filetypes = { "markdown" } },
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact", "html" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  -- { command = "mypy", filetypes = { "python" } },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
}
