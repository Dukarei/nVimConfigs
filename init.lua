require('dkry')

require("config.lazy")

vim.opt.shiftwidth = 4 --changes tab width I believe
--vim.opt.clipboard:append("unnamedplus") --makes 'p' work w/ clipboard

vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
	["+"] = 'copyq add -',
	["*"] = 'copyq add -',
    },
    paste = {
	["+"] = 'copyq read 0',
	["*"] = 'copyq read 0',
    },
    cache_enabled = 1,
}

-- Copy/paste from system clipboard
vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')
-- Delete without changing the registers
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
--should enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

vim.g.moonflyVirtualTextColor = true
vim.g.moonflyUnderlineMatchParen = true
vim.cmd[[colorscheme moonfly]]

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}), 
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.diagnostic.config({virtual_text = true})

vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}), 
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
--sets space esc to exit terminal mode, normal esc can cause problems, this may as well
vim.keymap.set("t", "<space><Esc>", "<C-\\><C-n>")

on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
	vim.lsp.inlay_hint.enable(true)
    end
end

--set runc to run latest compiled c program, could be used to build or make projects on the fly with keypresses, likely not as useful for individual file running 
--vim.keymap.set("n", "<space>runc", function()vim.fn.chansend(job_id, {"./a.out\r\n"})end)

local job_id = 0
--sets keymap to open lil baby terminal for execution
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0,12)

    job_id = vim.bo.channel
end)

function find_last_of(str, char)
    local last_index = 0
    for i=1, #str do
	if str:sub(i,i) == char then
	    last_index = i
	end
    end
    return last_index
end

--make keycommands to autocompile jfx stuff(you need a $PATH_TO_FX var and fxml/swing are not included in this command)<-check openjfx.io
vim.keymap.set("n", "<space>jfxc", function()
    local fullname = vim.api.nvim_buf_get_name(0)
    local filename = fullname:sub(find_last_of(fullname, '/')+1, #fullname)
    vim.fn.chansend(job_id, {string.format("echo %s%s\r\njavac --module-path $PATH_TO_FX --add-modules javafx.web,javafx.media %s\r\n", "executing buffer: ", fullname, filename)})
end)
vim.keymap.set("n", "<space>jfxr", function()
    local fullname = vim.api.nvim_buf_get_name(0)
    local filename = fullname:sub(find_last_of(fullname, '/')+1, #fullname)
    vim.fn.chansend(job_id, {string.format("echo %s%s\r\njava --module-path $PATH_TO_FX --add-modules javafx.web,javafx.media %s\r\n", "executing buffer: ", fullname, filename:sub(1, find_last_of(filename, '.')-1))})
end)
