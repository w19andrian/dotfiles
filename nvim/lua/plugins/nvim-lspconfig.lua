return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here.
		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
		-- and elegantly composed help section, `:help lsp-vs-treesitter`

		require("plugins.nvim-lspconfig.lsp-attach")
		require("plugins.nvim-lspconfig.lsp-diagnostics")

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			gopls = require("plugins.nvim-lspconfig.servers.gopls"),
			lua_ls = require("plugins.nvim-lspconfig.servers.lua_ls"),
			markdown_oxide = require("plugins.nvim-lspconfig.servers.markdown_oxide"),
			bashls = require("plugins.nvim-lspconfig.servers.bashls"),
			terraformls = require("plugins.nvim-lspconfig.servers.terraformls"),
			ts_ls = require("plugins.nvim-lspconfig.servers.ts_ls"),
			html = require("plugins.nvim-lspconfig.servers.html"),
			yamlls = require("plugins.nvim-lspconfig.servers.yaml"),
		}

		-- Ensure the servers and tools above are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run
		--    :Mason
		--
		-- You can press `g?` for help in this menu.
		--
		-- `mason` had to be setup earlier: to configure its options see the
		-- `dependencies` table for `nvim-lspconfig` above.
		--
		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		local ensure_installed = vim.tbl_keys(servers or {})

		for _, server in pairs(servers) do
			if server.tools then
				vim.list_extend(ensure_installed, server.tools)
			end
		end

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Propagate custom config from each LSP servers
		for k, _ in pairs(servers) do
			local svr = servers[k] or {}
			svr.tools = nil
			vim.lsp.config(k, svr)
		end
		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}
