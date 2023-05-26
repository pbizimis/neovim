return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    },
    opts = function()
        local cmp = require "cmp"
        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = cmp.config.sources {
                { name = "path" },
                { name = "nvim_lsp", keyword_length = 1 },
                { name = "buffer",   keyword_length = 3 },
                { name = 'luasnip',  keyword_length = 2 },
            },
            window = {
                documentation = cmp.config.window.bordered()
            },
        }
    end,
}
