return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({})
		vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", {})
		vim.keymap.set("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>", {})
		vim.keymap.set("n", "<leader>cs", ":Trouble symbols toggle focus=false<CR>", {})
		vim.keymap.set("n", "<leader>cl", ":Trouble lsp toggle focus=false<CR>", {})
		vim.keymap.set("n", "<leader>xL", ":Trouble loclist toggle<CR>", {})
		vim.keymap.set("n", "<leader>xQ", ":Trouble qflist toggle<CR>", {})
	end
}
