return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
	lazy = true,
	keys = {
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>pg",
			function()
				require("telescope.builtin").git_files()
			end,
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
		},
		{
			"<leader>pc",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
	},
}
