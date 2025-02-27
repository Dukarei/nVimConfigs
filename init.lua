require('dkry')
require("config.lazy")

vim.opt.shiftwidth = 4 --changes tab width I believe
vim.opt.clipboard = "unnamedplus" --makes 'p' work w/ clipboard

--should enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}), 
	callback = function()
		vim.highlight.on_yank()
	end,
})
