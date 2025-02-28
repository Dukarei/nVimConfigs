return {
    {
  "neovim/nvim-lspconfig",
  --dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- if you use nvim-cmp
    dependencies = {
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
	--local capabilities = require('cmp_nvim_lsp').default_capabilities()
        --require'lspconfig'.clangd.setup{capabilities = capabilities}  
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {"jdtls", "html", "cssls", "pyright"}
	})
	--    ensure_installed = {"ts_ls", "html", "cssls"}--add java, clang, python, etc
--	})
	require("lspconfig").lua_ls.setup{}--cmd = {'cd home/dkry/.config/lsp/lua-language-server/bin/ && ./lua-language-server'}}
	require("lspconfig").jdtls.setup{}
	require("lspconfig").clangd.setup{}
	--require("lspconfig").ts_ls.setup{}
	require("lspconfig").html.setup{}
	require("lspconfig").cssls.setup{}
	require("typescript-tools").setup {} --cmd = {'cd home/dkry/.config/lsp/lua-language-server/bin/ && ./lua-language-server'}}
  end,
    }
}
