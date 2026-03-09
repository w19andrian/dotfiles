require("defaults")

require("lazy").setup({
	require("plugins.guess-indent"),
	require("plugins.gitsigns"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.debug"),
	require("plugins.lazydev"),
	require("plugins.nvim-lspconfig"),
	require("plugins.conform"),
	require("plugins/fugitive"),
	require("plugins.blink-cmp"),
	require("plugins.todo-comments"),
	require("plugins.mini"),
	require("plugins.treesitter"),
	require("plugins.lint"),
	require("plugins.autopairs"),
	require("plugins.indent_line"),
	require("plugins.nvim-ts-autotag"),

	{ import = "colorschemes" },
}, {
	ui = {
		-- Set icons to an empty table which will use the default lazy.nvim defined Nerd Font icons,
		-- otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

vim.cmd.colorscheme("vesper")
