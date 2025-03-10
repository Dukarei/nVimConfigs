return {
    {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = 
	{
	    'nvim-lua/plenary.nvim',
	    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
	},
	config = function()
	    require('telescope').setup {
		pickers = {
		    find_files = {
			theme = "ivy" --sets filefinder popup to be cooler w/ file preview
		    }
		}
	    }
	    vim.keymap.set("n", "<space>tf", require('telescope.builtin').find_files)
--	    vim.keymap.set("n", "<space>th", require('telescope.builtin').find_files{cwd = "/home/dkry"})
	    --this one would enable 'tf' to go to a specific directory, in this instance the default config dir vim.keymap.set("n", "tf", require('telescope.builtin').find_files{cwd = vim.fn.stdpath("config")})
	end
    }
}
