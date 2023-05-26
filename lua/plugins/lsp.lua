return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neodev.nvim", opts = {} },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function()
                    local setmap = function(mode, keymap, fn)
                        local opts = { buffer = true }
                        vim.keymap.set(mode, keymap, fn, opts)
                    end

                    setmap("n", "gd", function() vim.lsp.buf.definition() end)
                    setmap("n", "K", function() vim.lsp.buf.hover() end)
                    setmap("n", "<leader>vd", function() vim.diagnostic.open_float() end)
                    setmap("n", "[d", function() vim.diagnostic.goto_next() end)
                    setmap("n", "]d", function() vim.diagnostic.goto_prev() end)
                    setmap("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
                    setmap("n", "<leader>vrr", function() vim.lsp.buf.references() end)
                    setmap("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
                    setmap("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
                end
            })

            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {}
            })

            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Opt to list sources here, when available in mason.
                },
                automatic_installation = false,
                handlers = {},
            })
            require("null-ls").setup({
                sources = {
                    -- Anything not supported by mason.
                }
            })
        end,
    }
}
