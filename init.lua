require('dkry')
require("config.lazy")

vim.opt.shiftwidth = 4 --changes tab width I believe
vim.opt.clipboard = "unnamedplus" --makes 'p' work w/ clipboard

--should enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

vim.g.moonflyVirtualTextColor = true
vim.cmd[[colorscheme moonfly]]

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}), 
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}), 
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
--sets space esc to exit terminal mode, normal esc can cause problems, this may as well
vim.keymap.set("t", "<space><Esc>", "<C-\\><C-n>")

--set runc to run latest compiled c program, could be used to build or make projects on the fly with keypresses, likely not as useful for individual file running 
--vim.keymap.set("n", "<space>runc", function()vim.fn.chansend(job_id, {"./a.out\r\n"})end)

local job_id = 0
--sets keymap to open lil baby terminal for execution
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0,7)

    job_id = vim.bo.channel
end)
