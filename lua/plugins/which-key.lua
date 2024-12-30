return {
	"folke/which-key.nvim",
	config = function()
		local which_key = require("which-key")
		vim.keymap.set("n", "<leader>?", which_key.show, {})
	end
}
