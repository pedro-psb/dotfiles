-- doesnt work

--
lvim.leader = "space"

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.keymap.set({ 'x', 'v', 'i', 'n' }, "<C-s>", '<cmd>w<cr>') -- save
lvim.keys.normal_mode["<C-w>"] = ":BufferKill<CR>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- lvim.keys.normal_mode["w"] = "<C-c>vw"

-- Trying to get sane copy/paste over
vim.keymap.set({ "x", "v" }, "p", '"_dP')

-- Remove the Ctrl-\ for terminal
-- lvim.builtin.terminal.open_mapping = "<c-t>"

-- Disables
lvim.keys.term_mode = {
  ['<C-l>'] = false,
  ['<C-h>'] = false
}

vim.keymap.set({ 'x', 'v', 'i', 'n' }, "<C-z>", '') -- disable accidental stopping lvim
-- vim.keymap.set({ 'x', 'v', 'i', 'n' }, "<C-,>", '<Space>Lc') -- open config file (remmap)

-- Visual Split Plugin
-- vim.keymap.set({ "v", "n", "x" }, "<C-w>gr", [[<cmd>'<,'>VSResize<cr>]], { remap = true })
-- vim.keymap.set({ "v", "n", "x" }, "<C-w>gss", [[<cmd>'<,'>VSSplit<cr>]], { remap = true })
-- vim.keymap.set({ "v", "n", "x" }, "<C-w>gsa", [[<cmd>'<,'>VSSplitAbove<cr>]], { remap = true })
-- vim.keymap.set({ "v", "n", "x" }, "<C-w>gsb", [[<cmd>'<,'>VSSplitBelow<cr>]], { remap = true })


-- Change Telescope navigation to use j and k for navigation
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}


-- WhichKey

-- Disables
lvim.builtin.which_key.mappings['p'] = {}
lvim.builtin.which_key.mappings['T'] = {}
lvim.builtin.which_key.mappings['w'] = {}
lvim.builtin.which_key.mappings[';'] = {}

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" } -- Open Projects
lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<CR>", "Symbol Outline" } -- Symbol Outline window

-- Debug
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
  O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
  l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
  u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
  x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
}

-- Spectre Find/Replace
lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Cursor Word" },
}

lvim.builtin.which_key.mappings["d"] = {
  name = "+Diagnostic",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  -- t = { "<cmd>ToggleTermToggleAll<cr>", "Term Toggle" }
  t = { "<cmd>TroubleToggle<cr>", "Toggle" }
}

lvim.builtin.which_key.mappings["q"] = {
  name = "Restore",
  q = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "Quit" },
  s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore pwd session" },
  l = { [[<cmd>lua require("persistence").load({ last = true })<cr>]], "Last Session" },
  d = { [[<cmd>lua require("persistence").stop()<cr>]], "Dont save current session" }
}

lvim.builtin.which_key.mappings["g"] = {
  name = "Genghis File Operations",
  n = { "<cmd>lua require('genghis').createNewFile()<cr>", "New File" },
  r = { "<cmd>lua require('genghis').renameFile()<cr>", "Rename File" },
  p = { "<cmd>lua require('genghis').copyFilepath()<cr>", "Copy File Path" },
  N = { "<cmd>lua require('genghis').copyFilename()<cr>", "Copy File Name" },
  x = { "<cmd>lua require('genghis').chmodx()<cr>", "chmod x" },
  m = { "<cmd>lua require('genghis').moveAndRenameFile()<cr>", "Move and Rename" },
  d = { "<cmd>lua require('genghis').duplicateFile()<cr>", "Duplicate File" },
  s = { "<cmd>lua require('genghis').moveSelectionToNewFile()<cr>", "Move Selection to New File" },
  X = { "<cmd>lua require('genghis').trashFile()<cr>", "Delete File" },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  t = { "<cmd>TestNearest<cr>", "Nearest" },
  c = { "<cmd>TestClass<cr>", "Test Class" },
  f = { "<cmd>TestFile<cr>", "Test File" },
  a = { "<cmd>TestSuite<cr>", "Test Suite" },
  l = { "<cmd>TestLast<cr>", "Last run" },
  g = { "<cmd>TestVisit<cr>", "Go to test file" },
}

lvim.builtin.which_key.mappings["V"] = { "<cmd>lua require('swenv.api').pick_venv()<CR>", "Pick venv" }

-- nmap <silent> <leader>t :TestNearest<CR>
-- nmap <silent> <leader>T :TestFile<CR>
-- nmap <silent> <leader>a :TestSuite<CR>
-- nmap <silent> <leader>l :TestLast<CR>
-- nmap <silent> <leader>g :TestVisit<CR>

-- lvim.builtin.which_key.mappings["x"] = {
--   name = "Rest",
--   r = { "<cmd>lua require'rest-nvim'.run(false)<cr>", "Run" },
--   p = { "<cmd>lua require'rest-nvim'.run(true)<cr>", "Preview" },
--   a = { "<cmd>lua require'rest-nvim'.last()<cr>", "Last Request" },
--   o = { "<cmd>lua require('user.functions').open_rest_nvim_file()<cr>", "Open rest file" }
-- }
