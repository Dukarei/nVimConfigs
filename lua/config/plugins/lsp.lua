return {
    {
  "neovim/nvim-lspconfig",
  --dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- if you use nvim-cmp
    dependencies = {
	'saghen/blink.cmp',
	{
		"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
	    -- See the configuration section for more details
	    -- Load luvit types when the `vim.uv` word is found
	    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
	},
    },
    config = function() 
	local capabilities = require('blink.cmp').get_lsp_capabilities()
        --require'lspconfig'.clangd.setup{capabilities = capabilities}  
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {"jdtls", "html", "cssls", "pyright", "lua_ls", "ts_ls"}--clangd from Mason never works
	})
	--    ensure_installed = {"ts_ls", "html", "cssls"}--add java, clang, python, etc
--	})
	require("lspconfig").lua_ls.setup{capabilities = capabilities}--cmd = {'cd home/dkry/.config/lsp/lua-language-server/bin/ && ./lua-language-server'}}
	require("lspconfig").jdtls.setup{capabilities = capabilities}
	require("lspconfig").clangd.setup{capabilities = capabilities}
	require("lspconfig").pyright.setup{capabilities = capabilities}
	--require("lspconfig").ts_ls.setup{}
	require("lspconfig").html.setup{capabilities = capabilities}
	require("lspconfig").cssls.setup{capabilities = capabilities}
	require("typescript-tools").setup {capabilities = capabilities} --cmd = {'cd home/dkry/.config/lsp/lua-language-server/bin/ && ./lua-language-server'}}
	vim.api.nvim_create_autocmd('LspAttach', {
	    callback = function(args)
		local c = vim.lsp.get_client_by_id(args.data.client_id)
		if not c then return end
		on_attach(c, args.buf)
	    end,
	})
  end,
    }
}
