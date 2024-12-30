return {
	'akinsho/bufferline.nvim',
	config = function()
		require("bufferline").setup({})
        vim.keymap.set('n', '<leader>bco', ':BufferLineCloseOthers<CR>', {})
	end
}
