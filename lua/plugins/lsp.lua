local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	vimls = {},
	ts_ls = {},
	html = {},
	cssls = {},
	jsonls = {},
	pyright = {},
	ruff = {},
}

local function server_names()
	local names = vim.tbl_keys(servers)
	table.sort(names)
	return names
end

return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = server_names(),
			automatic_enable = true,
		},
		config = function(_, opts)
			vim.diagnostic.config({
				severity_sort = true,
				virtual_text = {
					source = "if_many",
					spacing = 2,
				},
				float = {
					border = "rounded",
					source = "if_many",
				},
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
			end

			local group = vim.api.nvim_create_augroup("CustomLsp", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = group,
				desc = "LSP actions",
				callback = function(event)
					local setmap = function(mode, keymap, fn)
						vim.keymap.set(mode, keymap, fn, { buffer = event.buf })
					end

					setmap("n", "gd", function()
						vim.lsp.buf.definition()
					end)
					setmap("n", "K", function()
						vim.lsp.buf.hover()
					end)
					setmap("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end)
					setmap("n", "[d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end)
					setmap("n", "]d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end)
					setmap("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end)
					setmap("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end)
					setmap("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end)
					setmap("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end)
				end,
			})

			require("mason-lspconfig").setup(opts)
		end,
	},
}
