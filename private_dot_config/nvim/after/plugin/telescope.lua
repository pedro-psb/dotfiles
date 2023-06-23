local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>tt", function()
	local ok, _ = pcall(builtin.git_files)
	if not ok then
		builtin.find_files()
	end
end, {})

vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>ti", builtin.git_files, {})
vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
vim.keymap.set("n", "<leader>tb", builtin.buffers, {})

vim.keymap.set("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>sf", builtin.lsp_document_symbols, {})

-- vim.keymap.set('n', '<leader>ts', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
