local parsers = {
	"bash",
	"css",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
}

local filetypes = {
	"bash",
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"lua",
	"markdown",
	"python",
	"query",
	"typescript",
	"typescriptreact",
	"vim",
	"vimdoc",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		if type(treesitter.install) ~= "function" then
			require("nvim-treesitter.configs").setup({
				ensure_installed = parsers,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})

			return
		end

		treesitter.setup()
		treesitter.install(parsers)

		local group = vim.api.nvim_create_augroup("CustomTreesitter", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = filetypes,
			callback = function(event)
				local ok = pcall(vim.treesitter.start, event.buf)
				if ok then
					vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
