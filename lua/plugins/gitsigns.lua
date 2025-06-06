return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

            -- stylua: ignore start
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Prev Hunk")
            map("n", "<leader>ghu", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>ghp", gs.reset_hunk, "Reset Hunk")
            map("n", "<leader>ghk", function() gs.blame_line({ full = true }) end, "Blame Line")
		end,
	},
}
