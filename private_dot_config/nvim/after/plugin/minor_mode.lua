local define_minor_mode = require('minor-mode').define_minor_mode


opts = {}
define_minor_mode('pitch', [[ enter pitch names ]], {
	command = 'PitchMode',
	keymap = {
	    { 'n', 'a', "<Append>c<Esc>", opts },
	    { 'n', 's', "<Append>d<Esc>", opts },
	    { 'n', 'd', "ie <Esc>", opts },
	    { 'n', 'f', "if <Esc>", opts },
	  }
})

-- vim.keymap.set("n", "<leader>mp", "<CMD>PitchMode<CR>")
