return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Fu[Git]ive main console" })
		vim.keymap.set("n", "<leader>gp", "<cmd>Git pull<CR>", { desc = "Fu[Git]ive [p]ull (rebase)" })
		vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Fu[Git]ive [c]ommit console" })
		vim.keymap.set("n", "<leader>gP", "<cmd>Git push<CR>", { desc = "Fu[Git]ive [P]ush" })
	end,
}
