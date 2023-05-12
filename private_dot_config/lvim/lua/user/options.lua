-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
lvim.opt.relativenumber = false

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  timeout = 1000,
}

-- lvim.builtin.project.exclude_dirs = { 'node_modules/*', "venv/*", ".venv/*" }
-- lvim.builtin.project.patterns = { '!venv/*', "!.venv/*" }
-- lvim.builtin.telescope.defaults.file_ignore_patterns { 'venv/*', '.venv/*'}
