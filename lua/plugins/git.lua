return {
	{
		"kdheepak/lazygit.nvim",
		config = function()
			vim.keymap.set("n", "<leader>lg", ":LazyGitCurrentFile<CR>", {})
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", "Gitsigns preview_hunk<CR>", {})
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function ()
			require("gitblame").setup()
			vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR", {})
		end
	}
}
