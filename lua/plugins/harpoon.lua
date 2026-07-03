return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	config = function()
		require("harpoon"):setup()
	end,
	keys = function()
		return {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
			},

			{
				"<C-h>",
				function()
					require("harpoon"):list():select(1)
				end,
			},
			{
				"<C-t>",
				function()
					require("harpoon"):list():select(2)
				end,
			},
			{
				"<C-n>",
				function()
					require("harpoon"):list():select(3)
				end,
			},
			{
				"<C-s>",
				function()
					require("harpoon"):list():select(4)
				end,
			},
		}
	end,
}
