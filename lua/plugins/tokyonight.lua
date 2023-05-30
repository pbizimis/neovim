return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	opts = {
		transparent = true,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd([[colorscheme tokyonight-night]])
	end,
}
